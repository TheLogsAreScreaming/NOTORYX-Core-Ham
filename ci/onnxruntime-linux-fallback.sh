#!/usr/bin/env bash
# The flutter_onnxruntime plugin downloads ONNX Runtime for Linux from
# Microsoft's GitHub releases while CMake runs. When that download is
# unavailable, this fills the plugin's download folder from Microsoft's NuGet
# package instead, so CMake finds the files and skips its own download.
#
# Run after `flutter pub get`, before `flutter build linux --release`.
# Does nothing when the GitHub download works.
set -euo pipefail

mode="${1:-release}"
arch=x64

plugin_root="$(python3 - <<'EOF'
import json, pathlib, urllib.parse
config = json.loads(pathlib.Path('.dart_tool/package_config.json').read_text())
for p in config['packages']:
    if p['name'] == 'flutter_onnxruntime':
        uri = p['rootUri']
        path = urllib.parse.urlparse(uri).path if uri.startswith('file:') else uri
        base = pathlib.Path('.dart_tool').resolve()
        print((base / path).resolve() if not path.startswith('/') else path)
EOF
)"
if [ -z "$plugin_root" ]; then
  echo "flutter_onnxruntime is not a dependency; nothing to do."
  exit 0
fi

version="$(sed -n 's/.*set(ONNXRUNTIME_VERSION "\([0-9.]*\)").*/\1/p' \
  "$plugin_root/linux/CMakeLists.txt" | head -1)"
if [ -z "$version" ]; then
  echo "::error::Could not read the plugin's ONNX Runtime version."
  exit 1
fi

github_url="https://github.com/microsoft/onnxruntime/releases/download/v${version}/onnxruntime-linux-${arch}-${version}.tgz"
if curl -fsIL --retry 3 -o /dev/null "$github_url"; then
  echo "ONNX Runtime ${version} is available on GitHub; the plugin will download it."
  exit 0
fi

# Same version from NuGet if it exists, otherwise the newest patch release
# of the same major.minor, which has the same C API.
nuget_version="$(curl -fsSL --retry 3 \
  https://api.nuget.org/v3-flatcontainer/microsoft.ml.onnxruntime/index.json |
  python3 -c '
import json, sys
want = sys.argv[1]
minor = ".".join(want.split(".")[:2])
versions = [v for v in json.load(sys.stdin)["versions"] if "-" not in v]
if want in versions:
    print(want)
else:
    same = [v for v in versions if v.startswith(minor + ".")]
    print(max(same, key=lambda v: [int(x) for x in v.split(".")]) if same else "")
' "$version")"
if [ -z "$nuget_version" ]; then
  echo "::error::ONNX Runtime ${version} is not on GitHub and no ${version%.*}.x is on NuGet."
  exit 1
fi

echo "::warning::ONNX Runtime ${version} could not be downloaded from GitHub; using ${nuget_version} from NuGet."

# CMake looks for this exact folder (named after the plugin's version).
dest="build/linux/${arch}/${mode}/plugins/flutter_onnxruntime/onnxruntime/onnxruntime-linux-${arch}-${version}"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
curl -fsSL --retry 3 -o "$work/ort.nupkg" \
  "https://api.nuget.org/v3-flatcontainer/microsoft.ml.onnxruntime/${nuget_version}/microsoft.ml.onnxruntime.${nuget_version}.nupkg"
unzip -q "$work/ort.nupkg" 'build/native/include/*' "runtimes/linux-${arch}/native/*" -d "$work/pkg"

mkdir -p "$dest/include" "$dest/lib"
cp "$work"/pkg/build/native/include/* "$dest/include/"
cp "$work"/pkg/runtimes/linux-${arch}/native/libonnxruntime*.so* "$dest/lib/"
test -f "$dest/include/onnxruntime_cxx_api.h"
test -f "$dest/lib/libonnxruntime.so"
echo "Placed ONNX Runtime ${nuget_version} in ${dest}:"
ls -l "$dest/lib"

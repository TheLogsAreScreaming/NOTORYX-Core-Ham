#!/usr/bin/env python3
"""Lists Flutter code an accessibility review should look at.

Run from the repo root. These are candidates for a person to check, not
confirmed defects. Rendered screens are checked by test/preview with
PREVIEW_A11Y=1; a screen reader on a real phone is checked by hand.
"""
import collections
import glob
import re


def call_body(source, open_paren):
    depth = 0
    for i in range(open_paren, len(source)):
        if source[i] == "(":
            depth += 1
        elif source[i] == ")":
            depth -= 1
            if depth == 0:
                return source[open_paren : i + 1]
    return source[open_paren:]


found = collections.defaultdict(list)
files = [f for f in glob.glob("lib/**/*.dart", recursive=True) if "/l10n/" not in f]
for path in files:
    source = open(path, encoding="utf-8").read()
    where = lambda m: f"{path}:{source[: m.start()].count(chr(10)) + 1}"
    for m in re.finditer(r"\bIconButton(\.(?!styleFrom)\w+)?\(", source):
        if "tooltip" not in call_body(source, m.end() - 1):
            found["IconButton without a tooltip"].append(where(m))
    for m in re.finditer(r"\b(GestureDetector|InkWell)\(", source):
        body = call_body(source, m.end() - 1)
        before = source[max(0, m.start() - 160) : m.start()]
        if "onTap" in body and "Semantics(" not in before and "Text(" not in body and "label" not in body:
            found[f"{m.group(1)} tap with no text or Semantics"].append(where(m))
    for m in re.finditer(r"withClampedTextScaling|textScaleFactor|TextScaler\.noScaling", source):
        found["Text scaling override"].append(where(m))

print(f"Scanned {len(files)} files")
for kind, places in sorted(found.items()):
    print(f"\n{kind}: {len(places)}")
    for place in places:
        print(f"  {place}")
if not found:
    print("No candidates")

# Contributing to Bastion

Thanks for helping improve Bastion.

## Before opening a pull request

Use this repository's **Issues** tab to check whether the bug or feature request is already being discussed. For larger changes, open an issue first so the implementation can be agreed on before code is written.

Keep pull requests focused. Avoid mixing unrelated refactors, formatting changes, and features in the same change.

## Development checks

Before submitting changes, run:

```bash
dart format .
flutter analyze
flutter test
```

Android changes should also be validated with an ARM64 release build when practical:

```bash
flutter build apk --release --target-platform android-arm64 --target lib/main.dart
```

## Pull requests

- Base work on the current active development branch.
- Give the PR a clear title and description.
- Link the relevant issue when one exists.
- Explain user-visible behavior changes.
- Include screenshots for meaningful UI changes.
- Preserve required third-party license and attribution notices.
- Do not copy proprietary source code, assets, or UI from closed-source clients.

## AI-assisted contributions

AI tools are allowed, but contributors are responsible for the resulting code.

- Review and understand generated code before submitting it.
- Keep AI-assisted changes tightly scoped to the task.
- Do not submit large, unexplained code dumps.
- Verify that generated code does not introduce incompatible licensing or copied proprietary material.

---
name: ios-migration-check
description: >-
  Checks whether a template's generated iOS project drifts on its first
  Flutter build, caused by Flutter's built-in iOS project migrations, and
  folds the migrated files back into the brick.
when_to_use: >-
  Use after bumping the Flutter SDK version a template targets, or when a
  freshly generated app shows unexpected changes under ios/ after its first
  flutter build or flutter run.
allowed-tools: Read Glob Grep Bash Edit
---

# iOS Migration Check

Flutter applies its own migrations to iOS projects on the first build. It
rewrites settings that are behind its baseline, such as the deployment target,
`MinimumOSVersion`, `LastUpgradeCheck` and scheme attributes. If a template
falls behind, every generated app gets an unexpected diff after its first
build. CI does not catch this, because it never builds iOS.

---

## Detect drift

Run from the repo root. Replace `very_good_core` with any template that ships
an `ios/` directory.

```bash
mason make very_good_core -c very_good_core/config.json \
  --on-conflict overwrite -o very_good_core_output
cd very_good_core_output
git init -q && git add -A && git commit -qm init
flutter pub get
# Repeat per flavor scheme in ios/Runner.xcodeproj/xcshareddata/xcschemes/
flutter build ios --config-only --no-codesign --debug \
  --flavor development -t lib/main_development.dart
# Also build without a flavor to cover the Runner scheme
flutter build ios --config-only --no-codesign --debug \
  -t lib/main_development.dart
git status --short ios
```

Any output from `git status` is drift. Build every flavor and once without a
flavor: some migrations only touch the scheme being built. The no-flavor build
may fail on a missing `Debug` configuration, but migrations run before that.

---

## Fix drift

- For template files without Mustache tags, copy Flutter's migrated file back
  into `__brick__/`.
- For files that have Mustache tags (for example `project.pbxproj`), apply the
  same change by hand.

Re-run the detection steps until `git status` prints nothing.

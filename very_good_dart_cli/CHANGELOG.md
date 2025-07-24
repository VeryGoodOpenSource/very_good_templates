# 1.0.0

refactor(very_good_dart_cli)!: remove root-level project_name folder from brick structure.

## Migration details

The `very_good_dart_cli` brick no longer includes a top-level project name folder.
This allows generating the project directly into the current or a custom directory.

If you prefer to keep the output inside its own folder (as before), use the -o flag:

```dart
// Before:
mason make very_good_dart_cli

// After:
mason make very_good_dart_cli -o ./output_folder
```

# 0.10.1

- test: add missing test [#278](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/278)

# 0.10.0

- chore(deps): bump very_good_analysis from 6.0.0 to 7.0.0 in /very_good_dart_cli/hooks [#236](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/236)
- chore: tighten template dependencies [#237](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/237)
- fix: evaluate brick output correctly on ci [#248](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/248)
- chore: update to Flutter 3.29 and Dart 3.7 [#250](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/250)
- chore: update flutter 3.32.0 and dart 3.8.0 [#253](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/253)
- chore: tighten template dependencies [#243](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/243)
- chore: bump very_good_analysis to 9.0.0 [#261](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/261)

# 0.9.0

- chore: update to Flutter 3.27 and Dart 3.6 ([#223](https://github.com/VeryGoodOpenSource/very_good_templates/pull/223))
- feat: update pull request templates to add `test` type option ([#214](https://github.com/VeryGoodOpenSource/very_good_templates/pull/214))
- chore: tighten template dependencies ([#194](https://github.com/VeryGoodOpenSource/very_good_templates/pull/194), [#198](https://github.com/VeryGoodOpenSource/very_good_templates/pull/198), [#203](https://github.com/VeryGoodOpenSource/very_good_templates/pull/203), [#211](https://github.com/VeryGoodOpenSource/very_good_templates/pull/211), [#220](https://github.com/VeryGoodOpenSource/very_good_templates/pull/220), [#221](https://github.com/VeryGoodOpenSource/very_good_templates/pull/221))

# 0.8.0

- feat: update to Flutter 3.24 and Dart 3.5 ([#177](https://github.com/VeryGoodOpenSource/very_good_templates/pull/177))
- chore: tighten template dependencies ([#173](https://github.com/VeryGoodOpenSource/very_good_templates/pull/173), [#178](https://github.com/VeryGoodOpenSource/very_good_templates/pull/178))

# 0.7.2

- chore: tighten template dependencies ([#146](https://github.com/VeryGoodOpenSource/very_good_templates/pull/146), [#149](https://github.com/VeryGoodOpenSource/very_good_templates/pull/149))

# 0.7.1

- chore: update to Very Good Analysis 6.0.0 ([#135](https://github.com/VeryGoodOpenSource/very_good_templates/pull/135))
- chore: tighten template dependencies ([#137](https://github.com/VeryGoodOpenSource/very_good_templates/pull/137))

# 0.7.0

- feat!: ensure template uses Dart 3.4 ([#99](https://github.com/VeryGoodOpenSource/very_good_templates/pull/99))

# 0.6.1

- refactor: remove explicitly named libraries ([#77](https://github.com/VeryGoodOpenSource/very_good_templates/pull/77))

# 0.6.0

- build(deps): bump pub_updater from 0.3.1 to 0.4.0 ([#116](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/116))
- build(deps): bump cli_completion from 0.3.0 to 0.4.0 ([#115](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/115))
- fix: sort directive ordering on post generation ([#122](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/122))
- feat: hook performs dart pub get ([#123](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/123))
- refactor: remove generator script ([#120](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/120))
- chore: migrate very_good_dart_cli ([#3](https://github.com/VeryGoodOpenSource/very_good_templates/pull/3))
- feat!: update to Dart 3.3.0 ([#22](https://github.com/VeryGoodOpenSource/very_good_templates/pull/22))
- chore: update bricks to Mason 0.1.0-dev.52 ([#28](https://github.com/VeryGoodOpenSource/very_good_templates/pull/28))

# 0.5.1

- feat: upgrade to very_good_analysis ^5.1.0

# 0.5.0

- feat: update very good analysis to v5 and fix patch
- feat: bump Dart SDK to >=3.0.0 <4.0.0

# 0.4.0

- feat!: bump min Dart SDK to 2.19.0

# 0.3.3

- chore: support dart sdk 2.18.0

# 0.3.2

- feat: update workflows, add spellcheck
- fix: remove unused pub updater from test

# 0.3.1

- feat: upgrade to `very_good_analysis 4.0.0`

# 0.3.0

- feat: add completion

# 0.2.3

- feat: upgrade to Dart 2.19

# 0.2.2

- fix: update silently fails when the sdk doesn't support most recent version

# 0.2.1

- fix: windows path resolution
- feat: add ci concurrency group to workflow

# 0.2.0

- **BREAKING** feat: add `publishable` flag (defaults to `false`)

# 0.1.4

- docs: remove copyright header and license from generated code

# 0.1.3

- fix: update prompt on update

# 0.1.2

- chore(deps): upgrade to mason_logger 0.2.0
- fix: use available global constant for executable name

# 0.1.1

- feat: upgrade to very_good_analysis 3.1.0

# 0.1.0

- feat: upgrade to Dart 2.18
- feat: upgrade to very_good_analysis 3.0.2
- feat: add dependabot integration

# 0.0.1

- feat: initial release 🎉

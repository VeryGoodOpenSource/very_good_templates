# 1.0.0

refactor(very_good_core)!: remove root-level project_name folder from brick structure.

## Migration details

The `very_good_core` brick no longer includes a top-level project name folder.
This allows generating the project directly into the current or a custom directory.

If you prefer to keep the output inside its own folder (as before), use the -o flag:

```dart
// Before:
mason make very_good_core

// After:
mason make very_good_core -o ./output_folder
```

# 0.11.1 

- docs: update test command in very good core README ([#287](https://github.com/VeryGoodOpenSource/very_good_templates/pull/287))
- chore(very_good_core): deprecated script-based application of the flutter gradle plugin ([#249](https://github.com/VeryGoodOpenSource/very_good_templates/pull/249))
- chore(very_good_core): update format on MainActivity.kt ([#290](https://github.com/VeryGoodOpenSource/very_good_templates/pull/290))
- fix(android): correct source sets to ensure plugin compatibility ([#292](https://github.com/VeryGoodOpenSource/very_good_templates/pull/292))

# 0.11.0

- chore(deps): bump very_good_analysis from 6.0.0 to 7.0.0 in /very_good_core/hooks [#233](https://github.com/VeryGoodOpenSource/very_good_templates/pull/233)
- chore: tighten template dependencies [#237](https://github.com/VeryGoodOpenSource/very_good_templates/pull/237)
- chore: tighten template dependencies [#240](https://github.com/VeryGoodOpenSource/very_good_templates/pull/240)
- fix: evaluate brick output correctly on ci [#248](https://github.com/VeryGoodOpenSource/very_good_templates/pull/248)
- chore: update to Flutter 3.29 and Dart 3.7 [#250](https://github.com/VeryGoodOpenSource/very_good_templates/pull/250)
- chore: update flutter 3.32.0 and dart 3.8.0 [#253](https://github.com/VeryGoodOpenSource/very_good_templates/pull/253)
- chore: tighten template dependencies [#243](https://github.com/VeryGoodOpenSource/very_good_templates/pull/243)
- fix(very_good_core): Update concurrency group name template [#255](https://github.com/VeryGoodOpenSource/very_good_templates/pull/255)
- chore: bump very_good_analysis to 9.0.0 [#261](https://github.com/VeryGoodOpenSource/very_good_templates/pull/261)

# 0.10.0

- feat: update pull request templates to add `test` type option ([#214](https://github.com/VeryGoodOpenSource/very_good_templates/pull/214))
- chore: update to Flutter 3.27 and Dart 3.6 ([#223](https://github.com/VeryGoodOpenSource/very_good_templates/pull/223))

# 0.9.0

- chore: update copyright year in Windows Runner.rc ([#188](https://github.com/VeryGoodOpenSource/very_good_templates/pull/188))
- refactor: move current_year out from configuration ([#193](https://github.com/VeryGoodOpenSource/very_good_templates/pull/193))
- fix: update android build versions ([#205](https://github.com/VeryGoodOpenSource/very_good_templates/pull/205))

# 0.8.0

- feat: update to Flutter 3.24 and Dart 3.5 ([#177](https://github.com/VeryGoodOpenSource/very_good_templates/pull/177))

# 0.7.2

- fix: update application identifier usage ([#148](https://github.com/VeryGoodOpenSource/very_good_templates/pull/148))
- feat: use application id on macOS project ([#159](https://github.com/VeryGoodOpenSource/very_good_templates/pull/159))
- fix: default id when application id is empty ([#165](https://github.com/VeryGoodOpenSource/very_good_templates/pull/165))

# 0.7.1

- style: Adding extra space to the application opening tag ([#126](https://github.com/VeryGoodOpenSource/very_good_templates/pull/126))
- chore: update Java versions on Very Good Core ([#128](https://github.com/VeryGoodOpenSource/very_good_templates/pull/128))
- chore: update to Very Good Analysis 6.0.0 ([#135](https://github.com/VeryGoodOpenSource/very_good_templates/pull/135))
- chore: tighten template dependencies ([#137](https://github.com/VeryGoodOpenSource/very_good_templates/pull/137))

# 0.7.0

- feat!: ensure template uses Flutter 3.22 with Dart 3.4 ([#97](https://github.com/VeryGoodOpenSource/very_good_templates/pull/97))
- fix: update index.html to support latest convention ([#106](https://github.com/VeryGoodOpenSource/very_good_templates/pull/106))

# 0.6.1

- fix: deprecated imperative apply of Flutter's Gradle plugins ([#70](https://github.com/VeryGoodOpenSource/very_good_templates/pull/70))

# 0.6.0

- chore: migrate very_good_core ([#1](https://github.com/VeryGoodOpenSource/very_good_templates/pull/1))
- feat!: update to Flutter 3.19.0 ([#24](https://github.com/VeryGoodOpenSource/very_good_templates/pull/24))
- chore: update bricks to Mason 0.1.0-dev.52 ([#28](https://github.com/VeryGoodOpenSource/very_good_templates/pull/28))

# 0.5.1

- feat: minify icon pngs ([#317](https://github.com/VeryGoodOpenSource/very_good_core/pull/317))
- fix: templated project name for Release-production flavor ([#319](https://github.com/VeryGoodOpenSource/very_good_core/pull/319))

# 0.5.0

- feat: change launchMode on Android to singleTask ([#297](https://github.com/VeryGoodOpenSource/very_good_core/pull/297))
- feat: add macOS platform support ([#299](https://github.com/VeryGoodOpenSource/very_good_core/pull/299))
- refactor: remove generator script ([#306](https://github.com/VeryGoodOpenSource/very_good_core/pull/306))
- docs: update semantic commit link ([#313](https://github.com/VeryGoodOpenSource/very_good_core/pull/313))
- fix: regenerate ios directory ([#310](https://github.com/VeryGoodOpenSource/very_good_core/pull/310))

# 0.4.0

- feat!: bump min Dart SDK to 3.1.0
- feat!: update to Flutter 3.13.2
- fix: added RunnerTests iOS Schema
- feat: update to Material 3
- docs: update l10n README documentation
- docs: translation generation in README.md
- fix: very_good create flutter_app doesn't create .gradlew files
- feat: upgrade to `very_good_analysis ^5.1.0`

# 0.3.0

- feat!: update to Flutter 3.10.0
- fix: use valid app label
- feat: update bloc

# 0.2.0

- feat!: bump min Dart SDK to 2.19.0

# 0.1.15

- chore: support dart sdk 2.18.0
- fix: rollback very_good_analysis to 3.1.0
- test: include e2e test

# 0.1.14

- feat: update workflows and add spellcheck
- chore: remove explicit Flutter version constraint

# 0.1.13

- feat: upgrade to `very_good_analysis ^4.0.0`

# 0.1.12

- feat: upgrade bloc
  - bloc ^8.1.1
  - flutter_bloc ^8.1.2
  - bloc_test ^9.1.1
- feat: upgrade to Flutter 3.7.1

# 0.1.11

- feat: upgrade to Flutter 3.7.0

# 0.1.10

- fix: pre_gen.dart recase extension fix

# 0.1.9

- feat: upgrade to Flutter 3.3.10
- feat: upgrade to mason v0.1.0-dev.40
- fix: use correct description in index.html

# 0.1.8

- docs: remove copyright header and license from generated code
- feat: use flavor app name for the bundle name

# 0.1.7

- feat: upgrade to Flutter 3.3.8
- feat: add optional `applicationId`

# 0.1.6

- feat: upgrade to Flutter 3.3.7

# 0.1.5

- feat: upgrade to Flutter 3.3.6
- fix: add support for `GlobalCupertinoLocalizations`

# 0.1.4

- feat: fix dependabot config file

# 0.1.3

- feat: upgrade to Flutter 3.3.3

# 0.1.2

- feat: upgrade to Flutter 3.3.2
- feat: upgrade to very_good_analysis ^3.1.0

# 0.1.1

- feat: upgrade to Flutter 3.3.1
- feat: upgrade to very_good_analysis ^3.0.2
- feat: add dependabot integration

# 0.1.0

- feat: upgrade to Flutter 3.3 and Dart 2.18

# 0.0.1

- feat: initial release 🎉

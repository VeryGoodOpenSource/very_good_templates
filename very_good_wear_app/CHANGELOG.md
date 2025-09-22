## 1.0.0

refactor(very_good_wear_app)!: remove root-level project_name folder from brick structure.

### Migration details

The `very_good_wear_app` brick no longer includes a top-level project name folder.
This allows generating the project directly into the current or a custom directory.

If you prefer to keep the output inside its own folder (as before), use the -o flag:

```dart
// Before:
mason make very_good_wear_app

// After:
mason make very_good_wear_app -o ./output_folder
```

## [1.1.0](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_wear_app-v1.0.0...very_good_wear_app-v1.1.0) (2025-09-22)


### Features

* upgrade to flutter 3.35.0 ([#342](https://github.com/VeryGoodOpenSource/very_good_templates/issues/342)) ([6818041](https://github.com/VeryGoodOpenSource/very_good_templates/commit/681804198c03a6ab255802cedc15242832928e54))
* upgrade to very_good_analysis 10.0.0 ([#346](https://github.com/VeryGoodOpenSource/very_good_templates/issues/346)) ([5a7d0dc](https://github.com/VeryGoodOpenSource/very_good_templates/commit/5a7d0dc7323a77583158acfbbe933a60302ed532))
* upgraded plugin version and removed jdk7 dependency on build.kts ([#339](https://github.com/VeryGoodOpenSource/very_good_templates/issues/339)) ([8e60971](https://github.com/VeryGoodOpenSource/very_good_templates/commit/8e6097152174368e8923024ef1b2bf35f4a675ac))


### Miscellaneous Chores

* automate releases ([#319](https://github.com/VeryGoodOpenSource/very_good_templates/issues/319)) ([17fb3a5](https://github.com/VeryGoodOpenSource/very_good_templates/commit/17fb3a5c742a42e7fff70b269deea961e4a15b4f))
* **very_good_wear_app:** migrates Groovy scripts to Kotlin DSL ([#317](https://github.com/VeryGoodOpenSource/very_good_templates/issues/317)) ([aa8f4df](https://github.com/VeryGoodOpenSource/very_good_templates/commit/aa8f4df464f7e620a16799c39af638cceb4a6b97))

## 0.9.0

- chore(deps): bump very_good_analysis from 6.0.0 to 7.0.0 in /very_good_wear_app/hooks [#234](https://github.com/VeryGoodOpenSource/very_good_templates/pull/234)
- chore: tighten template dependencies [#237](https://github.com/VeryGoodOpenSource/very_good_templates/pull/237)
- chore: tighten template dependencies [#240](https://github.com/VeryGoodOpenSource/very_good_templates/pull/240)
- fix: evaluate brick output correctly on ci [#248](https://github.com/VeryGoodOpenSource/very_good_templates/pull/248)
- chore: update to Flutter 3.29 and Dart 3.7 [#250](https://github.com/VeryGoodOpenSource/very_good_templates/pull/250)
- chore: update flutter 3.32.0 and dart 3.8.0 [#253](https://github.com/VeryGoodOpenSource/very_good_templates/pull/253)
- chore: tighten template dependencies [#243](https://github.com/VeryGoodOpenSource/very_good_templates/pull/243)
- chore: bump very_good_analysis to 9.0.0 [#261](https://github.com/VeryGoodOpenSource/very_good_templates/pull/261)

## 0.8.0

- feat: update pull request templates to add `test` type option ([#214](https://github.com/VeryGoodOpenSource/very_good_templates/pull/214))
- chore: update to Flutter 3.27 and Dart 3.6 ([#223](https://github.com/VeryGoodOpenSource/very_good_templates/pull/223))

## 0.7.0

- fix: update android build versions ([#205](https://github.com/VeryGoodOpenSource/very_good_templates/pull/205))

## 0.6.0

- feat: update to Flutter 3.24 and Dart 3.5 ([#177](https://github.com/VeryGoodOpenSource/very_good_templates/pull/177))

## 0.5.2

- chore: remove legacy package tag in AndroidManifest.xml ([#161](https://github.com/VeryGoodOpenSource/very_good_templates/pull/161))

## 0.5.1

- style: Adding extra space to the application opening tag ([#126](https://github.com/VeryGoodOpenSource/very_good_templates/pull/126))
- chore: update to Very Good Analysis 6.0.0 ([#135](https://github.com/VeryGoodOpenSource/very_good_templates/pull/135))
- chore: tighten template dependencies ([#137](https://github.com/VeryGoodOpenSource/very_good_templates/pull/137))

## 0.5.0

- feat!: ensure template uses Flutter 3.22 with Dart 3.4 ([#104](https://github.com/VeryGoodOpenSource/very_good_templates/pull/104))

## 0.4.1

- fix: deprecated imperative apply of Flutter's Gradle plugins ([#79](https://github.com/VeryGoodOpenSource/very_good_templates/pull/79))

## 0.4.0

- test: add tests for pre generation hook ([#41](https://github.com/VeryGoodOpenSource/very_good_wear_app/pull/41))
- refactor: remove generator script ([#39](https://github.com/VeryGoodOpenSource/very_good_wear_app/pull/39))
- chore: migrate very_good_wear_app ([#2](https://github.com/VeryGoodOpenSource/very_good_templates/pull/2))
- feat!: update to Flutter 3.19.0 ([#27](https://github.com/VeryGoodOpenSource/very_good_templates/pull/27))
- chore: update bricks to Mason 0.1.0-dev.52 ([#28](https://github.com/VeryGoodOpenSource/very_good_templates/pull/28))

## 0.3.0

- feat!: update to Flutter 3.13.2
- feat: update to Material 3
- fix: project doesn't build due to kotlin gradle plugin incompatibility
- fix: very_good create flutter_app doesn't create .gradlew files
- feat: upgrade to `very_good_analysis ^5.1.0`

## 0.2.0

- feat!: bump min Dart SDK to 3.0.0

## 0.1.0

- docs: fixed VeryGoodCore typo
- feat!: bump min Dart SDK to 2.19.0

## 0.0.1

- feat: add brick generator
- add template application base

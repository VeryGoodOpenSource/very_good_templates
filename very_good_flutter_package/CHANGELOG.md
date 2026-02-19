# Changelog

## [1.3.0](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_flutter_package-v1.2.0...very_good_flutter_package-v1.3.0) (2026-02-19)


### Features

* upgrade to dart 3.11 and flutter 3.41 ([#429](https://github.com/VeryGoodOpenSource/very_good_templates/issues/429)) ([46ae490](https://github.com/VeryGoodOpenSource/very_good_templates/commit/46ae490823ef6f5f3addef6159a24870f66e931e))
* upgrade to very_good_analysis 10.2.0 ([#437](https://github.com/VeryGoodOpenSource/very_good_templates/issues/437)) ([be16183](https://github.com/VeryGoodOpenSource/very_good_templates/commit/be161834e90f0381d3535c9bd3b5f44ba6ea19ba))

## [1.2.0](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_flutter_package-v1.1.0...very_good_flutter_package-v1.2.0) (2026-02-06)


### Features

* add license check workflow to templates ([#422](https://github.com/VeryGoodOpenSource/very_good_templates/issues/422)) ([bd280c0](https://github.com/VeryGoodOpenSource/very_good_templates/commit/bd280c00f90126856a5fe70d6417e1c83d20f74b))
* upgrade to flutter 3.38.1 ([#394](https://github.com/VeryGoodOpenSource/very_good_templates/issues/394)) ([e436d76](https://github.com/VeryGoodOpenSource/very_good_templates/commit/e436d7606b0998fc5231d3bd1fd0c4650d0c8ae8))


### Bug Fixes

* update changelog's format ([#371](https://github.com/VeryGoodOpenSource/very_good_templates/issues/371)) ([6c5d53d](https://github.com/VeryGoodOpenSource/very_good_templates/commit/6c5d53d50d37dbd4fc88e3154f05ab283120e59f))


### Miscellaneous Chores

* bump very_good_analysis to 10.1.0 ([#400](https://github.com/VeryGoodOpenSource/very_good_templates/issues/400)) ([0c454c4](https://github.com/VeryGoodOpenSource/very_good_templates/commit/0c454c4166cf4e01c659ab723c5f94fc1a2edaa6))

## [1.1.0](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_flutter_package-v1.0.0...very_good_flutter_package-v1.1.0) (2025-09-22)


### Features

* upgrade to flutter 3.35.0 ([#342](https://github.com/VeryGoodOpenSource/very_good_templates/issues/342)) ([6818041](https://github.com/VeryGoodOpenSource/very_good_templates/commit/681804198c03a6ab255802cedc15242832928e54))
* upgrade to very_good_analysis 10.0.0 ([#346](https://github.com/VeryGoodOpenSource/very_good_templates/issues/346)) ([5a7d0dc](https://github.com/VeryGoodOpenSource/very_good_templates/commit/5a7d0dc7323a77583158acfbbe933a60302ed532))


### Miscellaneous Chores

* automate releases ([#319](https://github.com/VeryGoodOpenSource/very_good_templates/issues/319)) ([17fb3a5](https://github.com/VeryGoodOpenSource/very_good_templates/commit/17fb3a5c742a42e7fff70b269deea961e4a15b4f))

## 1.0.0

refactor(very_good_flutter_package)!: remove root-level project_name folder from brick structure.

### Migration details

The `very_good_flutter_package` brick no longer includes a top-level project name folder.
This allows generating the project directly into the current or a custom directory.

If you prefer to keep the output inside its own folder (as before), use the -o flag:

```dart
// Before:
mason make very_good_flutter_package

// After:
mason make very_good_flutter_package -o ./output_folder
```

## 0.9.0

- chore: tighten template dependencies [#237](https://github.com/VeryGoodOpenSource/very_good_templates/pull/237)
- fix: evaluate brick output correctly on ci [#248](https://github.com/VeryGoodOpenSource/very_good_templates/pull/248)
- chore: update to Flutter 3.29 and Dart 3.7 [#250](https://github.com/VeryGoodOpenSource/very_good_templates/pull/250)
- chore: update flutter 3.32.0 and dart 3.8.0 [#253](https://github.com/VeryGoodOpenSource/very_good_templates/pull/253)
- chore: tighten template dependencies [#243](https://github.com/VeryGoodOpenSource/very_good_templates/pull/243)
- chore: bump very_good_analysis to 9.0.0 [#261](https://github.com/VeryGoodOpenSource/very_good_templates/pull/261)

## 0.8.0

- feat: update pull request templates to add `test` type option ([#214](https://github.com/VeryGoodOpenSource/very_good_templates/pull/214))
- chore: update to Flutter 3.27 and Dart 3.6 ([#223](https://github.com/VeryGoodOpenSource/very_good_templates/pull/223))

## 0.7.0

- feat: update to Flutter 3.24 and Dart 3.5 ([#177](https://github.com/VeryGoodOpenSource/very_good_templates/pull/177))

## 0.6.1

- chore: update to Very Good Analysis 6.0.0 ([#135](https://github.com/VeryGoodOpenSource/very_good_templates/pull/135))
- chore: tighten template dependencies ([#137](https://github.com/VeryGoodOpenSource/very_good_templates/pull/137))

## 0.6.0

- feat!: ensure template uses Flutter 3.22 with Dart 3.4 ([#101](https://github.com/VeryGoodOpenSource/very_good_templates/pull/101))

## 0.5.1

- refactor: remove explicitly named libraries ([#77](https://github.com/VeryGoodOpenSource/very_good_templates/pull/77))

## 0.5.0

- refactor: remove generator script ([#72](https://github.com/VeryGoodOpenSource/very_good_flutter_package/pull/72))
- chore: migrate very_good_flutter_package ([#5](https://github.com/VeryGoodOpenSource/very_good_templates/pull/5))
- feat!: update to Flutter 3.19.0 ([#18](https://github.com/VeryGoodOpenSource/very_good_templates/pull/18))
- chore: update bricks to Mason 0.1.0-dev.52 ([#28](https://github.com/VeryGoodOpenSource/very_good_templates/pull/28))

## 0.4.1

- feat: upgrade to very_good_analysis ^5.1.0
- docs: update README.md install instructions

## 0.4.0

- feat!: bump min Dart SDK to 3.0.0

## 0.3.0

- feat!: bump min Dart SDK to 2.19.0

## 0.2.6

- chore: support dart sdk 2.18.0

## 0.2.5

- feat: update workflows, add spellcheck
- fix: flutter version on github workflow

## 0.2.4

- fix: upgrade workflow to use Flutter 3.7.3 for compatibility with Very Good Analysis

## 0.2.3

- feat: upgrade to `very_good_analysis ^4.0.0`

## 0.2.2

- feat: upgrade to Flutter 3.7.0

## 0.2.1

- fix: windows path resolution
- fix: GitHub workflow concurrency group

## 0.2.0

- **BREAKING** feat: add `publishable` flag (defaults to `false`)

## 0.1.4

- docs: remove copyright header and license from generated code

## 0.1.3

- feat: upgrade to Flutter 3.3.7

## 0.1.2

- feat: upgrade to Flutter 3.3.3

## 0.1.1

- feat: upgrade to Flutter 3.3.2 and very_good_analysis 3.1.0

## 0.1.0

- feat: upgrade to Flutter 3.3.1 and very_good_analysis 3.0.2

## 0.0.1

- feat: initial release 🎉

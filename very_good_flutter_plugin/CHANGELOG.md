# Changelog 

## [1.2.0](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_flutter_plugin-v1.1.0...very_good_flutter_plugin-v1.2.0) (2026-02-06)


### Features

* add license check workflow to templates ([#422](https://github.com/VeryGoodOpenSource/very_good_templates/issues/422)) ([bd280c0](https://github.com/VeryGoodOpenSource/very_good_templates/commit/bd280c00f90126856a5fe70d6417e1c83d20f74b))
* update iOS templates to use UIScene lifecycle ([#416](https://github.com/VeryGoodOpenSource/very_good_templates/issues/416)) ([233f02e](https://github.com/VeryGoodOpenSource/very_good_templates/commit/233f02e2212fc04f9ddfe54c8dff019a9ae1560f))
* upgrade to flutter 3.38.1 ([#394](https://github.com/VeryGoodOpenSource/very_good_templates/issues/394)) ([e436d76](https://github.com/VeryGoodOpenSource/very_good_templates/commit/e436d7606b0998fc5231d3bd1fd0c4650d0c8ae8))


### Bug Fixes

* update changelog's format ([#371](https://github.com/VeryGoodOpenSource/very_good_templates/issues/371)) ([6c5d53d](https://github.com/VeryGoodOpenSource/very_good_templates/commit/6c5d53d50d37dbd4fc88e3154f05ab283120e59f))


### Miscellaneous Chores

* bump very_good_analysis to 10.1.0 ([#400](https://github.com/VeryGoodOpenSource/very_good_templates/issues/400)) ([0c454c4](https://github.com/VeryGoodOpenSource/very_good_templates/commit/0c454c4166cf4e01c659ab723c5f94fc1a2edaa6))
* upgrade iOS target version to 13.0 ([#407](https://github.com/VeryGoodOpenSource/very_good_templates/issues/407)) ([0c33e73](https://github.com/VeryGoodOpenSource/very_good_templates/commit/0c33e73350507590e6c67eca095f7828ad42f140))

## [1.1.0](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_flutter_plugin-v1.0.0...very_good_flutter_plugin-v1.1.0) (2025-09-22)


### Features

* upgrade to flutter 3.35.0 ([#342](https://github.com/VeryGoodOpenSource/very_good_templates/issues/342)) ([6818041](https://github.com/VeryGoodOpenSource/very_good_templates/commit/681804198c03a6ab255802cedc15242832928e54))
* upgrade to very_good_analysis 10.0.0 ([#346](https://github.com/VeryGoodOpenSource/very_good_templates/issues/346)) ([5a7d0dc](https://github.com/VeryGoodOpenSource/very_good_templates/commit/5a7d0dc7323a77583158acfbbe933a60302ed532))
* upgraded plugin version and removed jdk7 dependency on build.kts ([#339](https://github.com/VeryGoodOpenSource/very_good_templates/issues/339)) ([8e60971](https://github.com/VeryGoodOpenSource/very_good_templates/commit/8e6097152174368e8923024ef1b2bf35f4a675ac))


### Refactors

* **very_good_flutter_plugin:** migrate to swift package manager ([#354](https://github.com/VeryGoodOpenSource/very_good_templates/issues/354)) ([2f02778](https://github.com/VeryGoodOpenSource/very_good_templates/commit/2f027788df3ebb38cf7ffedb4f5718e61e41b355))


### Miscellaneous Chores

* automate releases ([#319](https://github.com/VeryGoodOpenSource/very_good_templates/issues/319)) ([17fb3a5](https://github.com/VeryGoodOpenSource/very_good_templates/commit/17fb3a5c742a42e7fff70b269deea961e4a15b4f))
* **very_good_flutter_plugin:** migrates Groovy scripts to Kotlin DSL ([#316](https://github.com/VeryGoodOpenSource/very_good_templates/issues/316)) ([3e5628d](https://github.com/VeryGoodOpenSource/very_good_templates/commit/3e5628d65d2c33ab01c443df8b33e6e0ff35a07a))

## 1.0.0

refactor(very_good_flutter_plugin)!: remove root-level project_name folder from brick structure.

### Migration details

The `very_good_flutter_plugin` brick no longer includes a top-level project name folder.
This allows generating the project directly into the current or a custom directory.

If you prefer to keep the output inside its own folder (as before), use the -o flag:

```dart
// Before:
mason make very_good_flutter_plugin

// After:
mason make very_good_flutter_plugin -o ./output_folder
```

## 0.11.1

- fix: linting issues [#280](https://github.com/VeryGoodOpenSource/very_good_templates/pull/280)

## 0.11.0

- chore(deps): bump very_good_analysis from 6.0.0 to 7.0.0 in /very_good_flutter_plugin/hooks [#235](https://github.com/VeryGoodOpenSource/very_good_templates/pull/235)
- chore: tighten template dependencies [#237](https://github.com/VeryGoodOpenSource/very_good_templates/pull/237)
- fix: evaluate brick output correctly on ci [#248](https://github.com/VeryGoodOpenSource/very_good_templates/pull/248)
- chore: update to Flutter 3.29 and Dart 3.7 [#250](https://github.com/VeryGoodOpenSource/very_good_templates/pull/250)
- chore: update flutter 3.32.0 and dart 3.8.0 [#253](https://github.com/VeryGoodOpenSource/very_good_templates/pull/253)
- chore: tighten template dependencies [#243](https://github.com/VeryGoodOpenSource/very_good_templates/pull/243)
- chore: bump very_good_analysis to 9.0.0 [#261](https://github.com/VeryGoodOpenSource/very_good_templates/pull/261)

## 0.10.0

- feat: update pull request templates to add `test` type option ([#214](https://github.com/VeryGoodOpenSource/very_good_templates/pull/214))
- chore: update to Flutter 3.27 and Dart 3.6 ([#223](https://github.com/VeryGoodOpenSource/very_good_templates/pull/223))

## 0.9.0

- feat: update to Flutter 3.24 and Dart 3.5 ([#177](https://github.com/VeryGoodOpenSource/very_good_templates/pull/177))

## 0.8.2

- chore: update gradle to 7.6.1 ([#150](https://github.com/VeryGoodOpenSource/very_good_templates/pull/150))
- chore: update example Kotlin and AGP ([#151](https://github.com/VeryGoodOpenSource/very_good_templates/pull/151))
- chore: deprecate imperative apply of Flutter's Gradle plugins ([#152](https://github.com/VeryGoodOpenSource/very_good_templates/pull/152))
- chore: remove legacy package tag in AndroidManifest.xml ([#160](https://github.com/VeryGoodOpenSource/very_good_templates/pull/160))
- chore: android flutter plugin to use recommended plugin DSL ([#153](https://github.com/VeryGoodOpenSource/very_good_templates/pull/153))

## 0.8.1

- style: Adding extra space to the application opening tag ([#126](https://github.com/VeryGoodOpenSource/very_good_templates/pull/126))
- chore(deps): bump very_good_analysis from 5.1.0 to 6.0.0 in /very_good_flutter_plugin/hooks ([#133](https://github.com/VeryGoodOpenSource/very_good_templates/pull/133))
- chore: update to Very Good Analysis 6.0.0 ([#135](https://github.com/VeryGoodOpenSource/very_good_templates/pull/135))
- chore: tighten template dependencies ([#137](https://github.com/VeryGoodOpenSource/very_good_templates/pull/137))

## 0.8.0

- refactor: remove explicitly named libraries ([#77](https://github.com/VeryGoodOpenSource/very_good_templates/pull/77))
- test: very_good_flutter_plugin doesn't have full code coverage ([#89](https://github.com/VeryGoodOpenSource/very_good_templates/pull/89))
- feat: update android plugin template with latest flutter changes ([#95](https://github.com/VeryGoodOpenSource/very_good_templates/pull/95))
- feat!: ensure template uses Flutter 3.22 with Dart 3.4 ([#105](https://github.com/VeryGoodOpenSource/very_good_templates/pull/105))

## 0.7.1

- refactor: remove logs during pre_gen ([#72](https://github.com/VeryGoodOpenSource/very_good_cli/pull/976))

## 0.7.0

- test: add pre generation tests ([#138](https://github.com/VeryGoodOpenSource/very_good_flutter_plugin/pull/138))
- feat: allow optionally fixing template output ([#151](https://github.com/VeryGoodOpenSource/very_good_flutter_plugin/pull/151))
- fix: add support for platform testing ([#155](https://github.com/VeryGoodOpenSource/very_good_flutter_plugin/pull/155))
- feat: remove generator script ([#141](https://github.com/VeryGoodOpenSource/very_good_flutter_plugin/commit/78c1a6fb7619fa80d824e97065d00a87293bb7b5))
- chore: update repository url ([#41](https://github.com/VeryGoodOpenSource/very_good_templates/pull/41))
- refactor: template dartSdkVersionBounds ([#47](https://github.com/VeryGoodOpenSource/very_good_templates/pull/47))
- refactor: template flutterVersion ([#48](https://github.com/VeryGoodOpenSource/very_good_templates/pull/48))
- refactor: define versions in version.dart file ([#49](https://github.com/VeryGoodOpenSource/very_good_templates/pull/49))
- feat!: bump version to 3.19.0 ([#50](https://github.com/VeryGoodOpenSource/very_good_templates/pull/50))
- chore: tighten hook dependencies ([#51](https://github.com/VeryGoodOpenSource/very_good_templates/pull/51))
- chore: update brick to Mason 0.1.0-dev.52 ([#52](https://github.com/VeryGoodOpenSource/very_good_templates/pull/52))
- chore: tighten dependencies ([#53](https://github.com/VeryGoodOpenSource/very_good_templates/pull/53))

## 0.6.0

- fix: flaky integrated tests
- feat: upgrade to `very_good_analysis ^5.1.0`
- feat: add fluttium test workflow
- docs: add docs for integration tests

## 0.5.0

- feat!: bump min Dart SDK to 3.0.0

## 0.4.0

- feat!: bump min Dart SDK to 2.19.0

## 0.3.3

- chore: fix generator run
- fix: updated regex matching
- chore: support dart sdk 2.18.0

## 0.3.2

- feat: update workflows, dependabot generation, add spellcheck
- fix: integration tests
- feat: use swift in iOS plugin

## 0.3.1

- feat: upgrade to `very_good_analysis 4.0.0`

## 0.3.0

- feat: upgrade to flutter 3.7.1

## 0.2.1

- fix: windows path resolution
- feat: add ci concurrency group to workflow

## 0.2.0

- **BREAKING** feat: add `publishable` flag (defaults to `false`)

## 0.1.2

- docs: remove copyright header and license from generated code

## 0.1.1

- feat: upgrade to Flutter 3.3.2
- feat: upgrade to very_good_analysis 3.1.0

## 0.1.0+1

- docs: minor README updates
  - add dependabot integration
  - fix broken link to very_good_analysis

## 0.1.0

- feat: upgrade to Flutter 3.3.1
- feat: upgrade to very_good_analysis 3.0.2
- fix: dependabot integration

## 0.0.1+1

- chore: remove duplicate images from README

## 0.0.1

- feat: initial release 🎉

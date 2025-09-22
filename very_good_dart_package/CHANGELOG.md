## [1.1.0](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_dart_package-v1.0.0...very_good_dart_package-v1.1.0) (2025-09-22)


### Features

* upgrade to flutter 3.35.0 ([#342](https://github.com/VeryGoodOpenSource/very_good_templates/issues/342)) ([6818041](https://github.com/VeryGoodOpenSource/very_good_templates/commit/681804198c03a6ab255802cedc15242832928e54))
* upgrade to very_good_analysis 10.0.0 ([#346](https://github.com/VeryGoodOpenSource/very_good_templates/issues/346)) ([5a7d0dc](https://github.com/VeryGoodOpenSource/very_good_templates/commit/5a7d0dc7323a77583158acfbbe933a60302ed532))


### Miscellaneous Chores

* automate releases ([#319](https://github.com/VeryGoodOpenSource/very_good_templates/issues/319)) ([17fb3a5](https://github.com/VeryGoodOpenSource/very_good_templates/commit/17fb3a5c742a42e7fff70b269deea961e4a15b4f))
* tighten template dependencies ([#312](https://github.com/VeryGoodOpenSource/very_good_templates/issues/312)) ([2875cd9](https://github.com/VeryGoodOpenSource/very_good_templates/commit/2875cd9aecc249fc0d2a4cd64efb3be20603f1da))

## 1.0.0

refactor(very_good_dart_package)!: remove root-level project_name folder from brick structure.

### Migration details

The `very_good_dart_package` brick no longer includes a top-level project name folder.
This allows generating the project directly into the current or a custom directory.

If you prefer to keep the output inside its own folder (as before), use the -o flag:

```dart
// Before:
mason make very_good_dart_package

// After:
mason make very_good_dart_package -o ./output_folder
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
- chore: tighten template dependencies ([#220](https://github.com/VeryGoodOpenSource/very_good_templates/pull/220), [#221](https://github.com/VeryGoodOpenSource/very_good_templates/pull/221))

## 0.7.0

- chore: tighten template dependencies ([#146](https://github.com/VeryGoodOpenSource/very_good_templates/pull/146))
- feat: update to Flutter 3.24 and Dart 3.5 ([#177](https://github.com/VeryGoodOpenSource/very_good_templates/pull/177))

## 0.6.1

- chore: update to Very Good Analysis 6.0.0 ([#135](https://github.com/VeryGoodOpenSource/very_good_templates/pull/135))
- chore: tighten template dependencies ([#137](https://github.com/VeryGoodOpenSource/very_good_templates/pull/137))

## 0.6.0

- feat!: ensure template uses Dart 3.4 ([#100](https://github.com/VeryGoodOpenSource/very_good_templates/pull/100))

## 0.5.1

- refactor: remove explicitly named libraries ([#77](https://github.com/VeryGoodOpenSource/very_good_templates/pull/77))

## 0.5.0

- refactor: remove generator script ([#71](https://github.com/VeryGoodOpenSource/very_good_dart_package/pull/71))
- feat!: update to Dart 3.3.0 ([#16](https://github.com/VeryGoodOpenSource/very_good_templates/pull/16))
- chore: update bricks to Mason 0.1.0-dev.52 ([#28](https://github.com/VeryGoodOpenSource/very_good_templates/pull/28))

## 0.4.1

- feat: upgrade to very_good_analysis ^5.1.0
- docs: update README.md install instructions

## 0.4.0

- feat!: update to Dart 3

## 0.3.0

- feat!: bump min Dart SDK to 2.19.0

## 0.2.5

- fix: patch version downgrade
- chore: support dart sdk 2.18.0

## 0.2.4

- fix: unnecessary issue/pr templates on template src
- feat: update workflows, add spellcheck

## 0.2.3

- feat: upgrade to `very_good_analysis ^4.0.0`

## 0.2.2

- feat: upgrade to Dart 2.19 and fix dependabot file

## 0.2.1

- fix: windows path resolution
- fix: GitHub workflow concurrency group

## 0.2.0

- **BREAKING** feat: add `publishable` flag (defaults to `false`)

## 0.1.2

- docs: remove copyright header and license from generated code

## 0.1.1

- feat: upgrade to very_good_analysis 3.1.0

## 0.1.0

- feat: upgrade to Dart 2.18 and very_good_analysis 3.0.2

## 0.0.1

- feat: initial release 🎉

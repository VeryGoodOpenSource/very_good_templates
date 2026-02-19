# Changelog

## [1.3.0](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_dart_cli-v1.2.0...very_good_dart_cli-v1.3.0) (2026-02-19)


### Features

* upgrade to dart 3.11 and flutter 3.41 ([#429](https://github.com/VeryGoodOpenSource/very_good_templates/issues/429)) ([46ae490](https://github.com/VeryGoodOpenSource/very_good_templates/commit/46ae490823ef6f5f3addef6159a24870f66e931e))
* upgrade to very_good_analysis 10.2.0 ([#437](https://github.com/VeryGoodOpenSource/very_good_templates/issues/437)) ([be16183](https://github.com/VeryGoodOpenSource/very_good_templates/commit/be161834e90f0381d3535c9bd3b5f44ba6ea19ba))


### Miscellaneous Chores

* tighten template dependencies ([#425](https://github.com/VeryGoodOpenSource/very_good_templates/issues/425)) ([c4feeb6](https://github.com/VeryGoodOpenSource/very_good_templates/commit/c4feeb6031b6bf211546bce9f4797d2554363488))
* tighten template dependencies ([#435](https://github.com/VeryGoodOpenSource/very_good_templates/issues/435)) ([5937c46](https://github.com/VeryGoodOpenSource/very_good_templates/commit/5937c469ae2c28ad4230d2ce00fdf8d78639c0d8))

## [1.2.0](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_dart_cli-v1.1.0...very_good_dart_cli-v1.2.0) (2026-02-06)


### Features

* add license check workflow to templates ([#422](https://github.com/VeryGoodOpenSource/very_good_templates/issues/422)) ([bd280c0](https://github.com/VeryGoodOpenSource/very_good_templates/commit/bd280c00f90126856a5fe70d6417e1c83d20f74b))
* upgrade to flutter 3.38.1 ([#394](https://github.com/VeryGoodOpenSource/very_good_templates/issues/394)) ([e436d76](https://github.com/VeryGoodOpenSource/very_good_templates/commit/e436d7606b0998fc5231d3bd1fd0c4650d0c8ae8))


### Bug Fixes

* update changelog's format ([#371](https://github.com/VeryGoodOpenSource/very_good_templates/issues/371)) ([6c5d53d](https://github.com/VeryGoodOpenSource/very_good_templates/commit/6c5d53d50d37dbd4fc88e3154f05ab283120e59f))


### Miscellaneous Chores

* bump very_good_analysis to 10.1.0 ([#400](https://github.com/VeryGoodOpenSource/very_good_templates/issues/400)) ([0c454c4](https://github.com/VeryGoodOpenSource/very_good_templates/commit/0c454c4166cf4e01c659ab723c5f94fc1a2edaa6))
* tighten template dependencies ([#372](https://github.com/VeryGoodOpenSource/very_good_templates/issues/372)) ([e8c9a7d](https://github.com/VeryGoodOpenSource/very_good_templates/commit/e8c9a7dd5c71a62b8e856c05e42249901a5d2bc7))
* tighten template dependencies ([#385](https://github.com/VeryGoodOpenSource/very_good_templates/issues/385)) ([10ed573](https://github.com/VeryGoodOpenSource/very_good_templates/commit/10ed57357e67dc8a9eb0d132e9e7272c743f6781))
* tighten template dependencies ([#401](https://github.com/VeryGoodOpenSource/very_good_templates/issues/401)) ([31b852c](https://github.com/VeryGoodOpenSource/very_good_templates/commit/31b852c18e2b00e5182fe996fe9534e55cce6832))

## [1.1.0](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_dart_cli-v1.0.0...very_good_dart_cli-v1.1.0) (2025-09-22)


### Features

* upgrade to flutter 3.35.0 ([#342](https://github.com/VeryGoodOpenSource/very_good_templates/issues/342)) ([6818041](https://github.com/VeryGoodOpenSource/very_good_templates/commit/681804198c03a6ab255802cedc15242832928e54))
* upgrade to very_good_analysis 10.0.0 ([#346](https://github.com/VeryGoodOpenSource/very_good_templates/issues/346)) ([5a7d0dc](https://github.com/VeryGoodOpenSource/very_good_templates/commit/5a7d0dc7323a77583158acfbbe933a60302ed532))


### Miscellaneous Chores

* automate releases ([#319](https://github.com/VeryGoodOpenSource/very_good_templates/issues/319)) ([17fb3a5](https://github.com/VeryGoodOpenSource/very_good_templates/commit/17fb3a5c742a42e7fff70b269deea961e4a15b4f))
* tighten template dependencies ([#312](https://github.com/VeryGoodOpenSource/very_good_templates/issues/312)) ([2875cd9](https://github.com/VeryGoodOpenSource/very_good_templates/commit/2875cd9aecc249fc0d2a4cd64efb3be20603f1da))
* tighten template dependencies ([#320](https://github.com/VeryGoodOpenSource/very_good_templates/issues/320)) ([8f441c3](https://github.com/VeryGoodOpenSource/very_good_templates/commit/8f441c3f54681707ded3dda8aefd578763979d73))
* tighten template dependencies ([#333](https://github.com/VeryGoodOpenSource/very_good_templates/issues/333)) ([460f7de](https://github.com/VeryGoodOpenSource/very_good_templates/commit/460f7de093d976e40679be0710c2d0270fa71918))
* tighten template dependencies ([#353](https://github.com/VeryGoodOpenSource/very_good_templates/issues/353)) ([a7f24a7](https://github.com/VeryGoodOpenSource/very_good_templates/commit/a7f24a7b952ab2f59b6fb69023f319cd7a4f0a3f))

## 1.0.0

refactor(very_good_dart_cli)!: remove root-level project_name folder from brick structure.

### Migration details

The `very_good_dart_cli` brick no longer includes a top-level project name folder.
This allows generating the project directly into the current or a custom directory.

If you prefer to keep the output inside its own folder (as before), use the -o flag:

```dart
// Before:
mason make very_good_dart_cli

// After:
mason make very_good_dart_cli -o ./output_folder
```

## 0.10.1

- test: add missing test [#278](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/278)

## 0.10.0

- chore(deps): bump very_good_analysis from 6.0.0 to 7.0.0 in /very_good_dart_cli/hooks [#236](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/236)
- chore: tighten template dependencies [#237](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/237)
- fix: evaluate brick output correctly on ci [#248](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/248)
- chore: update to Flutter 3.29 and Dart 3.7 [#250](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/250)
- chore: update flutter 3.32.0 and dart 3.8.0 [#253](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/253)
- chore: tighten template dependencies [#243](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/243)
- chore: bump very_good_analysis to 9.0.0 [#261](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/261)

## 0.9.0

- chore: update to Flutter 3.27 and Dart 3.6 ([#223](https://github.com/VeryGoodOpenSource/very_good_templates/pull/223))
- feat: update pull request templates to add `test` type option ([#214](https://github.com/VeryGoodOpenSource/very_good_templates/pull/214))
- chore: tighten template dependencies ([#194](https://github.com/VeryGoodOpenSource/very_good_templates/pull/194), [#198](https://github.com/VeryGoodOpenSource/very_good_templates/pull/198), [#203](https://github.com/VeryGoodOpenSource/very_good_templates/pull/203), [#211](https://github.com/VeryGoodOpenSource/very_good_templates/pull/211), [#220](https://github.com/VeryGoodOpenSource/very_good_templates/pull/220), [#221](https://github.com/VeryGoodOpenSource/very_good_templates/pull/221))

## 0.8.0

- feat: update to Flutter 3.24 and Dart 3.5 ([#177](https://github.com/VeryGoodOpenSource/very_good_templates/pull/177))
- chore: tighten template dependencies ([#173](https://github.com/VeryGoodOpenSource/very_good_templates/pull/173), [#178](https://github.com/VeryGoodOpenSource/very_good_templates/pull/178))

## 0.7.2

- chore: tighten template dependencies ([#146](https://github.com/VeryGoodOpenSource/very_good_templates/pull/146), [#149](https://github.com/VeryGoodOpenSource/very_good_templates/pull/149))

## 0.7.1

- chore: update to Very Good Analysis 6.0.0 ([#135](https://github.com/VeryGoodOpenSource/very_good_templates/pull/135))
- chore: tighten template dependencies ([#137](https://github.com/VeryGoodOpenSource/very_good_templates/pull/137))

## 0.7.0

- feat!: ensure template uses Dart 3.4 ([#99](https://github.com/VeryGoodOpenSource/very_good_templates/pull/99))

## 0.6.1

- refactor: remove explicitly named libraries ([#77](https://github.com/VeryGoodOpenSource/very_good_templates/pull/77))

## 0.6.0

- build(deps): bump pub_updater from 0.3.1 to 0.4.0 ([#116](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/116))
- build(deps): bump cli_completion from 0.3.0 to 0.4.0 ([#115](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/115))
- fix: sort directive ordering on post generation ([#122](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/122))
- feat: hook performs dart pub get ([#123](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/123))
- refactor: remove generator script ([#120](https://github.com/VeryGoodOpenSource/very_good_dart_cli/pull/120))
- chore: migrate very_good_dart_cli ([#3](https://github.com/VeryGoodOpenSource/very_good_templates/pull/3))
- feat!: update to Dart 3.3.0 ([#22](https://github.com/VeryGoodOpenSource/very_good_templates/pull/22))
- chore: update bricks to Mason 0.1.0-dev.52 ([#28](https://github.com/VeryGoodOpenSource/very_good_templates/pull/28))

## 0.5.1

- feat: upgrade to very_good_analysis ^5.1.0

## 0.5.0

- feat: update very good analysis to v5 and fix patch
- feat: bump Dart SDK to >=3.0.0 <4.0.0

## 0.4.0

- feat!: bump min Dart SDK to 2.19.0

## 0.3.3

- chore: support dart sdk 2.18.0

## 0.3.2

- feat: update workflows, add spellcheck
- fix: remove unused pub updater from test

## 0.3.1

- feat: upgrade to `very_good_analysis 4.0.0`

## 0.3.0

- feat: add completion

## 0.2.3

- feat: upgrade to Dart 2.19

## 0.2.2

- fix: update silently fails when the sdk doesn't support most recent version

## 0.2.1

- fix: windows path resolution
- feat: add ci concurrency group to workflow

## 0.2.0

- **BREAKING** feat: add `publishable` flag (defaults to `false`)

## 0.1.4

- docs: remove copyright header and license from generated code

## 0.1.3

- fix: update prompt on update

## 0.1.2

- chore(deps): upgrade to mason_logger 0.2.0
- fix: use available global constant for executable name

## 0.1.1

- feat: upgrade to very_good_analysis 3.1.0

## 0.1.0

- feat: upgrade to Dart 2.18
- feat: upgrade to very_good_analysis 3.0.2
- feat: add dependabot integration

## 0.0.1

- feat: initial release 🎉

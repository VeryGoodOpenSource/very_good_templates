## [1.1.0](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_flame_game-v1.0.0...very_good_flame_game-v1.1.0) (2025-09-22)


### Features

* upgrade to flutter 3.35.0 ([#342](https://github.com/VeryGoodOpenSource/very_good_templates/issues/342)) ([6818041](https://github.com/VeryGoodOpenSource/very_good_templates/commit/681804198c03a6ab255802cedc15242832928e54))
* upgrade to very_good_analysis 10.0.0 ([#346](https://github.com/VeryGoodOpenSource/very_good_templates/issues/346)) ([5a7d0dc](https://github.com/VeryGoodOpenSource/very_good_templates/commit/5a7d0dc7323a77583158acfbbe933a60302ed532))
* upgraded plugin version and removed jdk7 dependency on build.kts ([#339](https://github.com/VeryGoodOpenSource/very_good_templates/issues/339)) ([8e60971](https://github.com/VeryGoodOpenSource/very_good_templates/commit/8e6097152174368e8923024ef1b2bf35f4a675ac))
* **very_good_flame_game:** add platform options ([#340](https://github.com/VeryGoodOpenSource/very_good_templates/issues/340)) ([f3a6792](https://github.com/VeryGoodOpenSource/very_good_templates/commit/f3a6792af70c6006bfbf4b30d92e0d91b6246205))
* **very_good_flame:** update assets.gen.dart ([#349](https://github.com/VeryGoodOpenSource/very_good_templates/issues/349)) ([2f9da8c](https://github.com/VeryGoodOpenSource/very_good_templates/commit/2f9da8c3bbb423876ff125a067755932a74a2b38))


### Bug Fixes

* **very_good_flame_game:** Change so "tap count" message is responsive to window size ([#338](https://github.com/VeryGoodOpenSource/very_good_templates/issues/338)) ([3b8c11e](https://github.com/VeryGoodOpenSource/very_good_templates/commit/3b8c11e5c77124645c742b1475ebf9a9209680eb))
* **very_good_flame_game:** deprecated android gradle plugin version ([#315](https://github.com/VeryGoodOpenSource/very_good_templates/issues/315)) ([fb4385d](https://github.com/VeryGoodOpenSource/very_good_templates/commit/fb4385dd5acb3c7eaae3b1a1bdc0a4fac5e91449))
* **very_good_flame_game:** Improve text readability by changing color… ([#335](https://github.com/VeryGoodOpenSource/very_good_templates/issues/335)) ([0a42ee2](https://github.com/VeryGoodOpenSource/very_good_templates/commit/0a42ee292238bda7c86b9220a640b31154070dcd))
* **very_good_flame_game:** trim audio to not repeat sound effect ([#336](https://github.com/VeryGoodOpenSource/very_good_templates/issues/336)) ([9b423ac](https://github.com/VeryGoodOpenSource/very_good_templates/commit/9b423ac7ab707a83fac4a456ea798d525513fac2))


### Miscellaneous Chores

* automate releases ([#319](https://github.com/VeryGoodOpenSource/very_good_templates/issues/319)) ([17fb3a5](https://github.com/VeryGoodOpenSource/very_good_templates/commit/17fb3a5c742a42e7fff70b269deea961e4a15b4f))
* tighten template dependencies ([#318](https://github.com/VeryGoodOpenSource/very_good_templates/issues/318)) ([70a1f0c](https://github.com/VeryGoodOpenSource/very_good_templates/commit/70a1f0ced2ec663bcace86166ca31de616b8de59))
* tighten template dependencies ([#348](https://github.com/VeryGoodOpenSource/very_good_templates/issues/348)) ([4167a25](https://github.com/VeryGoodOpenSource/very_good_templates/commit/4167a255c3b126418fefbadbeb6968c7bd861ed8))
* tighten template dependencies ([#351](https://github.com/VeryGoodOpenSource/very_good_templates/issues/351)) ([68b6651](https://github.com/VeryGoodOpenSource/very_good_templates/commit/68b665139a7893a5ec760f2074928f990ee45045))
* tighten template dependencies ([#353](https://github.com/VeryGoodOpenSource/very_good_templates/issues/353)) ([a7f24a7](https://github.com/VeryGoodOpenSource/very_good_templates/commit/a7f24a7b952ab2f59b6fb69023f319cd7a4f0a3f))
* **very_good_flame_game:** migrates Groovy scripts to Kotlin DSL ([#314](https://github.com/VeryGoodOpenSource/very_good_templates/issues/314)) ([e384bed](https://github.com/VeryGoodOpenSource/very_good_templates/commit/e384bedad9c4f32cb97ed1395ceb02ad85200de9))

## [1.1.2](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_flame_game-v1.1.1...very_good_flame_game-v1.1.2) (2025-09-30)


### Miscellaneous Chores

* tighten template dependencies ([#363](https://github.com/VeryGoodOpenSource/very_good_templates/issues/363)) ([01307a7](https://github.com/VeryGoodOpenSource/very_good_templates/commit/01307a7bd955fa9d673cb534746cb265685530c1))

## [1.1.1](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_flame_game-v1.1.0...very_good_flame_game-v1.1.1) (2025-09-25)


### Bug Fixes

* **very_good_flame_game:** selected platforms can be nullable ([#360](https://github.com/VeryGoodOpenSource/very_good_templates/issues/360)) ([5cd5e82](https://github.com/VeryGoodOpenSource/very_good_templates/commit/5cd5e82c16f8431348e43549809e54f836792fdc))

## 1.0.0

refactor(very_good_flame_game)!: remove root-level project_name folder from brick structure.

### Migration details

The `very_good_flame_game` brick no longer includes a top-level project name folder.
This allows generating the project directly into the current or a custom directory.

If you prefer to keep the output inside its own folder (as before), use the -o flag:

```dart
// Before:
mason make very_good_flame_game

// After:
mason make very_good_flame_game -o ./output_folder
```

## 0.11.0

- chore: tighten template dependencies [#237](https://github.com/VeryGoodOpenSource/very_good_templates/pull/237)
- chore: tighten template dependencies [#240](https://github.com/VeryGoodOpenSource/very_good_templates/pull/240)
- fix: evaluate brick output correctly on ci [#248](https://github.com/VeryGoodOpenSource/very_good_templates/pull/248)
- chore: update to Flutter 3.29 and Dart 3.7 [#250](https://github.com/VeryGoodOpenSource/very_good_templates/pull/250)
- chore: update flutter 3.32.0 and dart 3.8.0 [#253](https://github.com/VeryGoodOpenSource/very_good_templates/pull/253)
- chore(very_good_flame_game): update to mockingjay 2.0.0 [#260](https://github.com/VeryGoodOpenSource/very_good_templates/pull/260)
- chore: tighten template dependencies [#243](https://github.com/VeryGoodOpenSource/very_good_templates/pull/243)
- chore: bump very_good_analysis to 9.0.0 [#261](https://github.com/VeryGoodOpenSource/very_good_templates/pull/261)

## 0.10.0

- chore: tighten template dependencies ([#211](https://github.com/VeryGoodOpenSource/very_good_templates/pull/211), [#213](https://github.com/VeryGoodOpenSource/very_good_templates/pull/213), [#220](https://github.com/VeryGoodOpenSource/very_good_templates/pull/220))
- feat: update pull request templates to add `test` type option ([#214](https://github.com/VeryGoodOpenSource/very_good_templates/pull/214))
- chore: update to Flutter 3.27 and Dart 3.6 ([#223](https://github.com/VeryGoodOpenSource/very_good_templates/pull/223))

## 0.9.0

- fix: set current year copyright ([#192](https://github.com/VeryGoodOpenSource/very_good_templates/pull/192))
- chore: tighten template dependencies ([#204](https://github.com/VeryGoodOpenSource/very_good_templates/pull/204))
- fix: update android build versions ([#205](https://github.com/VeryGoodOpenSource/very_good_templates/pull/205))

## 0.8.1

- chore: tighten template dependencies ([#190](https://github.com/VeryGoodOpenSource/very_good_templates/pull/190))
- fix: add closing } in build.gradle ([#189](https://github.com/VeryGoodOpenSource/very_good_templates/pull/189))

## 0.8.0

- feat: update to Flutter 3.24 and Dart 3.5 ([#177](https://github.com/VeryGoodOpenSource/very_good_templates/pull/177))

## 0.7.3

- chore: use git dependency over path dependency ([#171](https://github.com/VeryGoodOpenSource/very_good_templates/pull/171))

## 0.7.2

- feat: update usage of application_id var ([#157](https://github.com/VeryGoodOpenSource/very_good_templates/pull/157))

## 0.7.1

- style: Adding extra space to the application opening tag ([#126](https://github.com/VeryGoodOpenSource/very_good_templates/pull/126))
- chore: update Java version for Very Good Flame Game ([#129](https://github.com/VeryGoodOpenSource/very_good_templates/pull/129))
- chore: update to Very Good Analysis 6.0.0 ([#135](https://github.com/VeryGoodOpenSource/very_good_templates/pull/135))
- chore: tighten template dependencies ([#137](https://github.com/VeryGoodOpenSource/very_good_templates/pull/137))

## 0.7.0

- feat!: ensure template uses Flutter 3.22 with Dart 3.4 ([#102](https://github.com/VeryGoodOpenSource/very_good_templates/pull/102))
- fix: update index.html to support latest convention ([#107](https://github.com/VeryGoodOpenSource/very_good_templates/pull/107))

## 0.6.1

- fix: deprecated imperative apply of Flutter's Gradle plugins ([#78](https://github.com/VeryGoodOpenSource/very_good_templates/pull/78))

## 0.6.0

- docs: fixed copy format and command ([#146](https://github.com/VeryGoodOpenSource/very_good_flame_game/pull/146))
- fix: resolve image caching issue on flame_game template ([#143](https://github.com/VeryGoodOpenSource/very_good_flame_game/pull/143))
- chore: migrate very_good_flame_game to very_good_templates ([#7](https://github.com/VeryGoodOpenSource/very_good_templates/pull/7))
- feat!: update to Flutter 3.19.0 ([#20](https://github.com/VeryGoodOpenSource/very_good_templates/pull/20))
- chore: update bricks to Mason 0.1.0-dev.52 ([#28](https://github.com/VeryGoodOpenSource/very_good_templates/commit/9dca472fb8c97a2fd08dbeea10eaf93d320ac550))

## 0.5.1

- fix: remove ephemeral and ignored files from template ([#141](https://github.com/VeryGoodOpenSource/very_good_flame_game/issues/141))

## 0.5.0

- build(deps): bump google_fonts in /src/very_good_flame_game ([#118](https://github.com/VeryGoodOpenSource/very_good_flame_game/pull/118))
- build(deps): bump actions/checkout from 4.0.0 to 4.1.0 ([#121](https://github.com/VeryGoodOpenSource/very_good_flame_game/pull/121))
- build(deps): bump actions/checkout from 4.1.0 to 4.1.1 ([#123](https://github.com/VeryGoodOpenSource/very_good_flame_game/pull/123))
- feat: add macOS platform support ([#125](https://github.com/VeryGoodOpenSource/very_good_flame_game/pull/125))
- fix: replace `VeryGoodFlameGame` with template ([#130](https://github.com/VeryGoodOpenSource/very_good_flame_game/pull/130))
- feat: update to flame 1.10 ([#129](https://github.com/VeryGoodOpenSource/very_good_flame_game/pull/129))
- build(deps): bump mockingjay from 0.4.0 to 0.5.0 in /src/very_good_flame_game ([#133](https://github.com/VeryGoodOpenSource/very_good_flame_game/pull/133))
- fix: regenerate ios platform dir ([#134](https://github.com/VeryGoodOpenSource/very_good_flame_game/pull/134))

## 0.4.0

- feat!: update to Flame 1.8.2
- feat!: bump min Dart SDK to 3.1.0
- feat!: update to Flutter 3.13.2
- fix: added RunnerTests iOS Schema
- fix: very_good create flutter_app doesn't create .gradlew files
- feat: upgrade to `very_good_analysis ^5.1.0`
- fix: text style tests for `CounterComponent`

## 0.3.0

- feat!: update to Dart 3.0.0

## 0.2.0

- feat!: bump min Dart SDK to 2.19.0

## 0.1.3

- chore: support dart sdk 2.18.0

## 0.1.2

- feat: update workflows, add spellcheck
- build(deps): update google_fonts

## 0.1.1

- feat: update `very_good_analysis to ^4.0.0`

## 0.1.0

- feat: upgrade bloc
  - bloc ^8.1.1
  - flutter_bloc ^8.1.2
  - bloc_test ^9.1.1
- feat: upgrade to Flutter 3.7.1

## 0.0.5

- fix: google fonts test issue

## 0.0.4

- feat: upgrade to Flutter 3.7.0 and Flame 1.6.0

## 0.0.3

- docs: remove copyright header and license from generated code

## 0.0.2

- fix: add support for GlobalCupertinoLocalizations

## 0.0.1

- feat: initial release 🎉

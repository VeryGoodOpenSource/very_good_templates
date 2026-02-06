# Changelog

## [1.0.3](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_docs_site-v1.0.2...very_good_docs_site-v1.0.3) (2026-02-06)


### Bug Fixes

* update changelog's format ([#371](https://github.com/VeryGoodOpenSource/very_good_templates/issues/371)) ([6c5d53d](https://github.com/VeryGoodOpenSource/very_good_templates/commit/6c5d53d50d37dbd4fc88e3154f05ab283120e59f))

## [1.0.2](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_docs_site-v1.0.1...very_good_docs_site-v1.0.2) (2025-10-01)


### Bug Fixes

* **very_good_docs_site:** update docusaurus config ([#367](https://github.com/VeryGoodOpenSource/very_good_templates/issues/367)) ([e65510c](https://github.com/VeryGoodOpenSource/very_good_templates/commit/e65510c2e853e5b6b8fa378482c49927aeb3ba41))

## [1.0.1](https://github.com/VeryGoodOpenSource/very_good_templates/compare/very_good_docs_site-v1.0.0...very_good_docs_site-v1.0.1) (2025-09-22)


### Miscellaneous Chores

* automate releases ([#319](https://github.com/VeryGoodOpenSource/very_good_templates/issues/319)) ([17fb3a5](https://github.com/VeryGoodOpenSource/very_good_templates/commit/17fb3a5c742a42e7fff70b269deea961e4a15b4f))

## 1.0.0

refactor(very_good_docs_site)!: remove root-level project_name folder from brick structure.

### Migration details

The `very_good_docs_site` brick no longer includes a top-level project name folder.
This allows generating the project directly into the current or a custom directory.

If you prefer to keep the output inside its own folder (as before), use the -o flag:

```dart
// Before:
mason make very_good_docs_site

// After:
mason make very_good_docs_site -o ./output_folder
```

## 0.0.5

- fix: evaluate brick output correctly on ci [#248](https://github.com/VeryGoodOpenSource/very_good_templates/pull/248)

## 0.0.4

- feat: update pull request templates to add `test` type option ([#214](https://github.com/VeryGoodOpenSource/very_good_templates/pull/214))
- chore(deps-dev): bump @docusaurus/module-type-aliases from 3.3.2 to 3.4.0 in /very_good_docs_site/**brick**/{{project_name.snakeCase()}} ([#118](https://github.com/VeryGoodOpenSource/very_good_templates/pull/118))
- chore(deps-dev): bump eslint from 8.57.0 to 9.2.0 in /very_good_docs_site/**brick**/{{project_name.snakeCase()}} ([#94](https://github.com/VeryGoodOpenSource/very_good_templates/pull/94))
- chore(deps-dev): bump @docusaurus/module-type-aliases from 3.4.0 to 3.5.2 in /very_good_docs_site/**brick**/{{project_name.snakeCase()}} ([#175](https://github.com/VeryGoodOpenSource/very_good_templates/pull/175))
- chore(deps-dev): bump @docusaurus/module-type-aliases from 3.5.2 to 3.6.0 in /very_good_docs_site/**brick**/{{project_name.snakeCase()}} ([#212](https://github.com/VeryGoodOpenSource/very_good_templates/pull/212))

## 0.0.3

- chore: migrate very_good_docs_site ([#6](https://github.com/VeryGoodOpenSource/very_good_templates/pull/6))
- chore: update bricks to Mason 0.1.0-dev.52 ([#28](https://github.com/VeryGoodOpenSource/very_good_templates/pull/28))

## 0.0.2

- build(deps-dev): bump @tsconfig/docusaurus in /src/very_good_docs_site ([#135](https://github.com/VeryGoodOpenSource/very_good_docs_site/pull/135))
- chore: generate template ([#136](https://github.com/VeryGoodOpenSource/very_good_docs_site/pull/136))
- build(deps): bump @docusaurus/core in /src/very_good_docs_site ([#140](https://github.com/VeryGoodOpenSource/very_good_docs_site/pull/140))
- build(deps): bump @docusaurus/preset-classic in /src/very_good_docs_site ([#137](https://github.com/VeryGoodOpenSource/very_good_docs_site/pull/137))
- build(deps): bump actions/setup-node from 3 to 4 ([#145](https://github.com/VeryGoodOpenSource/very_good_docs_site/pull/145))
- chore: request code ownership ([#147](https://github.com/VeryGoodOpenSource/very_good_docs_site/pull/147))
- feat: update to docusaurs 3.0 ([#152](https://github.com/VeryGoodOpenSource/very_good_docs_site/pull/152))
- refactor: remove generator script ([#162](https://github.com/VeryGoodOpenSource/very_good_docs_site/pull/162))

## 0.0.1+7

- build(deps): various dependency updates

## 0.0.1+6

- build(deps): various dependency updates

## 0.0.1+5

- build(deps): various dependency updates

## 0.0.1+4

- build(deps): various dependency updates

## 0.0.1+3

- build(deps): upgrade to docusaurus 2.2.0

## 0.0.1+2

- refactor: use npm

## 0.0.1+1

- build(deps): upgrade lockfile

## 0.0.1

- feat: initial release 🎉

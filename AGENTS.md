# AGENTS.md

Guidance for AI agents working in this repository. Every item here is something
an agent would likely get wrong without it.

## What this repo is

A monorepo of [Mason][mason] brick templates published to
[brickhub.dev][brickhub] and consumed by [Very Good CLI][vgv_cli]. Each
top-level directory (except `tool/` and `.github/`) is a self-contained brick.

## Active vs. deprecated templates

**Active bricks** (registered in `mason.yaml`, tracked by release-please):

- `very_good_app_ui`
- `very_good_core`
- `very_good_dart_cli`
- `very_good_dart_package`
- `very_good_docs_site`
- `very_good_flame_game`
- `very_good_flutter_package`
- `very_good_flutter_plugin`

**Deprecated bricks** — do not edit, do not add to CI, do not bump versions:

- `very_good_wear_app` — marked `[DEPRECATED]` in its `brick.yaml` description,
  absent from `mason.yaml`, `.release-please-config.json`, and dependabot config.

To identify a deprecated template: its `brick.yaml` description starts with
`[DEPRECATED]` and it is absent from `mason.yaml`.

## Template directory layout

```
<template>/
  __brick__/      # Mustache template files — the actual generated output
  hooks/          # pre_gen.dart / post_gen.dart + lib/ + test/
  brick.yaml      # Brick metadata and variable definitions
  config.json     # Default variable values used by CI (and local generation)
  version.txt     # Single-line version tracked by release-please
  CHANGELOG.md    # Auto-generated — never edit by hand
```

## Never touch these files manually

- `version.txt` — owned by release-please; editing it breaks automated releases.
- `brick.yaml` version field — synced automatically from `version.txt` by
  release-please via `extra-files`.
- `CHANGELOG.md` — auto-generated from Conventional Commits.
- `very_good_flutter_plugin/hooks/lib/version.dart` — also synced by
  release-please; the `$templateVersion` constant is updated automatically.

## Introducing or removing brick variables

When adding, renaming, or removing a variable:

1. Update `vars:` in `brick.yaml`.
2. Update `config.json` with a matching default value (CI uses this file to
   generate the brick — a missing key will break the build).
3. Update the hook (`hooks/pre_gen.dart` or `hooks/post_gen.dart`) to handle
   the variable — Mustache is logic-less, so all derived variables must be
   computed in the hook and injected into `context.vars`.
4. Update `__brick__/` template files to use the new variable.

Never add logic to `__brick__/` files beyond Mustache tags. All conditional
logic belongs in the hook.

## Release process — hands off

Versioning is fully automated. You must not:

- Manually edit `version.txt`, `brick.yaml` version, or `CHANGELOG.md`.
- Create release tags or GitHub Releases by hand.
- Merge a release PR unless the team has confirmed the release is ready.

How it works: every commit to `main` is analyzed by
[release-please][release_please]. If a version bump is warranted, it opens or
updates a release PR per template. Merging that PR creates a Git tag, publishes
a GitHub Release, and triggers the publish workflow that pushes the brick to
brickhub.dev.

## Conventional Commits — required, scoped to template

PR titles and commit messages must follow [Conventional Commits][conv_commits].
The semantic PR title check is enforced by CI.

Scope commits to the template directory name:

```
feat(very_good_core): add Windows platform support
fix(very_good_dart_cli): correct executable name default
docs(very_good_flutter_plugin): update README usage section
chore(very_good_dart_package): tighten dependency constraints
```

Only these types appear in changelogs: `feat`, `fix`, `refactor`, `chore`,
`docs`. A commit without a recognized type still lands but does not trigger a
version bump.

## Local development commands

```bash
# Fetch all bricks (run from repo root)
mason get

# Generate a template locally using its CI config
mason make very_good_core -c very_good_core/config.json \
  --on-conflict overwrite -o very_good_core_output

# Install deps in the generated output
very_good packages get --recursive very_good_core_output

# Verify the generated output
dart format --set-exit-if-changed very_good_core_output
dart analyze --fatal-infos --fatal-warnings very_good_core_output
cd very_good_core_output && very_good test -r --coverage \
  --test-randomize-ordering-seed random

# Test a template's hooks in isolation
cd very_good_core/hooks
dart test
```

Replace `very_good_core` with the template you are working on. The output
directory is always `<template_name>_output` (gitignored).

## Hooks test coverage

Hooks are tested as a standalone Dart package under `<template>/hooks/`. CI
enforces 100% coverage reported against `pre_gen.dart` (see
`report_on: "pre_gen.dart"` in each `*_hooks.yaml` workflow). You must keep
hook tests passing and at full coverage.

## Dependency tightening

Template `pubspec.yaml` files inside `__brick__/` use Mustache variables (for
example `{{project_name}}`), which breaks standard pub tooling. The custom
`tool/dependency_tightener` CLI handles this. A weekly bot runs it
automatically and opens a PR. You do not need to run it manually unless
debugging dependency issues.

## Spell checking

cspell runs on all `**/*.{md,dart}` files. Custom dictionaries live in
`.github/.cspell/`. If you introduce a new technical term or proper noun that
cspell flags, add it to the appropriate dictionary file rather than suppressing
the check inline.

## CI workflow map

| Workflow file                   | What it checks                                                  |
| ------------------------------- | --------------------------------------------------------------- |
| `very_good_<name>.yaml`         | Generates brick, installs deps, formats, analyzes, tests output |
| `very_good_<name>_hooks.yaml`   | Formats, analyzes, and tests the hook package                   |
| `publish_very_good_<name>.yaml` | Publishes to brickhub.dev on version tag                        |
| `release_please.yaml`           | Opens/updates release PRs on push to `main`                     |
| `semantic_pull_request.yaml`    | Enforces Conventional Commit PR titles                          |
| `spell_checker.yaml`            | Runs cspell on all `.md` and `.dart` files                      |
| `bot_dependency_tightener.yaml` | Weekly automated dependency tightening                          |

[mason]: https://docs.brickhub.dev
[brickhub]: https://brickhub.dev
[vgv_cli]: https://cli.vgv.dev
[release_please]: https://github.com/googleapis/release-please-action
[conv_commits]: https://www.conventionalcommits.org/en/v1.0.0

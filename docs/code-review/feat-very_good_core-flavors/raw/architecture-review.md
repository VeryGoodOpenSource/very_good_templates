# Architecture Review — very_good_core flavors

Branch `feat/very_good_core/flavors`. All changes are uncommitted in the working tree.

Scope: the flavors feature for the `very_good_core` Mason brick. Reviewed the hooks Dart
package (`flavor.dart`, `pre_gen.dart`, `models.dart`), the logic/template separation,
brick-variable wiring across `brick.yaml` / `config.json` / hook / templates, and the
`{{#flavors}}` / `{{^flavors}}` on/off branching in `__brick__`.

## Verification performed

- `mason make` with the flavored `config.json` (`development,staging,production`): generates
  `lib/main_{dev,staging,production}.dart`, three `.idea` run configs, per-flavor Android
  product flavors, and per-flavor Xcode schemes. No template errors.
- `mason make` with a no-flavors config (`["production"]`): collapses to `lib/main.dart`,
  a single `main.xml`, no Android `productFlavors` block, `Runner.xcscheme` only, and a plain
  `android:label`. Both branches generate correctly.
- Hooks package: all 52 tests pass (`dart test`).
- `dart analyze` on the flavored output: the only errors are missing `AppLocalizations`
  (l10n codegen not run in this harness) — unrelated to flavors.

The core architectural goal holds: every derived value is computed in the hook and the
templates stay logic-less.

## 1. Layer separation

The hooks package is a standalone Dart package with a single responsibility: compute derived
variables for generation. No layering violations.

- `flavor.dart` is a pure model — no I/O, no `mason`/`HookContext` dependency. It only imports
  `equatable`. Correct: models stay independent of the generation runtime.
- `pre_gen.dart` is the only file that touches `HookContext`, and it delegates parsing to
  `resolveFlavors` and serialization to `Flavor.toJson`. Orchestration stays thin.
- `__brick__` templates contain only Mustache tags (sections, inverted sections, variable
  substitution). No conditional/derivation logic leaked into templates. Confirmed by reading
  `build.gradle.kts`, both `project.pbxproj`, the xcscheme, `launch.json`, `README.md`, and the
  new path-conditional files.

Clean.

## 2. State management / model design

`Flavor` (`very_good_core/hooks/lib/src/models/flavor.dart`) is well-formed:

- Extends `Equatable`, immutable, `const` constructor, `props` on `name`. Consistent with the
  other models in the package (`AndroidApplicationId`, `AppleApplicationId`, etc.).
- All naming derivations (`applicationIdSuffix`, `label`, `iconSuffix`, `main`, `mainFile`,
  `runConfigurationFile`, `schemeFile`) are pure getters keyed off `name` and `isDefault`.
- `_flavorAbbreviations` preserves the previous hardcoded output (`dev`/`stg`) while allowing
  arbitrary flavor names to fall back to their own name. Good backward-compatibility design.
- `resolveFlavors` handles `null`, `String`, `List`, and the invalid case (throws
  `ArgumentError`), dedups preserving order, and always appends the default. The "only default
  ⇒ empty list" rule is the pivot the whole on/off design rests on and it is expressed once,
  in one place.

Observations:

- **Xcode id over-generation.** `_xcodeConfigurationIds()` emits 12 identifier slots for every
  flavor, including `debug_assemble_id` / `release_assemble_id` / `profile_assemble_id`. iOS
  uses none of the three assemble ids (grep count 0 in the iOS `project.pbxproj`); only macOS
  consumes them (6 references). The extra map entries are harmless but the model carries
  platform-specific knowledge (the macOS "Flutter Assemble" aggregate target) for all flavors
  regardless of selected platforms. This is a Suggestion, not a defect — the ids are cheap and
  deterministic.
- **Hand-rolled FNV-1a identifier hashing.** `_identifier` combines three salted FNV-1a hashes
  to build a 24-char hex id. It is deterministic, collision-safe within a single project, and
  tested. Reasonable given the constraint that Xcode ids only need per-file uniqueness. No
  action required.

## 3. Dependency direction & variable wiring

The variable contract is consistent across the four surfaces:

- `brick.yaml` declares `flavors` as `type: list` with `separator: ","` and documents that
  `production` is always included and that only-production generates a plain app.
- `config.json` provides `["development", "staging", "production"]` (CI default), matching the
  declared variable — no missing key that would break CI generation.
- `pre_gen.dart` reads `context.vars['flavors']`, runs it through `resolveFlavors`, and injects
  `'flavors': [for (final flavor in flavors) flavor.toJson()]`.
- Templates consume the injected keys (`name`, `is_default`, `application_id_suffix`, `label`,
  `main`, `main_file`, `run_configuration_file`, `scheme_file`, and the Xcode id slots). Every
  key consumed in `__brick__` is produced by `toJson()`; verified by grep.

`iconSuffix` (`icon_suffix`) is produced and consumed only in the iOS/macOS `project.pbxproj`.
`label` and `application_id_suffix` are consumed in Android + iOS + macOS. No orphaned template
placeholders and no unproduced keys.

No circular or reverse dependencies — the hooks package depends on `mason`, `equatable`,
`clock`; templates depend on nothing (they are text).

## 4. On/off branching design (`{{#flavors}}` / `{{^flavors}}`)

The branching uses three complementary Mustache idioms, all verified to generate correctly:

1. **Path-based file conditionals.** `lib/{{#flavors}}{{{main_file}}}{{/flavors}}` expands once
   per flavor to `main_development.dart` etc.; `lib/{{^flavors}}main.dart{{/flavors}}` collapses
   to an empty path (skipped) when flavors exist, and to `main.dart` when the list is empty.
   Same idiom for `.idea` run configs and iOS/macOS schemes. Correct and idiomatic for Mason.

2. **"Run once when flavors present" guard.** `{{#flavors}}{{#is_default}} ... {{/is_default}}{{/flavors}}`
   emits a block exactly once (there is always exactly one default flavor). Used for the Android
   `flavorDimensions`/`productFlavors` wrapper and the README header.

3. **Nested same-name section.** Inside the guard, `{{#flavors}} ... {{/flavors}}` iterates all
   flavors again. This relies on Mustache resolving the inner `flavors` name by walking up the
   context stack (a `Flavor` json has no `flavors` key, so it falls back to the parent list).
   Verified working with mason 0.1.2, but it is non-obvious and fragile: a future change that
   adds a `flavors` key to `toJson()` would silently break the inner loop. Worth a short
   template comment or a distinct helper key to make intent explicit. Important-severity
   maintainability note.

Findings:

- **Duplicated main entrypoint template.** `lib/{{#flavors}}{{{main_file}}}{{/flavors}}` and
  `lib/{{^flavors}}main.dart{{/flavors}}` contain byte-identical bodies. Mason path conditionals
  require two separate files, so some duplication is unavoidable, but the shared body means any
  future change to `main` must be made in two places with no mechanism to keep them in sync.
  Consider documenting the pairing. Suggestion.

## Package structure

The hooks package remains well-structured:

- `flavor.dart` placed under `lib/src/models/` alongside the other models, exported from
  `models.dart` (the barrel), which is re-exported by the package entrypoint. Consistent.
- `flavor_test.dart` sits at `test/src/models/flavor_test.dart`, mirroring the source layout —
  matches the existing test convention.
- No new dependency added; `equatable` was already present.
- Hook test coverage: the new `flavors` path in `pre_gen.dart` is exercised by the added
  `injects resolved flavors` test, and the `populates variables` test covers the empty-flavors
  default. CI enforces 100% on `pre_gen.dart`; the change keeps that intact.

## Verdict

Architecture is clean. The logic/template separation is exactly right, the variable contract is
consistent across all four surfaces, and both the flavored and no-flavors branches generate and
analyze correctly. No Critical issues. The nested same-name `{{#flavors}}` section is the one
item worth hardening before merge (maintainability, not correctness); the rest are suggestions.

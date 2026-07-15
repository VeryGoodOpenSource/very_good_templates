# Code Simplicity Review — feat/very_good_core/flavors

**Branch**: `feat/very_good_core/flavors`  
**Reviewed**: 2026-07-14  
**Scope**: `very_good_core/` only — hooks, `__brick__` templates, `brick.yaml`, `config.json`

---

## Simplification Analysis

### Core Purpose

The branch replaces three hard-coded flavor files (`main_development.dart`, `main_staging.dart`, `main_production.dart`, three sets of Xcode schemes, three IntelliJ run configurations) with a single `Flavor` model that drives Mustache loops. A user can now supply an arbitrary list of flavors, or none at all, and the template adapts accordingly.

---

### Unnecessary Complexity Found

#### 1. `mainFile` and `main` are the same information expressed twice

`flavor.dart` lines 55–62 define two getters that both derive from `name`:

```dart
String get main => 'lib/main_$name.dart';      // full path
String get mainFile => 'main_$name.dart';       // file name only
```

`main_file` exists solely so the Mason directory loop `{{#flavors}}{{{main_file}}}{{/flavors}}` emits only the filename (not the full path). The `main` full-path value is used inside template file content for `FLUTTER_TARGET`, the `.vscode/launch.json` `program` key, and the IntelliJ run config. The distinction is real, but the naming `main` vs `mainFile` is confusing — one is a path, the other a bare filename. A clearer pair would be `mainPath` / `mainFile` (or `entrypoint` / `entryFile`).

More importantly, `mainFile` is tested nowhere in `flavor_test.dart`. The test at line 68 checks `json['main']` but never checks `json['main_file']`. If `mainFile` were removed or broken, the tests would still pass.

#### 2. `runConfigurationFile` and `schemeFile` are trivial one-liners that add cognitive surface area

`flavor.dart` lines 66–68:

```dart
String get runConfigurationFile => '$name.xml';
String get schemeFile => '$name.xcscheme';
```

These exist only as Mason path-loop segments (the directory name itself is the variable). Each is a single string interpolation. They add two named concepts to the model for what is essentially the same transformation (`'$name.<extension>'`). Neither getter is tested directly.

The Mason path loop is `{{#flavors}}{{{run_configuration_file}}}{{/flavors}}`. If Mason supports inline expressions in path segments, the getters could be inlined. If it does not (Mason is logic-less), the getters must stay — but they could be collapsed into `toJson()` directly without named getters, reducing the public API surface of `Flavor`.

#### 3. Manual deduplication loop is slower and less expressive than `LinkedHashSet`

`resolveFlavors` lines 170–174 (flavor.dart):

```dart
final ordered = <String>[];
for (final name in names) {
  if (!ordered.contains(name)) ordered.add(name);
}
```

`List.contains` is O(n), making the whole loop O(n²). A `LinkedHashSet` preserves insertion order and deduplicates in O(1) per element:

```dart
final ordered = LinkedHashSet<String>.from(names);
ordered.add(defaultFlavorName);
```

For template generation this performance gap is irrelevant in practice, but the `LinkedHashSet` version is shorter and more expressive. The `dart:collection` import is already available.

#### 4. `is_default` exposed as a template variable creates a two-level Mustache nesting anti-pattern

In `build.gradle.kts` (line 58) and `AndroidManifest.xml` (line 3), the template must write `{{#flavors}}{{#is_default}}...{{/is_default}}{{/flavors}}` to extract a single boolean value from the flavors list. This pattern treats the list iteration as a conditional, which is an awkward workaround.

The root cause: `is_default` is a field on each `Flavor` map, but the template only needs it once — to gate the entire `productFlavors { }` block and the `appName` placeholder. The hook could instead inject a separate top-level boolean `has_flavors` (which it effectively does via `flavors` being non-empty), making the template read `{{#flavors}}...{{/flavors}}` for the outer gate and `{{name}}` inside. The existing `{{^flavors}}` / `{{#flavors}}` top-level guards already do this for most files — `build.gradle.kts` is the one template that uses `is_default` as a nested sentinel. This inconsistency makes the template harder to follow.

The fix: in `build.gradle.kts`, replace the `{{#flavors}}{{#is_default}}` outer wrapper with a plain `{{#flavors}}` (the list is already non-empty when flavors are enabled) and remove `is_default` from `toJson()` and the model.

However, `AndroidManifest.xml` also uses `is_default` in a different way — to decide whether to use `${appName}` (Android manifest placeholder) or the project title. This is a legitimate conditional that `is_default` enables.

So `is_default` cannot be entirely removed without rethinking the manifest label approach. It can be simplified in `build.gradle.kts` specifically, but its presence in the model is justified.

#### 5. `_flavorAbbreviations` map introduces special-casing that leaks into the public contract

`flavor.dart` lines 13–16:

```dart
const _flavorAbbreviations = <String, String>{
  'development': 'dev',
  'staging': 'stg',
};
```

This map exists to produce shorter suffixes for the two "known" flavors. Any other flavor name uses itself as the abbreviation. This is the right design for the stated goal of matching prior behavior exactly.

However, the map is a private constant at module level. If a user adds a new "well-known" flavor (say `qa`), they must edit this file. That is fine for now (YAGNI: no extensibility mechanism needed), but it should be clearly documented that this is a conscious decision, not an oversight. The existing comment at line 11 does explain this — no action required.

---

### Code to Remove

| Location | Reason | Estimated LOC reduction |
|---|---|---|
| `flavor.dart:62` — `mainFile` getter | Tested nowhere; name is confusing; same info as `main` minus the prefix | −3 (getter + doc comment) |
| `flavor.dart:66–68` — `runConfigurationFile`, `schemeFile` | Single-expression getters; could be inlined into `toJson()` directly | −6 |
| `flavor.dart:170–173` — manual dedup loop | Replace with `LinkedHashSet` | −2 |

---

### Simplification Recommendations

#### 1. Rename `main` to `mainPath` (or `entrypoint`) and test `mainFile`

**Current**: `main` returns a full path; `mainFile` returns a filename; neither name makes the distinction obvious.  
**Proposed**: `mainPath` / `mainFile` (or `entrypoint` / `entryFile`). Add a direct test for `main_file` in `toJson`.  
**Impact**: Removes confusion when reading `toJson()`; ensures the file-loop variable is regression-tested.

#### 2. Inline `runConfigurationFile` and `schemeFile` into `toJson`

**Current**: Two public getters each delegating to `'$name.<ext>'`.  
**Proposed**: Remove the getters; write `'run_configuration_file': '$name.xml'` and `'scheme_file': '$name.xcscheme'` directly inside `toJson()`.  
**Impact**: −6 LOC; fewer named concepts on `Flavor`; easier to understand the full set of template variables from one place.

#### 3. Replace the manual deduplication loop with `LinkedHashSet`

**Current**: O(n²) loop with `List.contains`.  
**Proposed**:

```dart
import 'dart:collection';

final ordered = LinkedHashSet<String>.from(names)..add(defaultFlavorName);
if (ordered.length == 1) return const [];
return ordered.map(Flavor.new).toList();
```

**Impact**: −3 LOC; idiomatic Dart; same behavior.

#### 4. Remove `is_default` from the `build.gradle.kts` outer wrapper

**Current**: `{{#flavors}}{{#is_default}}...{{/is_default}}{{/flavors}}` wraps the entire `productFlavors` block. `is_default` is used as a "trigger once" flag on the production flavor — but the production flavor is always present, so this always fires exactly once. It works but is misleading.  
**Proposed**: Replace with `{{#flavors}}` directly (the outer list guard is sufficient). Keep `is_default` in the manifest where it serves a real boolean role.  
**Impact**: Removes the appearance of a per-flavor conditional that only ever runs once.

---

### YAGNI Violations

None identified. The new model supports only what the templates require. No extensibility hooks, registries, or plugin interfaces were added.

The Xcode ID generation via FNV-1a hashing is more complex than a simple counter but is justified: deterministic reproducible IDs are a hard requirement for the pbxproj format, and the algorithm is clearly documented with comments, short (18 LOC), and tested.

---

### Final Assessment

**Total potential LOC reduction**: ~9–12 lines (under 5% of the changed surface area)  
**Complexity score**: Low  
**Recommended action**: Minor tweaks only

The design is sound. Three-file hard-coding replaced with a proper loop-driven model. The `Flavor` class encapsulates all derived values in one place, tests are comprehensive, and the hook remains thin. The issues above are refinements, not structural problems.

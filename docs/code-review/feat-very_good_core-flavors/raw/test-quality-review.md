# Test Quality Review — feat/very_good_core/flavors

## Coverage Summary

- **Test run**: Pass (52/52 tests)
- **Coverage**: 100% of `pre_gen.dart` (every executable line hit; CI enforces `report_on: "pre_gen.dart"`)
- **Files with tests**: All testable units covered
- **Missing test files**: None

### Execution

```
dart test (from very_good_core/hooks/)
00:00 +52: All tests passed!
```

Coverage was collected with `dart test --coverage=coverage` and formatted with `format_coverage --report-on=pre_gen.dart`. Every line in `pre_gen.dart` shows a hit count ≥ 1.

---

## New / Changed Files Under Review

| File | Status |
|------|--------|
| `very_good_core/hooks/pre_gen.dart` | Modified — added `resolveFlavors` call and `'flavors'` var injection |
| `very_good_core/hooks/lib/src/models/flavor.dart` | New — `Flavor` class + `resolveFlavors` function |
| `very_good_core/hooks/lib/src/models/models.dart` | Modified — exports `flavor.dart` |
| `very_good_core/hooks/test/pre_gen_test.dart` | Modified — added `flavors` to expected map; added "injects resolved flavors" test |
| `very_good_core/hooks/test/src/models/flavor_test.dart` | New — full unit test suite for `Flavor` and `resolveFlavors` |

---

## Hook (pre_gen.dart) Test Quality

**File**: `very_good_core/hooks/test/pre_gen_test.dart`

**Overall**: Pass with one gap.

### What is covered

| Scenario | Test |
|----------|------|
| All platforms selected, no flavors key | "populates variables" — full map equality assertion |
| Partial platform selection | "platform options" |
| Comma-separated platforms string | "parses a comma separated platforms string" |
| Flavors as List | "injects resolved flavors" |
| Invalid platforms type | "throws ArgumentError if platforms is not a list" |
| `flavors` key absent (null path) | Covered implicitly by "populates variables" (no `flavors` key in vars, asserts `'flavors': []`) |

### Gaps

**Missing scenario — flavors as comma-separated String via `pre_gen.run`.**
`pre_gen.dart` line 22 calls `resolveFlavors(context.vars['flavors'] as Object?)`. The `resolveFlavors` function handles three raw types: `null`, `List<dynamic>`, and `String`. `flavor_test.dart` covers all three at the `resolveFlavors` unit level, and `pre_gen_test.dart` covers `null` (no key) and `List`. It does not exercise the `String` branch through `pre_gen.run`. Since CI coverage is reported only on `pre_gen.dart` — not on `flavor.dart` — and the `String` branch of `resolveFlavors` is called from line 22 of `pre_gen.dart`, this path is technically covered by "injects resolved flavors" only for the `List` form. A test passing `'flavors': 'development,staging'` (String) through `pre_gen.run` is absent.

This is a coverage gap at the integration point rather than the unit level. Whether it breaks CI's 100% depends on how `dart coverage` attributes the switch branch inside `resolveFlavors` when called from `pre_gen.dart`. The lcov report shows line 22 (`final flavors = resolveFlavors(...)`) hit 3 times — but branch coverage of the switch inside `resolveFlavors` is not tracked at the `pre_gen.dart` report boundary. Low severity for CI but a real behavioral gap.

**Missing assertion depth in "injects resolved flavors".**
The test checks only `flavor['name']` from the resolved list. It does not verify that any derived fields (`application_id_suffix`, `label`, `main_file`, `run_configuration_file`, `scheme_file`) are present in the injected map. This means a regression in `toJson()` field names would not be caught at the `pre_gen` integration level (though it would be caught in `flavor_test.dart`).

---

## Model (flavor.dart) Test Quality

**File**: `very_good_core/hooks/test/src/models/flavor_test.dart`

**Overall**: Pass with minor gaps.

### What is covered

| Scenario | Test |
|----------|------|
| Value equality | "supports value equality" (equal and not-equal case) |
| `isDefault` for production | "is default" |
| Empty suffix/label/iconSuffix for production | "has no naming decoration" |
| `main` getter for production | "has a main entrypoint" |
| `development` abbreviation (`dev`) | "development uses the 'dev' abbreviation" — all four getters |
| `staging` abbreviation (`stg`) | "staging uses the 'stg' abbreviation" — three getters |
| Custom flavor fallback | "fall back to using the flavor name" |
| `toJson` key presence and values | "exposes all template variables" |
| Xcode ID format and uniqueness | "exposes deterministic 24 char hex Xcode identifiers" |
| Cross-flavor ID distinctness | "generates distinct identifiers across flavors" |
| `resolveFlavors(null)` | "returns empty list when raw value is null" |
| `resolveFlavors` with only default flavor | "returns empty list when only the default flavor is present" |
| `resolveFlavors` with List | "parses a list of flavor names" |
| `resolveFlavors` with String | "parses a comma separated string of flavor names" |
| Auto-adds default flavor | "always includes the default flavor" |
| Deduplication | "deduplicates flavor names preserving order" |
| Custom flavor names | "supports arbitrary custom flavor names" |
| Invalid raw type | "throws ArgumentError when raw value is not supported" |

### Gaps

**`toJson` test omits `main_file`, `run_configuration_file`, and `scheme_file` keys.**
`Flavor.toJson()` (lines 72–84 of `flavor.dart`) serializes nine string fields plus the Xcode IDs. The test at line 62–69 of `flavor_test.dart` checks `name`, `is_default`, `application_id_suffix`, `label`, `icon_suffix`, and `main` — but skips `main_file`, `run_configuration_file`, and `scheme_file`. These three getters (lines 62–69 of `flavor.dart`) have no direct assertion. A silent rename of those keys in `toJson` would not be caught.

**`staging` test does not check `main` getter.**
The "staging uses the 'stg' abbreviation" test (lines 43–47) checks `applicationIdSuffix`, `label`, and `iconSuffix` but omits `main` and the file-name getters. The `development` test checks `main`; parity with staging is missing.

**Xcode ID test only uses `development` flavor.**
The cross-flavor test (line 99) checks one pair of IDs. It does not verify that `staging` and custom flavor IDs also match their format and are internally unique. This is a minor gap — the hash function is deterministic, but a flavor-name-specific edge case (e.g., very short names, names with special characters) is untested.

**`resolveFlavors` "only default flavor" test conflates three behaviors.**
Test at line 112 asserts three distinct inputs (`['production']`, `<String>[]`, `''`) produce the same result in a single `test` block. These are separate behaviors (explicit default only, empty list, empty string) and deserve individual test cases for clarity and fault isolation.

---

## Pattern Compliance

| Check | Result |
|-------|--------|
| `package:test` used | Pass |
| `package:mocktail` used (no mockito) | Pass |
| Private mock class (`_MockHookContext`) | Pass |
| `setUp` inside `group` | Pass |
| `late` + `setUp` for mutable state | Pass |
| `group` hierarchy (class → method → behavior) | Pass for `flavor_test.dart`; `pre_gen_test.dart` has a flat group with no method-level subgroups — acceptable since `run` is the single public function |
| Descriptive test names | Pass — names read as specifications |
| String interpolation for type in throw test | Pass (`'throws $ArgumentError ...'`) |
| No tautological assertions | Pass |
| No setup at `main()` level | Pass |
| No shared mutable state between tests | Pass |
| Test file mirrors `lib/` structure | Pass — `lib/src/models/flavor.dart` → `test/src/models/flavor_test.dart` |

---

## Anti-Pattern Detection

No anti-patterns found. Specifically:

- No tautological assertions (`expect(true, isTrue)` style)
- No mocking of the class under test
- No implementation mirroring
- No empty test bodies
- No hardcoded magic values without context (the `2020` year is anchored to `Clock.fixed(DateTime(2020))`)
- No over-verification of mock calls beyond what is needed

---

## Recommendations

1. **Add `main_file`, `run_configuration_file`, and `scheme_file` assertions to `toJson` test** — these three getters are the file-loop anchors for the Mustache templates and a silent rename would produce broken template output.

2. **Add a `pre_gen_test` case for `flavors` passed as a comma-separated String** — exercise the full String branch of `resolveFlavors` through `pre_gen.run` to close the integration-level gap.

3. **Split the `resolveFlavors` "only default flavor" test into three separate tests** — one for `['production']`, one for `<String>[]`, and one for `''`. Each is a distinct input shape.

4. **Add `main` getter assertion to the staging well-known-flavors test** — maintains parity with the development test.

---

## Verdict

All tests pass and `pre_gen.dart` has 100% line coverage. The `Flavor` model and `resolveFlavors` function are well-exercised with meaningful assertions. No anti-patterns found. Fix the three Important issues (`main_file`/`run_configuration_file`/`scheme_file` not checked in `toJson`, String flavors path untested through `pre_gen.run`, multi-behavior single test block) before merge to prevent silent template regressions and keep the suite honest.

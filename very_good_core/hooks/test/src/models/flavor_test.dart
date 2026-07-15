import 'package:test/test.dart';
import 'package:very_good_core_hooks/very_good_core_hooks.dart';

void main() {
  group('Flavor', () {
    test('supports value equality', () {
      expect(const Flavor('development'), equals(const Flavor('development')));
      expect(
        const Flavor('development'),
        isNot(equals(const Flavor('staging'))),
      );
    });

    group('default flavor (production)', () {
      const flavor = Flavor(defaultFlavorName);

      test('is default', () {
        expect(flavor.isDefault, isTrue);
      });

      test('has no naming decoration', () {
        expect(flavor.applicationIdSuffix, isEmpty);
        expect(flavor.label, isEmpty);
        expect(flavor.iconSuffix, isEmpty);
      });

      test('has a main entrypoint', () {
        expect(flavor.main, equals('lib/main_production.dart'));
      });
    });

    group('well known flavors', () {
      test('development uses the "dev" abbreviation', () {
        const flavor = Flavor('development');
        expect(flavor.isDefault, isFalse);
        expect(flavor.applicationIdSuffix, equals('.dev'));
        expect(flavor.label, equals('[DEV] '));
        expect(flavor.iconSuffix, equals('-dev'));
        expect(flavor.main, equals('lib/main_development.dart'));
      });

      test('staging uses the "stg" abbreviation', () {
        const flavor = Flavor('staging');
        expect(flavor.applicationIdSuffix, equals('.stg'));
        expect(flavor.label, equals('[STG] '));
        expect(flavor.iconSuffix, equals('-stg'));
      });
    });

    group('custom flavors', () {
      test('fall back to using the flavor name', () {
        const flavor = Flavor('qa');
        expect(flavor.applicationIdSuffix, equals('.qa'));
        expect(flavor.label, equals('[QA] '));
        expect(flavor.iconSuffix, equals('-qa'));
        expect(flavor.main, equals('lib/main_qa.dart'));
      });
    });

    group('toJson', () {
      test('exposes all template variables', () {
        final json = const Flavor('development').toJson();
        expect(json['name'], equals('development'));
        expect(json['is_default'], isFalse);
        expect(json['application_id_suffix'], equals('.dev'));
        expect(json['label'], equals('[DEV] '));
        expect(json['icon_suffix'], equals('-dev'));
        expect(json['main'], equals('lib/main_development.dart'));
      });

      test('exposes deterministic 24 char hex Xcode identifiers', () {
        final json = const Flavor('development').toJson();
        const idKeys = [
          'debug_project_id',
          'debug_target_id',
          'debug_tests_id',
          'release_project_id',
          'release_target_id',
          'release_tests_id',
          'profile_project_id',
          'profile_target_id',
          'profile_tests_id',
          'debug_assemble_id',
          'release_assemble_id',
          'profile_assemble_id',
        ];
        final ids = <String>{};
        for (final key in idKeys) {
          final id = json[key] as String;
          expect(id, matches(RegExp(r'^[0-9A-F]{24}$')));
          ids.add(id);
        }
        // All identifiers within a flavor are unique.
        expect(ids, hasLength(idKeys.length));
        // Generation is reproducible.
        expect(json, equals(const Flavor('development').toJson()));
      });

      test('generates distinct identifiers across flavors', () {
        final dev = const Flavor('development').toJson();
        final stg = const Flavor('staging').toJson();
        expect(dev['debug_project_id'], isNot(equals(stg['debug_project_id'])));
      });
    });
  });

  group('resolveFlavors', () {
    test('returns empty list when raw value is null', () {
      expect(resolveFlavors(null), isEmpty);
    });

    test('returns empty list when only the default flavor is present', () {
      expect(resolveFlavors(['production']), isEmpty);
      expect(resolveFlavors(<String>[]), isEmpty);
      expect(resolveFlavors(''), isEmpty);
    });

    test('parses a list of flavor names', () {
      final flavors = resolveFlavors(['development', 'staging', 'production']);
      expect(
        flavors.map((flavor) => flavor.name),
        equals(['development', 'staging', 'production']),
      );
    });

    test('parses a comma separated string of flavor names', () {
      final flavors = resolveFlavors('development, staging , production');
      expect(
        flavors.map((flavor) => flavor.name),
        equals(['development', 'staging', 'production']),
      );
    });

    test('always includes the default flavor', () {
      final flavors = resolveFlavors(['development']);
      expect(
        flavors.map((flavor) => flavor.name),
        equals(['development', 'production']),
      );
    });

    test('deduplicates flavor names preserving order', () {
      final flavors = resolveFlavors([
        'development',
        'development',
        'staging',
      ]);
      expect(
        flavors.map((flavor) => flavor.name),
        equals(['development', 'staging', 'production']),
      );
    });

    test('supports arbitrary custom flavor names', () {
      final flavors = resolveFlavors('free,pro');
      expect(
        flavors.map((flavor) => flavor.name),
        equals(['free', 'pro', 'production']),
      );
    });

    test('throws $ArgumentError when raw value is not supported', () {
      expect(() => resolveFlavors(42), throwsA(isA<ArgumentError>()));
    });
  });
}

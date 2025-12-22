import 'package:dependency_tightener/dependency_tightener.dart';
import 'package:test/test.dart';

void main() {
  group('PinnedPackage', () {
    test('can be instantiated', () {
      const package = PinnedPackage(
        name: 'test_package',
        reason: 'Test reason',
      );

      expect(package.name, equals('test_package'));
      expect(package.reason, equals('Test reason'));
    });
  });

  group('pinnedPackages', () {
    test('contains intl package', () {
      expect(
        pinnedPackages.any((p) => p.name == 'intl'),
        isTrue,
      );
    });

    test('all packages have non-empty names', () {
      for (final package in pinnedPackages) {
        expect(package.name, isNotEmpty);
      }
    });

    test('all packages have non-empty reasons', () {
      for (final package in pinnedPackages) {
        expect(package.reason, isNotEmpty);
      }
    });
  });

  group('pinnedPackageNames', () {
    test('returns set of package names', () {
      final names = pinnedPackageNames;

      expect(names, contains('intl'));
    });

    test('has same length as pinnedPackages', () {
      expect(pinnedPackageNames.length, equals(pinnedPackages.length));
    });

    test('contains all package names from pinnedPackages', () {
      final expectedNames = pinnedPackages.map((p) => p.name).toSet();
      expect(pinnedPackageNames, equals(expectedNames));
    });
  });
}

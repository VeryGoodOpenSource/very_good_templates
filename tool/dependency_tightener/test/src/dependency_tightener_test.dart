// ignore_for_file: prefer_const_constructors
import 'package:dependency_tightener/dependency_tightener.dart';
import 'package:test/test.dart';

void main() {
  group('DependencyTightener', () {
    test('can be instantiated', () {
      expect(DependencyTightener(), isNotNull);
    });
  });
}

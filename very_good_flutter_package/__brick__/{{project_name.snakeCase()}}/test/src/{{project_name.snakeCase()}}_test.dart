// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

void main() {
  group('{{project_name.pascalCase()}}', () {
    test('can be instantiated', () {
      expect({{project_name.pascalCase()}}(), isNotNull);
    });
  });
}

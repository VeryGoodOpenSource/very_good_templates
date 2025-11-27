import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}_platform_interface/{{project_name.snakeCase()}}_platform_interface.dart';
import 'package:{{project_name.snakeCase()}}_web/{{project_name.snakeCase()}}_web.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('{{project_name.pascalCase()}}Web', () {
    const kPlatformName = 'Web';
    late {{project_name.pascalCase()}}Web {{project_name.camelCase()}};

    setUp(() {
      {{project_name.camelCase()}} = {{project_name.pascalCase()}}Web();
    });

    test('can be registered', () {
      {{project_name.pascalCase()}}Web.registerWith();
      expect({{project_name.pascalCase()}}Platform.instance, isA<{{project_name.pascalCase()}}Web>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await {{project_name.camelCase()}}.getPlatformName();
      expect(name, equals(kPlatformName));
    });
  });
}

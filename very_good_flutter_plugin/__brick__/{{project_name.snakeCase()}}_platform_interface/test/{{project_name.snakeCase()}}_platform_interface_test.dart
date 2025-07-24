import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}_platform_interface/{{project_name.snakeCase()}}_platform_interface.dart';

class {{project_name.pascalCase()}}Mock extends {{project_name.pascalCase()}}Platform {
  static const mockPlatformName = 'Mock';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('{{project_name.pascalCase()}}PlatformInterface', () {
    late {{project_name.pascalCase()}}Platform {{project_name.camelCase()}}Platform;

    setUp(() {
      {{project_name.camelCase()}}Platform = {{project_name.pascalCase()}}Mock();
      {{project_name.pascalCase()}}Platform.instance = {{project_name.camelCase()}}Platform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await {{project_name.pascalCase()}}Platform.instance.getPlatformName(),
          equals({{project_name.pascalCase()}}Mock.mockPlatformName),
        );
      });
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';
import 'package:{{project_name.snakeCase()}}_platform_interface/{{project_name.snakeCase()}}_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class Mock{{project_name.pascalCase()}}Platform extends Mock
    with MockPlatformInterfaceMixin
    implements {{project_name.pascalCase()}}Platform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('{{project_name.pascalCase()}}', () {
    late {{project_name.pascalCase()}}Platform {{project_name.camelCase()}}Platform;

    setUp(() {
      {{project_name.camelCase()}}Platform = Mock{{project_name.pascalCase()}}Platform();
      {{project_name.pascalCase()}}Platform.instance = {{project_name.camelCase()}}Platform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => {{project_name.camelCase()}}Platform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => {{project_name.camelCase()}}Platform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });
  });
}

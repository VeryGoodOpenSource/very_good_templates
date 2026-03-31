import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:{{project_name.snakeCase()}}_ios/src/messages.g.dart';
import 'package:{{project_name.snakeCase()}}_ios/{{project_name.snakeCase()}}_ios.dart';
import 'package:{{project_name.snakeCase()}}_platform_interface/{{project_name.snakeCase()}}_platform_interface.dart';

class _Mock{{project_name.pascalCase()}}Api extends Mock
    implements {{project_name.pascalCase()}}Api {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group({{project_name.pascalCase()}}IOS, () {
    const kPlatformName = 'iOS';
    late {{project_name.pascalCase()}}IOS {{project_name.camelCase()}};
    late {{project_name.pascalCase()}}Api api;

    setUp(() {
      api = _Mock{{project_name.pascalCase()}}Api();
      {{project_name.camelCase()}} = {{project_name.pascalCase()}}IOS(api: api);
    });

    test('can be registered', () {
      {{project_name.pascalCase()}}IOS.registerWith();
      expect(
        {{project_name.pascalCase()}}Platform.instance,
        isA<{{project_name.pascalCase()}}IOS>(),
      );
    });

    test('getPlatformName returns correct name', () async {
      when(api.getPlatformName).thenAnswer((_) async => kPlatformName);

      await expectLater(
        {{project_name.camelCase()}}.getPlatformName(),
        completion(equals(kPlatformName)),
      );

      verify(api.getPlatformName).called(1);
    });
  });
}

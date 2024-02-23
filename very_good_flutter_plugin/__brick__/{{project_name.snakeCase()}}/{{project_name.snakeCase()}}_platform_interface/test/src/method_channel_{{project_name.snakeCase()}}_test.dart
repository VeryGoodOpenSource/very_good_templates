import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}_platform_interface/src/method_channel_{{project_name.snakeCase()}}.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const kPlatformName = 'platformName';

  group('$MethodChannel{{project_name.pascalCase()}}', () {
    late MethodChannel{{project_name.pascalCase()}} methodChannel{{project_name.pascalCase()}};
    final log = <MethodCall>[];

    setUp(() async {
      methodChannel{{project_name.pascalCase()}} = MethodChannel{{project_name.pascalCase()}}();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        methodChannel{{project_name.pascalCase()}}.methodChannel,
        (methodCall) async {
          log.add(methodCall);
          switch (methodCall.method) {
            case 'getPlatformName':
              return kPlatformName;
            default:
              return null;
          }
        },
      );
    });

    tearDown(log.clear);

    test('getPlatformName', () async {
      final platformName = await methodChannel{{project_name.pascalCase()}}.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(platformName, equals(kPlatformName));
    });
  });
}

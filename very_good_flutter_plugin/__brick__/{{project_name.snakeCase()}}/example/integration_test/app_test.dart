import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:{{project_name.snakeCase()}}_example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('E2E', () {
    testWidgets('getPlatformName', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Get Platform Name'));
      await tester.pumpAndSettle();
      final expected = expectedPlatformName();
      await tester.ensureVisible(find.text('Platform Name: $expected'));
    });
  });
}

String expectedPlatformName() {
{{#web}}  if (isWeb) return 'Web';
{{/web}}{{#android}}  if (Platform.isAndroid) return 'Android';
{{/android}}{{#ios}}  if (Platform.isIOS) return 'iOS';
{{/ios}}{{#linux}}  if (Platform.isLinux) return 'Linux';
{{/linux}}{{#macos}}  if (Platform.isMacOS) return 'MacOS';
{{/macos}}{{#windows}}  if (Platform.isWindows) return 'Windows';
{{/windows}}  throw UnsupportedError('Unsupported platform ${Platform.operatingSystem}');
}
{{#web}}
bool get isWeb => identical(0, 0.0);
{{/web}}

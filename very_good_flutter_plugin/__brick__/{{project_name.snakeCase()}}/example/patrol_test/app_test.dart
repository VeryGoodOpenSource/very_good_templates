import 'dart:io';

import 'package:patrol/patrol.dart';
import 'package:{{project_name.snakeCase()}}_example/main.dart';

void main() {
  patrolTest('getPlatformName', ($) async {
    await $.pumpWidgetAndSettle(const MyApp());
    await $('Get Platform Name').tap();
    await $('Platform Name: ${expectedPlatformName()}').waitUntilVisible();
  });
}

String expectedPlatformName() {
{{#web}}  if (isWeb) return 'Web';
{{/web}}{{#android}}  if (Platform.isAndroid) return 'Android';
{{/android}}{{#supports_ios}}  if (Platform.isIOS) return 'iOS';
{{/supports_ios}}{{#linux}}  if (Platform.isLinux) return 'Linux';
{{/linux}}{{#supports_macos}}  if (Platform.isMacOS) return 'macOS';
{{/supports_macos}}{{#windows}}  if (Platform.isWindows) return 'Windows';
{{/windows}}  throw UnsupportedError('Unsupported platform ${Platform.operatingSystem}');
}
{{#web}}
bool get isWeb => identical(0, 0.0);
{{/web}}
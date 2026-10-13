import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:fluttium/fluttium.dart';

/// {@template check_platform_name}
/// An action that checks the expected platform name.
///
/// Usage:
///
/// ```yaml
/// - checkPlatformName:
/// ```
/// {@endtemplate}
class const CheckPlatformName({
  @visibleForTesting final bool Function() _isAndroid = _platformIsAndroid,
  @visibleForTesting final bool Function() _isIOS = _platformIsIOS,
  @visibleForTesting final bool Function() _isLinux = _platformIsLinux,
  @visibleForTesting final bool Function() _isMacOS = _platformIsMacOS,
  @visibleForTesting final bool Function() _isWindows = _platformIsWindows,
  @visibleForTesting final bool _isWeb = kIsWeb,
}) extends Action {
  /// {@macro check_platform_name}
  this;

  String get _expectedPlatformName {
    if (_isWeb) return 'Web';
    if (_isAndroid()) return 'Android';
    if (_isIOS()) return 'iOS';
    if (_isLinux()) return 'Linux';
    if (_isMacOS()) return 'macOS';
    if (_isWindows()) return 'Windows';
    throw UnsupportedError('Unsupported platform ${Platform.operatingSystem}');
  }

  @override
  Future<bool> execute(Tester tester) async {
    return await ExpectVisible(text: 'Platform Name: $_expectedPlatformName')
        .execute(tester);
  }

  @override
  String description() => 'Check platform name: "$_expectedPlatformName"';
}

// coverage:ignore-start these are just wrappers for overloading
bool _platformIsAndroid() => Platform.isAndroid;
bool _platformIsIOS() => Platform.isIOS;
bool _platformIsLinux() => Platform.isLinux;
bool _platformIsMacOS() => Platform.isMacOS;
bool _platformIsWindows() => Platform.isWindows;
// coverage:ignore-end

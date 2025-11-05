import 'package:flutter/foundation.dart';
import 'package:{{project_name.snakeCase()}}_ios/src/messages.g.dart';
import 'package:{{project_name.snakeCase()}}_platform_interface/{{project_name.snakeCase()}}_platform_interface.dart';

/// {@template {{project_name.snakeCase()}}_ios}
/// The iOS implementation of [{{project_name.pascalCase()}}Platform].
/// {@endtemplate}
class {{project_name.pascalCase()}}IOS extends {{project_name.pascalCase()}}Platform {
  /// {@macro {{project_name.snakeCase()}}_android}
  {{project_name.pascalCase()}}IOS({
    @visibleForTesting {{project_name.pascalCase()}}Api? api,
  }) : api = api ?? {{project_name.pascalCase()}}Api();

  /// The API used to interact with the native platform.
  final {{project_name.pascalCase()}}Api api;

  /// Registers this class as the default instance of [{{project_name.pascalCase()}}Platform]
  static void registerWith() {
    {{project_name.pascalCase()}}Platform.instance = {{project_name.pascalCase()}}IOS();
  }

  @override
  Future<String?> getPlatformName() {
    return api.getPlatformName();
  }
}

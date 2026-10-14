import 'package:flutter/foundation.dart';
import 'package:{{project_name.snakeCase()}}_linux/src/messages.g.dart';
import 'package:{{project_name.snakeCase()}}_platform_interface/{{project_name.snakeCase()}}_platform_interface.dart';

/// {@template {{project_name.snakeCase()}}_linux}
/// The Linux implementation of [{{project_name.pascalCase()}}Platform].
/// {@endtemplate}
class {{project_name.pascalCase()}}Linux({
  @visibleForTesting {{project_name.pascalCase()}}Api? api,
}) extends {{project_name.pascalCase()}}Platform {
  /// {@macro {{project_name.snakeCase()}}_linux}
  this;

  /// The API used to interact with the native platform.
  final {{project_name.pascalCase()}}Api api = api ?? {{project_name.pascalCase()}}Api();

  /// Registers this class as the default instance of
  /// [{{project_name.pascalCase()}}Platform].
  static void registerWith() {
    {{project_name.pascalCase()}}Platform.instance =
        {{project_name.pascalCase()}}Linux();
  }

  @override
  Future<String?> getPlatformName() {
    return api.getPlatformName();
  }
}

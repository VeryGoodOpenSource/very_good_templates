import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:{{project_name.snakeCase()}}_platform_interface/{{project_name.snakeCase()}}_platform_interface.dart';{{#use_build_hooks}}
import 'package:{{project_name.snakeCase()}}_linux/src/native_bindings.dart'
    as native_bindings;{{/use_build_hooks}}

/// The Linux implementation of [{{project_name.pascalCase()}}Platform].
class {{project_name.pascalCase()}}Linux extends {{project_name.pascalCase()}}Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('{{project_name.snakeCase()}}_linux');

  /// Registers this class as the default instance of [{{project_name.pascalCase()}}Platform]
  static void registerWith() {
    {{project_name.pascalCase()}}Platform.instance = {{project_name.pascalCase()}}Linux();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
{{#use_build_hooks}}

  @override
  int add(int a, int b) => native_bindings.add(a, b);
{{/use_build_hooks}}
}

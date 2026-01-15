import 'package:{{project_name.snakeCase()}}_platform_interface/{{project_name.snakeCase()}}_platform_interface.dart';

/// The Web implementation of [{{project_name.pascalCase()}}Platform].
class {{project_name.pascalCase()}}Web extends {{project_name.pascalCase()}}Platform {
  /// Registers this class as the default instance of [{{project_name.pascalCase()}}Platform]
  static void registerWith([Object? registrar]) {
    {{project_name.pascalCase()}}Platform.instance = {{project_name.pascalCase()}}Web();
  }

  @override
  Future<String?> getPlatformName() async => 'Web';
{{#use_build_hooks}}

  @override
  int add(int a, int b) {
    throw UnsupportedError(
      'Native code is not supported on web.',
    );
  }
{{/use_build_hooks}}
}

import 'package:{{project_name.snakeCase()}}_platform_interface/{{project_name.snakeCase()}}_platform_interface.dart';

{{project_name.pascalCase()}}Platform get _platform => {{project_name.pascalCase()}}Platform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}
{{#use_build_hooks}}

/// Adds two integers using native code.
///
/// This function delegates to the platform-specific implementation,
/// which uses FFI to call native C code compiled by the build hook.
///
/// Throws [UnsupportedError] on platforms that don't support native code (web).
///
/// Example:
/// ```dart
/// final result = add(24, 18);
/// print('24 + 18 = $result'); // Prints: 24 + 18 = 42
/// ```
int add(int a, int b) => _platform.add(a, b);
{{/use_build_hooks}}

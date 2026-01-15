{{#use_build_hooks}}import 'native_bindings.dart';

{{/use_build_hooks}}/// {@template {{project_name.snakeCase()}}}
/// {{{description}}}
/// {@endtemplate}
class {{project_name.pascalCase()}} {
  /// {@macro {{project_name.snakeCase()}}}
  const {{project_name.pascalCase()}}();
{{#use_build_hooks}}

  /// Example method demonstrating usage of native FFI functions.
  ///
  /// This method calls the native [add] function which is implemented
  /// in C and compiled by the build hook.
  ///
  /// Returns the sum of [a] and [b] calculated using native code.
  int calculateSum(int a, int b) {
    return add(a, b);
  }
{{/use_build_hooks}}}

import 'package:{{project_name.snakeCase()}}_platform_interface/src/method_channel_{{project_name.snakeCase()}}.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// {@template {{project_name.snakeCase()}}_platform}
/// The interface that implementations of {{project_name.snakeCase()}} must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `{{project_name.pascalCase()}}`.
///
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
/// this interface will be broken by newly added [{{project_name.pascalCase()}}Platform] methods.
/// {@endtemplate}
abstract class {{project_name.pascalCase()}}Platform extends PlatformInterface {
  /// {@macro {{project_name.snakeCase()}}_platform}
  {{project_name.pascalCase()}}Platform() : super(token: _token);

  static final Object _token = Object();

  static {{project_name.pascalCase()}}Platform _instance = MethodChannel{{project_name.pascalCase()}}();

  /// The default instance of [{{project_name.pascalCase()}}Platform] to use.
  ///
  /// Defaults to [MethodChannel{{project_name.pascalCase()}}].
  static {{project_name.pascalCase()}}Platform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [{{project_name.pascalCase()}}Platform] when they register themselves.
  static set instance({{project_name.pascalCase()}}Platform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the current platform name.
  Future<String?> getPlatformName();
}

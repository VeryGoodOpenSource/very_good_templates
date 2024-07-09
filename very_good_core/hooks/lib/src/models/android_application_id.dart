import 'package:mason/mason.dart';

/// {@template android_application_id}
/// Every Android app has a unique application ID that looks like a Java or
/// Kotlin package name, such as `com.example.app`.
///
/// This ID uniquely identifies your app on the device and in the Google Play
/// Store.
///
/// See also:
///
/// * [Set the application ID Android documentation](https://developer.android.com/build/configure-app-module#set-application-id)
/// {@endtemplate}
class AndroidApplicationId {
  /// {@macro android_application_id}
  AndroidApplicationId(this.value);

  /// Creates a new [AndroidApplicationId] from the provided [organizationName]
  /// and [projectName].
  ///
  /// This is the default fallback value for the application ID.
  factory AndroidApplicationId.fallback({
    required String organizationName,
    required String projectName,
  }) {
    return AndroidApplicationId(
      '${organizationName.snakeCase}.${projectName.snakeCase}',
    );
  }

  /// Checks if the provided [applicationId] is valid, returning `true` if it is
  /// and `false` otherwise.
  ///
  /// Although the application ID looks like a traditional Kotlin or Java
  /// package name, the naming rules for the application ID are a bit more
  /// restrictive:
  ///
  /// * It must have at least two segments (one or more dots).
  /// * Each segment must start with a letter.
  /// * All characters must be alphanumeric or an underscore [a-zA-Z0-9_].
  ///
  /// See also:
  ///
  /// * [Set the application ID Android documentation](https://developer.android.com/build/configure-app-module#set-application-id)
  static bool isValid(AndroidApplicationId applicationId) {
    final segments = applicationId.value.split('.');
    if (segments.length < 2) {
      // It must have at least two segments (one or more dots).
      return false;
    }

    final isLetter = RegExp('^[a-zA-Z]');
    final isAlphanumeric = RegExp(r'^[a-zA-Z0-9_]+$');

    for (final segment in segments) {
      if (segment.isEmpty || !isLetter.hasMatch(segment[0])) {
        // Each segment must start with a letter.
        return false;
      }

      if (!isAlphanumeric.hasMatch(segment)) {
        // All characters must be alphanumeric or an underscore [a-zA-Z0-9_].
        return false;
      }
    }

    return true;
  }

  /// The default application ID value.
  final String value;
}

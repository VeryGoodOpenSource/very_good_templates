import 'package:very_good_core_hooks/very_good_core_hooks.dart';

/// {@template very_good_core_exception}
/// An exception thrown by the `very_good_core` hooks.
/// {@endtemplate}
abstract class VeryGoodCoreHooksException implements Exception {
  /// {@macro very_good_core_exception}
  VeryGoodCoreHooksException({required this.description, required this.help});

  /// A message describing the exception.
  final String description;

  /// A message describing how to resolve the exception, or signposting to
  /// additional resources.
  final String help;

  @override
  String toString() =>
      '''
[$VeryGoodCoreHooksException] $description.

$help
''';
}

/// {@template InvalidAndroidApplicationIdFormat}
/// An exception thrown when an invalid Android application ID format is
/// given.
/// {@endtemplate}
class InvalidAndroidApplicationIdFormat extends VeryGoodCoreHooksException {
  /// {@macro InvalidAndroidApplicationIdFormat}
  InvalidAndroidApplicationIdFormat(AndroidApplicationId applicationId)
    : super(
        description:
            '''An invalid Android application ID (${applicationId.value}) format was provided.''',
        help:
            '''
Try adjusting your Android application ID (${applicationId.value}) to match the following format:

* It must have at least two segments (one or more dots).
* Each segment must start with a letter.
* All characters must be alphanumeric or an underscore [a-zA-Z0-9_].

Although the application ID looks like a traditional Kotlin or Java
package name, the naming rules for the application ID are a bit more
restrictive.

For more information, see the "Set the application ID" Android documentation:
* https://developer.android.com/build/configure-app-module#set-application-id.
''',
      );
}

import 'package:mason/mason.dart';

/// {@template linux_application_id}
/// Identifies the Linux application.
///
/// Gets used as the GTK application id (`APPLICATION_ID`) within the Linux
/// runner's `CMakeLists.txt`. See:
/// https://docs.gtk.org/gio/type_func.Application.id_is_valid.html
/// {@endtemplate}
extension type LinuxApplicationId(String value) {
  /// Creates a new [LinuxApplicationId] from the provided [organizationName]
  /// and [projectName].
  ///
  /// This is the default fallback value for the application id and mirrors the
  /// output of `flutter create`, which keeps each segment in snake case (using
  /// underscores rather than hyphens, as preferred by GTK/D-Bus).
  factory fallback({
    required String organizationName,
    required String projectName,
  }) {
    final parts = <String>[];
    for (final part in organizationName.split('.')) {
      if (part.isEmpty) continue;
      parts.add(part.snakeCase);
    }
    parts.add(projectName.snakeCase);

    return LinuxApplicationId(parts.join('.'));
  }

  /// Checks if the [LinuxApplicationId] is valid, returning `true` if it is
  /// and `false` otherwise.
  ///
  /// * It must have at least two segments (one or more dots).
  /// * Each segment must start with a letter.
  /// * All characters must be alphanumeric or an underscore [a-zA-Z0-9_].
  ///
  /// See also:
  ///
  /// * [GTK Application ID documentation](https://docs.gtk.org/gio/type_func.Application.id_is_valid.html)
  bool get isValid {
    final segments = value.split('.');
    if (segments.length < 2) return false;

    final isLetter = RegExp('^[a-zA-Z]');
    final isAlphanumeric = RegExp(r'^[a-zA-Z0-9_]+$');

    for (final segment in segments) {
      if (segment.isEmpty || !isLetter.hasMatch(segment[0])) return false;
      if (!isAlphanumeric.hasMatch(segment)) return false;
    }

    return true;
  }
}

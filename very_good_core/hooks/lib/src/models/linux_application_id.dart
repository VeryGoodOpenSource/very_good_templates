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
}

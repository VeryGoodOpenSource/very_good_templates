import 'package:mason/mason.dart';

/// {@template linux_application_id}
/// An App ID identifies your Linux app in a provisioning profile.
///
/// An App ID is a two-part string used to identify one or more apps from a
/// single development team. A period (.) separates its parts.
///
/// See also:
///
/// * [Linux Documentation Tutorial](https://developer.gnome.org/documentation/tutorials/application-id.html)
/// {@endtemplate}
extension type LinuxApplicationId(String value) {
  /// Creates a new [LinuxApplicationId] from the provided [organizationName]
  /// and [projectName].
  ///
  /// This is the default fallback value for the application ID.
  factory LinuxApplicationId.fallback({
    required String organizationName,
    required String projectName,
  }) {
    final parts = <String>[];
    for (final part in organizationName.split('.')) {
      if (part.isEmpty) continue;
      parts.add(part.paramCase);
    }
    parts.add(projectName.paramCase);

    return LinuxApplicationId(parts.join('.'));
  }
}

import 'package:mason/mason.dart';

/// {@template ios_application_id}
/// An App ID identifies your iOS app in a provisioning profile.
///
/// An App ID is a two-part string used to identify one or more apps from a
/// single development team. A period (.) separates its parts.
///
/// See also:
///
/// * [Register an App ID](https://developer.apple.com/help/account/manage-identifiers/register-an-app-id/)
/// * [Apple Documentation Archive](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/AppID.html)
/// {@endtemplate}
extension type IosApplicationId(String value) {
  /// Creates a new [IosApplicationId] from the provided [organizationName]
  /// and [projectName].
  ///
  /// This is the default fallback value for the application ID.
  factory IosApplicationId.fallback({
    required String organizationName,
    required String projectName,
  }) {
    final parts = <String>[];
    for (final part in organizationName.split('.')) {
      if (part.isEmpty) continue;
      parts.add(part.paramCase);
    }
    parts.add(projectName.paramCase);

    return IosApplicationId(parts.join('.'));
  }
}

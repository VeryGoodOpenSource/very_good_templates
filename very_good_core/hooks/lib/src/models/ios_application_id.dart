import 'package:mason/mason.dart';

// TODO(alestiago): Add documentation
/// {@template ios_application_id}
///
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
    return IosApplicationId(
      '${organizationName.paramCase}.${projectName.paramCase}',
    );
  }
}

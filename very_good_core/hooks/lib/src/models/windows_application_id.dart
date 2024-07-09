import 'package:mason/mason.dart';

/// {@template windows_application_id}
///
/// {@endtemplate}
extension type WindowsApplicationId(String value) {
  /// Creates a new [WindowsApplicationId] from the provided [organizationName]
  /// and [projectName].
  ///
  /// This is the default fallback value for the application ID.
  factory WindowsApplicationId.fallback({
    required String organizationName,
    required String projectName,
  }) {
    return WindowsApplicationId(
      '${organizationName.paramCase}.${projectName.paramCase}',
    );
  }
}

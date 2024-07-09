import 'package:mason/mason.dart';

/// {@template windows_application_id}
/// Identifies the Windows application.
///
/// Gets used as part of the Runner.rc company name and its copyright notice.
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

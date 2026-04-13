import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

/// {@template app_colors}
/// Custom color tokens beyond Material's [ColorScheme].
///
/// Provides semantic colors for success, warning, and info states
/// along with their on-color variants.
/// {@endtemplate}
class AppColors extends ThemeExtension<AppColors> {
  /// {@macro app_colors}
  const AppColors({
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
  });

  /// The color used for success states.
  final Color success;

  /// The color used for content on top of [success].
  final Color onSuccess;

  /// The color used for warning states.
  final Color warning;

  /// The color used for content on top of [warning].
  final Color onWarning;

  /// The color used for informational states.
  final Color info;

  /// The color used for content on top of [info].
  final Color onInfo;

  @override
  AppColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? info,
    Color? onInfo,
  }) {
    return AppColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
    );
  }
}

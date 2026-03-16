import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

/// {@template app_theme}
/// Composes [ThemeData] with [ColorScheme.fromSeed] and custom
/// [ThemeExtension]s for light and dark variants.
/// {@endtemplate}
class AppTheme {
  /// The light [ThemeData].
  static ThemeData get light {
    const appColors = AppColors(
      success: Color(0xFF16A34A),
      onSuccess: Color(0xFFFFFFFF),
      warning: Color(0xFFCA8A04),
      onWarning: Color(0xFFFFFFFF),
      info: Color(0xFF2563EB),
      onInfo: Color(0xFFFFFFFF),
    );

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
      extensions: const [appColors, AppSpacing()],
    );
  }

  /// The dark [ThemeData].
  static ThemeData get dark {
    const appColors = AppColors(
      success: Color(0xFF4ADE80),
      onSuccess: Color(0xFF1C1B1F),
      warning: Color(0xFFFACC15),
      onWarning: Color(0xFF1C1B1F),
      info: Color(0xFF60A5FA),
      onInfo: Color(0xFF1C1B1F),
    );

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4F46E5),
        brightness: Brightness.dark,
      ),
      extensions: const [appColors, AppSpacing()],
    );
  }
}

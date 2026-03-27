import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

/// Extension on [BuildContext] for easy access to custom theme tokens.
extension AppThemeBuildContext on BuildContext {
  /// Returns the [AppColors] from the current theme.
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  /// Returns the [AppSpacing] from the current theme.
  AppSpacing get appSpacing => Theme.of(this).extension<AppSpacing>()!;
}

import 'dart:ui';

import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

/// {@template app_spacing}
/// Spacing scale tokens for consistent layout throughout the app.
/// {@endtemplate}
class const AppSpacing({
  /// Extra extra small spacing: 4px.
  final double xxs = 4,

  /// Extra small spacing: 8px.
  final double xs = 8,

  /// Small spacing: 12px.
  final double sm = 12,

  /// Medium spacing: 16px.
  final double md = 16,

  /// Large spacing: 24px.
  final double lg = 24,

  /// Extra large spacing: 32px.
  final double xlg = 32,

  /// Extra extra large spacing: 48px.
  final double xxlg = 48,
}) extends ThemeExtension<AppSpacing> {
  /// {@macro app_spacing}
  this;

  @override
  AppSpacing copyWith({
    double? xxs,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xlg,
    double? xxlg,
  }) {
    return AppSpacing(
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xlg: xlg ?? this.xlg,
      xxlg: xxlg ?? this.xxlg,
    );
  }

  @override
  AppSpacing lerp(AppSpacing? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing(
      xxs: lerpDouble(xxs, other.xxs, t)!,
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xlg: lerpDouble(xlg, other.xlg, t)!,
      xxlg: lerpDouble(xxlg, other.xxlg, t)!,
    );
  }
}

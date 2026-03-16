import 'dart:ui';

import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

/// {@template app_spacing}
/// Spacing scale tokens for consistent layout throughout the app.
/// {@endtemplate}
class AppSpacing extends ThemeExtension<AppSpacing> {
  /// {@macro app_spacing}
  const AppSpacing({
    this.xxs = 4,
    this.xs = 8,
    this.sm = 12,
    this.md = 16,
    this.lg = 24,
    this.xlg = 32,
    this.xxlg = 48,
  });

  /// Extra extra small spacing: 4px.
  final double xxs;

  /// Extra small spacing: 8px.
  final double xs;

  /// Small spacing: 12px.
  final double sm;

  /// Medium spacing: 16px.
  final double md;

  /// Large spacing: 24px.
  final double lg;

  /// Extra large spacing: 32px.
  final double xlg;

  /// Extra extra large spacing: 48px.
  final double xxlg;

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

import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

void main() {
  group('AppSpacing', () {
    const spacing = AppSpacing();

    test('has correct default values', () {
      expect(spacing.xxs, 4);
      expect(spacing.xs, 8);
      expect(spacing.sm, 12);
      expect(spacing.md, 16);
      expect(spacing.lg, 24);
      expect(spacing.xlg, 32);
      expect(spacing.xxlg, 48);
    });

    test('copyWith returns a new instance with updated values', () {
      final updated = spacing.copyWith(xxs: 2, md: 20);
      expect(updated.xxs, 2);
      expect(updated.xs, spacing.xs);
      expect(updated.sm, spacing.sm);
      expect(updated.md, 20);
      expect(updated.lg, spacing.lg);
      expect(updated.xlg, spacing.xlg);
      expect(updated.xxlg, spacing.xxlg);
    });

    test('copyWith returns identical instance when no values are provided', () {
      final copy = spacing.copyWith();
      expect(copy.xxs, spacing.xxs);
      expect(copy.xs, spacing.xs);
      expect(copy.sm, spacing.sm);
      expect(copy.md, spacing.md);
      expect(copy.lg, spacing.lg);
      expect(copy.xlg, spacing.xlg);
      expect(copy.xxlg, spacing.xxlg);
    });

    test('lerp returns this when other is not AppSpacing', () {
      final result = spacing.lerp(null, 0.5);
      expect(result, spacing);
    });

    test('lerp interpolates between two AppSpacing instances', () {
      const other = AppSpacing(
        xxs: 8,
        xs: 16,
        sm: 24,
        md: 32,
        lg: 48,
        xlg: 64,
        xxlg: 96,
      );

      final result = spacing.lerp(other, 0.5);
      expect(result.xxs, 6);
      expect(result.xs, 12);
      expect(result.sm, 18);
      expect(result.md, 24);
      expect(result.lg, 36);
      expect(result.xlg, 48);
      expect(result.xxlg, 72);
    });
  });
}

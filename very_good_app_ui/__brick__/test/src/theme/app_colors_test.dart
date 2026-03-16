import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

void main() {
  group('AppColors', () {
    const colors = AppColors(
      success: Color(0xFF16A34A),
      onSuccess: Color(0xFFFFFFFF),
      warning: Color(0xFFCA8A04),
      onWarning: Color(0xFFFFFFFF),
      info: Color(0xFF2563EB),
      onInfo: Color(0xFFFFFFFF),
    );

    test('copyWith returns a new instance with updated values', () {
      final updated = colors.copyWith(success: const Color(0xFF000000));
      expect(updated.success, const Color(0xFF000000));
      expect(updated.onSuccess, colors.onSuccess);
      expect(updated.warning, colors.warning);
      expect(updated.onWarning, colors.onWarning);
      expect(updated.info, colors.info);
      expect(updated.onInfo, colors.onInfo);
    });

    test('copyWith returns identical instance when no values are provided', () {
      final copy = colors.copyWith();
      expect(copy.success, colors.success);
      expect(copy.onSuccess, colors.onSuccess);
      expect(copy.warning, colors.warning);
      expect(copy.onWarning, colors.onWarning);
      expect(copy.info, colors.info);
      expect(copy.onInfo, colors.onInfo);
    });

    test('lerp returns this when other is not AppColors', () {
      final result = colors.lerp(null, 0.5);
      expect(result, colors);
    });

    test('lerp interpolates between two AppColors', () {
      const other = AppColors(
        success: Color(0xFF000000),
        onSuccess: Color(0xFF000000),
        warning: Color(0xFF000000),
        onWarning: Color(0xFF000000),
        info: Color(0xFF000000),
        onInfo: Color(0xFF000000),
      );

      final result = colors.lerp(other, 0.5);
      expect(result.success, isNotNull);
      expect(result.onSuccess, isNotNull);
      expect(result.warning, isNotNull);
      expect(result.onWarning, isNotNull);
      expect(result.info, isNotNull);
      expect(result.onInfo, isNotNull);
    });
  });
}

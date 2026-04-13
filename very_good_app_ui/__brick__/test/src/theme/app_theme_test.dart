import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

void main() {
  group('AppTheme', () {
    group('light', () {
      test('returns a ThemeData', () {
        expect(AppTheme.light, isA<ThemeData>());
      });

      test('has AppColors extension', () {
        expect(AppTheme.light.extension<AppColors>(), isNotNull);
      });

      test('has AppSpacing extension', () {
        expect(AppTheme.light.extension<AppSpacing>(), isNotNull);
      });

      test('has light brightness', () {
        expect(AppTheme.light.brightness, Brightness.light);
      });
    });

    group('dark', () {
      test('returns a ThemeData', () {
        expect(AppTheme.dark, isA<ThemeData>());
      });

      test('has AppColors extension', () {
        expect(AppTheme.dark.extension<AppColors>(), isNotNull);
      });

      test('has AppSpacing extension', () {
        expect(AppTheme.dark.extension<AppSpacing>(), isNotNull);
      });

      test('has dark brightness', () {
        expect(AppTheme.dark.brightness, Brightness.dark);
      });
    });
  });
}

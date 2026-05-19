import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

void main() {
  group('AppTextStyles', () {
    group('desktop text styles', () {
      test('displayLargeDesktop has correct values', () {
        const style = AppTextStyles.displayLargeDesktop;
        expect(style.fontSize, equals(48));
        expect(style.fontWeight, equals(FontWeight.w700));
        expect(style.height, 1.17);
        expect(style.letterSpacing, -2);
      });

      test('displayMediumDesktop has correct values', () {
        const style = AppTextStyles.displayMediumDesktop;
        expect(style.fontSize, equals(40));
        expect(style.fontWeight, equals(FontWeight.w700));
        expect(style.height, 1.2);
        expect(style.letterSpacing, -1.5);
      });

      test('displaySmallDesktop has correct values', () {
        const style = AppTextStyles.displaySmallDesktop;
        expect(style.fontSize, equals(36));
        expect(style.fontWeight, equals(FontWeight.w700));
        expect(style.height, 1.22);
        expect(style.letterSpacing, -1.5);
      });

      test('headlineLargeDesktop has correct values', () {
        const style = AppTextStyles.headlineLargeDesktop;
        expect(style.fontSize, equals(32));
        expect(style.fontWeight, equals(FontWeight.w600));
        expect(style.height, 1.25);
        expect(style.letterSpacing, -1.5);
      });

      test('headlineMediumDesktop has correct values', () {
        const style = AppTextStyles.headlineMediumDesktop;
        expect(style.fontSize, equals(24));
        expect(style.fontWeight, equals(FontWeight.w600));
        expect(style.height, 1.33);
        expect(style.letterSpacing, -1);
      });

      test('headlineSmallDesktop has correct values', () {
        const style = AppTextStyles.headlineSmallDesktop;
        expect(style.fontSize, equals(20));
        expect(style.fontWeight, equals(FontWeight.w600));
        expect(style.height, 1.4);
        expect(style.letterSpacing, -0.75);
      });

      test('titleLargeDesktop has correct values', () {
        const style = AppTextStyles.titleLargeDesktop;
        expect(style.fontSize, equals(24));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.33);
        expect(style.letterSpacing, -0.5);
      });

      test('titleMediumDesktop has correct values', () {
        const style = AppTextStyles.titleMediumDesktop;
        expect(style.fontSize, equals(20));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.4);
        expect(style.letterSpacing, -0.5);
      });

      test('titleSmallDesktop has correct values', () {
        const style = AppTextStyles.titleSmallDesktop;
        expect(style.fontSize, equals(16));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.5);
        expect(style.letterSpacing, -0.25);
      });

      test('labelLargeDesktop has correct values', () {
        const style = AppTextStyles.labelLargeDesktop;
        expect(style.fontSize, equals(16));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.25);
        expect(style.letterSpacing, -0.15);
      });

      test('labelMediumDesktop has correct values', () {
        const style = AppTextStyles.labelMediumDesktop;
        expect(style.fontSize, equals(12));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.33);
        expect(style.letterSpacing, -0.15);
      });

      test('labelSmallDesktop has correct values', () {
        const style = AppTextStyles.labelSmallDesktop;
        expect(style.fontSize, equals(11));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.45);
        expect(style.letterSpacing, -0.15);
      });

      test('bodyLargeDesktop has correct values', () {
        const style = AppTextStyles.bodyLargeDesktop;
        expect(style.fontSize, equals(16));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.5);
        expect(style.letterSpacing, -0.15);
      });

      test('bodyMediumDesktop has correct values', () {
        const style = AppTextStyles.bodyMediumDesktop;
        expect(style.fontSize, equals(14));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.43);
        expect(style.letterSpacing, -0.15);
      });

      test('bodySmallDesktop has correct values', () {
        const style = AppTextStyles.bodySmallDesktop;
        expect(style.fontSize, equals(12));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.33);
        expect(style.letterSpacing, -0.15);
      });
    });

    group('mobile text styles', () {
      test('displayLargeMobile has correct values', () {
        const style = AppTextStyles.displayLargeMobile;
        expect(style.fontSize, equals(36));
        expect(style.fontWeight, equals(FontWeight.w700));
        expect(style.height, 1.22);
        expect(style.letterSpacing, -1.5);
      });

      test('displayMediumMobile has correct values', () {
        const style = AppTextStyles.displayMediumMobile;
        expect(style.fontSize, equals(32));
        expect(style.fontWeight, equals(FontWeight.w700));
        expect(style.height, 1.25);
        expect(style.letterSpacing, -1);
      });

      test('displaySmallMobile has correct values', () {
        const style = AppTextStyles.displaySmallMobile;
        expect(style.fontSize, equals(28));
        expect(style.fontWeight, equals(FontWeight.w700));
        expect(style.height, 1.29);
        expect(style.letterSpacing, -1);
      });

      test('headlineLargeMobile has correct values', () {
        const style = AppTextStyles.headlineLargeMobile;
        expect(style.fontSize, equals(28));
        expect(style.fontWeight, equals(FontWeight.w600));
        expect(style.height, 1.29);
        expect(style.letterSpacing, -1);
      });

      test('headlineMediumMobile has correct values', () {
        const style = AppTextStyles.headlineMediumMobile;
        expect(style.fontSize, equals(22));
        expect(style.fontWeight, equals(FontWeight.w600));
        expect(style.height, 1.27);
        expect(style.letterSpacing, -0.75);
      });

      test('headlineSmallMobile has correct values', () {
        const style = AppTextStyles.headlineSmallMobile;
        expect(style.fontSize, equals(18));
        expect(style.fontWeight, equals(FontWeight.w600));
        expect(style.height, 1.33);
        expect(style.letterSpacing, -0.5);
      });

      test('titleLargeMobile has correct values', () {
        const style = AppTextStyles.titleLargeMobile;
        expect(style.fontSize, equals(20));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.4);
        expect(style.letterSpacing, -0.25);
      });

      test('titleMediumMobile has correct values', () {
        const style = AppTextStyles.titleMediumMobile;
        expect(style.fontSize, equals(18));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.33);
        expect(style.letterSpacing, -0.25);
      });

      test('titleSmallMobile has correct values', () {
        const style = AppTextStyles.titleSmallMobile;
        expect(style.fontSize, equals(14));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.43);
        expect(style.letterSpacing, -0.15);
      });

      test('labelLargeMobile has correct values', () {
        const style = AppTextStyles.labelLargeMobile;
        expect(style.fontSize, equals(16));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.25);
        expect(style.letterSpacing, -0.15);
      });

      test('labelMediumMobile has correct values', () {
        const style = AppTextStyles.labelMediumMobile;
        expect(style.fontSize, equals(12));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.33);
        expect(style.letterSpacing, -0.15);
      });

      test('labelSmallMobile has correct values', () {
        const style = AppTextStyles.labelSmallMobile;
        expect(style.fontSize, equals(11));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.45);
        expect(style.letterSpacing, -0.15);
      });

      test('bodyLargeMobile has correct values', () {
        const style = AppTextStyles.bodyLargeMobile;
        expect(style.fontSize, equals(16));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.25);
        expect(style.letterSpacing, -0.15);
      });

      test('bodyMediumMobile has correct values', () {
        const style = AppTextStyles.bodyMediumMobile;
        expect(style.fontSize, equals(14));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.43);
        expect(style.letterSpacing, -0.15);
      });

      test('bodySmallMobile has correct values', () {
        const style = AppTextStyles.bodySmallMobile;
        expect(style.fontSize, equals(12));
        expect(style.fontWeight, equals(FontWeight.w500));
        expect(style.height, 1.33);
        expect(style.letterSpacing, -0.15);
      });
    });

    group('desktopTextTheme', () {
      test('maps each slot to the correct desktop style', () {
        final textTheme = AppTextStyles.desktopTextTheme;
        expect(textTheme.displayLarge, AppTextStyles.displayLargeDesktop);
        expect(textTheme.displayMedium, AppTextStyles.displayMediumDesktop);
        expect(textTheme.displaySmall, AppTextStyles.displaySmallDesktop);
        expect(textTheme.headlineLarge, AppTextStyles.headlineLargeDesktop);
        expect(textTheme.headlineMedium, AppTextStyles.headlineMediumDesktop);
        expect(textTheme.headlineSmall, AppTextStyles.headlineSmallDesktop);
        expect(textTheme.titleLarge, AppTextStyles.titleLargeDesktop);
        expect(textTheme.titleMedium, AppTextStyles.titleMediumDesktop);
        expect(textTheme.titleSmall, AppTextStyles.titleSmallDesktop);
        expect(textTheme.labelLarge, AppTextStyles.labelLargeDesktop);
        expect(textTheme.labelMedium, AppTextStyles.labelMediumDesktop);
        expect(textTheme.labelSmall, AppTextStyles.labelSmallDesktop);
        expect(textTheme.bodyLarge, AppTextStyles.bodyLargeDesktop);
        expect(textTheme.bodyMedium, AppTextStyles.bodyMediumDesktop);
        expect(textTheme.bodySmall, AppTextStyles.bodySmallDesktop);
      });
    });

    group('mobileTextTheme', () {
      test('maps each slot to the correct mobile style', () {
        final textTheme = AppTextStyles.mobileTextTheme;
        expect(textTheme.displayLarge, AppTextStyles.displayLargeMobile);
        expect(textTheme.displayMedium, AppTextStyles.displayMediumMobile);
        expect(textTheme.displaySmall, AppTextStyles.displaySmallMobile);
        expect(textTheme.headlineLarge, AppTextStyles.headlineLargeMobile);
        expect(textTheme.headlineMedium, AppTextStyles.headlineMediumMobile);
        expect(textTheme.headlineSmall, AppTextStyles.headlineSmallMobile);
        expect(textTheme.titleLarge, AppTextStyles.titleLargeMobile);
        expect(textTheme.titleMedium, AppTextStyles.titleMediumMobile);
        expect(textTheme.titleSmall, AppTextStyles.titleSmallMobile);
        expect(textTheme.labelLarge, AppTextStyles.labelLargeMobile);
        expect(textTheme.labelMedium, AppTextStyles.labelMediumMobile);
        expect(textTheme.labelSmall, AppTextStyles.labelSmallMobile);
        expect(textTheme.bodyLarge, AppTextStyles.bodyLargeMobile);
        expect(textTheme.bodyMedium, AppTextStyles.bodyMediumMobile);
        expect(textTheme.bodySmall, AppTextStyles.bodySmallMobile);
      });
    });

    group('getResponsiveTextTheme', () {
      test('returns mobileTextTheme when width is below 600', () {
        expect(
          AppTextStyles.getResponsiveTextTheme(599),
          AppTextStyles.mobileTextTheme,
        );
      });

      test('returns desktopTextTheme when width is exactly 600', () {
        expect(
          AppTextStyles.getResponsiveTextTheme(600),
          AppTextStyles.desktopTextTheme,
        );
      });

      test('returns desktopTextTheme when width is above 600', () {
        expect(
          AppTextStyles.getResponsiveTextTheme(1024),
          AppTextStyles.desktopTextTheme,
        );
      });
    });
  });
}

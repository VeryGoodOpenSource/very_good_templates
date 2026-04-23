import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AppThemeBuildContext', () {
    testWidgets('appColors returns AppColors from theme', (tester) async {
      late AppColors colors;
      await tester.pumpApp(
        Builder(
          builder: (context) {
            colors = context.appColors;
            return const SizedBox();
          },
        ),
      );

      expect(colors, isA<AppColors>());
    });

    testWidgets('appSpacing returns AppSpacing from theme', (tester) async {
      late AppSpacing spacing;
      await tester.pumpApp(
        Builder(
          builder: (context) {
            spacing = context.appSpacing;
            return const SizedBox();
          },
        ),
      );

      expect(spacing, isA<AppSpacing>());
    });

    testWidgets('appTextStyles returns AppTextStyles from theme', (
      tester,
    ) async {
      late AppTextStyles textStyles;
      await tester.pumpApp(
        Builder(
          builder: (context) {
            textStyles = context.appTextStyles;
            return const SizedBox();
          },
        ),
      );

      expect(textStyles, isA<AppTextStyles>());
    });
  });
}

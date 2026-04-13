// Not required for test files.
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AppButton', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpApp(AppButton(onPressed: () {}, child: Text('Tap me')));

      expect(find.text('Tap me'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpApp(
        AppButton(onPressed: () => tapped = true, child: Text('Tap me')),
      );

      await tester.tap(find.byType(AppButton));
      expect(tapped, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      await tester.pumpApp(AppButton(onPressed: null, child: Text('Disabled')));

      await tester.tap(find.byType(AppButton));
    });

    testWidgets('renders FilledButton for primary variant', (tester) async {
      await tester.pumpApp(AppButton(onPressed: () {}, child: Text('Primary')));

      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('renders FilledButton.tonal for secondary variant', (
      tester,
    ) async {
      await tester.pumpApp(
        AppButton(
          onPressed: () {},
          variant: AppButtonVariant.secondary,
          child: Text('Secondary'),
        ),
      );

      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('renders OutlinedButton for outline variant', (tester) async {
      await tester.pumpApp(
        AppButton(
          onPressed: () {},
          variant: AppButtonVariant.outline,
          child: Text('Outline'),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('renders with small size', (tester) async {
      await tester.pumpApp(
        AppButton(
          onPressed: () {},
          size: AppButtonSize.small,
          child: Text('Small'),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
    });

    testWidgets('renders with large size', (tester) async {
      await tester.pumpApp(
        AppButton(
          onPressed: () {},
          size: AppButtonSize.large,
          child: Text('Large'),
        ),
      );

      expect(find.text('Large'), findsOneWidget);
    });
  });
}

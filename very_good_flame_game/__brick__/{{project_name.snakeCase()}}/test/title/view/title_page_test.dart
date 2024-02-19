import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import 'package:{{project_name.snakeCase()}}/title/title.dart';

import '../../helpers/helpers.dart';

void main() {
  group('TitlePage', () {
    testWidgets('renders TitleView', (tester) async {
      await tester.pumpApp(const TitlePage());
      expect(find.byType(TitleView), findsOneWidget);
    });
  });

  group('TitleView', () {
    testWidgets('renders start button', (tester) async {
      await tester.pumpApp(const TitleView());

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('starts the game when start button is tapped', (tester) async {
      final navigator = MockNavigator();
      when(navigator.canPop).thenReturn(true);
      when(
        () => navigator.pushReplacement<void, void>(any()),
      ).thenAnswer((_) async {});

      await tester.pumpApp(const TitleView(), navigator: navigator);

      await tester.tap(find.byType(ElevatedButton));

      verify(() => navigator.pushReplacement<void, void>(any())).called(1);
    });
  });
}

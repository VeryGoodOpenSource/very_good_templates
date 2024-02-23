// ignore_for_file: prefer_const_constructors

import 'package:check_platform_name/check_platform_name.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttium/fluttium.dart';
import 'package:mocktail/mocktail.dart';

class _MockTester extends Mock implements Tester {}

class _MockSemanticsNode extends Mock implements SemanticsNode {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

void main() {
  group('CheckPlatformName', () {
    late Tester tester;
    late SemanticsNode node;

    setUp(() {
      tester = _MockTester();
      node = _MockSemanticsNode();

      when(() => tester.find(any())).thenAnswer((_) async => node);
    });

    test('executes returns true if node was found', () async {
      final action = CheckPlatformName();

      expect(await action.execute(tester), isTrue);
    });

    test('executes returns false if node was not found', () async {
      when(() => tester.find(any())).thenAnswer((_) async => null);

      final action = CheckPlatformName();

      expect(await action.execute(tester), isFalse);
    });

    test('show correct description', () {
      final action = CheckPlatformName(
        isAndroid: () => true,
        isIOS: () => false,
        isLinux: () => false,
        isMacOS: () => false,
        isWindows: () => false,
      );

      expect(
        action.description(),
        equals('Check platform name: "Android"'),
      );
    });
  });
}

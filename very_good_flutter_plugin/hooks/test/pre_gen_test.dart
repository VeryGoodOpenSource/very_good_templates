import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:very_good_flutter_plugin_hooks/version.dart';

import '../pre_gen.dart' as pre_gen;

class _MockHookContext extends Mock implements HookContext {}

void main() {
  group('pre_gen', () {
    late HookContext context;

    setUp(() {
      context = _MockHookContext();
    });

    test('sets flutterVersion', () {
      final vars = <String, dynamic>{};
      when(() => context.vars).thenReturn(vars);

      pre_gen.run(context);

      expect(vars['flutterVersion'], $flutterVersion);
    });

    test('sets dartSdkVersionBounds', () {
      final vars = <String, dynamic>{};
      when(() => context.vars).thenReturn(vars);

      pre_gen.run(context);

      expect(vars['dartSdkVersionBounds'], '^${$minDartVersion}');
    });

    group('android variable', () {
      const androidVariable = 'android';

      test('is set to true if it is in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': [androidVariable],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[androidVariable], isTrue);
      });

      test('is set to false if it is not in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': <String>[],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[androidVariable], isFalse);
      });
    });

    group('ios variable', () {
      const iosVariable = 'ios';

      test('is set to true if it is in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': [iosVariable],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[iosVariable], isTrue);
      });

      test('is set to false if it is not in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': <String>[],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[iosVariable], isFalse);
      });
    });

    group('macos variable', () {
      const macOsVariable = 'macos';

      test('is set to true if it is in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': [macOsVariable],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[macOsVariable], isTrue);
      });

      test('is set to false if it is not in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': <String>[],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[macOsVariable], isFalse);
      });
    });

    group('linux variable', () {
      const linuxVariable = 'linux';

      test('is set to true if it is in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': [linuxVariable],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[linuxVariable], isTrue);
      });

      test('is set to false if it is not in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': <String>[],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[linuxVariable], isFalse);
      });
    });

    group('web variable', () {
      const webVariable = 'web';

      test('is set to true if it is in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': [webVariable],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[webVariable], isTrue);
      });

      test('is set to false if it is not in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': <String>[],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[webVariable], isFalse);
      });
    });

    group('windows variable', () {
      const windowsVariable = 'windows';

      test('is set to true if it is in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': [windowsVariable],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[windowsVariable], isTrue);
      });

      test('is set to false if it is not in `platforms` variable', () {
        final vars = <String, dynamic>{
          'platforms': <String>[],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(vars[windowsVariable], isFalse);
      });
    });
  });
}

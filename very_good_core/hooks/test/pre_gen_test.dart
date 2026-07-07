import 'package:clock/clock.dart';
import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../pre_gen.dart' as pre_gen;

class _MockHookContext extends Mock implements HookContext {}

void main() {
  group('pre_gen', () {
    late HookContext context;

    setUp(() {
      context = _MockHookContext();
    });

    test('populates variables', () {
      withClock(Clock.fixed(DateTime(2020)), () {
        final vars = {
          'project_name': 'my_app',
          'org_name': 'com.example',
          'application_id': 'app.id',
          'description': 'A new Flutter project.',
          'platforms': ['android', 'ios', 'macos', 'web', 'windows'],
          'publishable': false,
          'workspace': false,
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        final newVars =
            verify(() => context.vars = captureAny()).captured.last
                as Map<String, dynamic>;

        expect(
          newVars,
          equals({
            'project_name': 'my_app',
            'org_name': 'com.example',
            'description': 'A new Flutter project.',
            'android_namespace': 'app.id',
            'android_application_id': 'app.id',
            'ios_application_id': 'app.id',
            'macos_application_id': 'app.id',
            'windows_application_id': 'app.id',
            'platforms': ['android', 'ios', 'macos', 'web', 'windows'],
            'publishable': false,
            'workspace': false,
            'current_year': '2020',
            'android': true,
            'ios': true,
            'macos': true,
            'web': true,
            'windows': true,
          }),
        );
      });
    });

    test('platform options', () {
      withClock(Clock.fixed(DateTime(2020)), () {
        final vars = {
          'project_name': 'my_app',
          'org_name': 'com.example',
          'application_id': 'app.id',
          'description': 'A new Flutter project.',
          'platforms': ['android', 'web'],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        final newVars =
            verify(() => context.vars = captureAny()).captured.last
                as Map<String, dynamic>;

        expect(newVars['android'], isTrue);
        expect(newVars['web'], isTrue);
        expect(newVars['ios'], isFalse);
        expect(newVars['macos'], isFalse);
        expect(newVars['windows'], isFalse);
      });
    });

    test('parses a comma separated platforms string', () {
      withClock(Clock.fixed(DateTime(2020)), () {
        final vars = {
          'project_name': 'my_app',
          'org_name': 'com.example',
          'application_id': 'app.id',
          'description': 'A new Flutter project.',
          'platforms': 'android, ios',
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        final newVars =
            verify(() => context.vars = captureAny()).captured.last
                as Map<String, dynamic>;

        expect(newVars['android'], isTrue);
        expect(newVars['ios'], isTrue);
        expect(newVars['macos'], isFalse);
        expect(newVars['web'], isFalse);
        expect(newVars['windows'], isFalse);
      });
    });

    test('throws $ArgumentError if platforms is not a list', () {
      withClock(Clock.fixed(DateTime(2020)), () {
        final vars = {
          'project_name': 'my_app',
          'org_name': 'com.example',
          'application_id': 'app.id',
          'description': 'A new Flutter project.',
          'platforms': 2345,
        };

        when(() => context.vars).thenReturn(vars);

        expect(() => pre_gen.run(context), throwsA(isA<ArgumentError>()));
      });
    });
  });
}

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
          'project_name': 'my_game',
          'org_name': 'com.example',
          'application_id': 'app.id',
          'description': 'A new Flame project.',
          'platforms': [
            'android',
            'ios',
            'macos',
            'windows',
            'web',
            'linux',
          ],
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        final newVars =
            verify(() => context.vars = captureAny()).captured.last
                as Map<String, dynamic>;

        expect(
          newVars,
          equals({
            'project_name': 'my_game',
            'org_name': 'com.example',
            'description': 'A new Flame project.',
            'android_namespace': 'app.id',
            'android_application_id': 'app.id',
            'ios_application_id': 'app.id',
            'macos_application_id': 'app.id',
            'windows_application_id': 'app.id',
            'current_year': '2020',
            'platforms': [
              'android',
              'ios',
              'macos',
              'windows',
              'web',
              'linux',
            ],
            'android': true,
            'ios': true,
            'macos': true,
            'web': true,
            'windows': true,
            'linux': true,
          }),
        );
      });
    });

    test('platform options', () {
      withClock(Clock.fixed(DateTime(2020)), () {
        final vars = {
          'project_name': 'my_game',
          'org_name': 'com.example',
          'application_id': 'app.id',
          'description': 'A new Flame project.',
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
        expect(newVars['linux'], isFalse);
      });
    });

    test('throws $ArgumentError if platforms is not a list', () {
      withClock(Clock.fixed(DateTime(2020)), () async {
        final vars = {
          'project_name': 'my_game',
          'org_name': 'com.example',
          'application_id': 'app.id',
          'description': 'A new Flame project.',
          'platforms': 2345,
        };
        when(() => context.vars).thenReturn(vars);

        await expectLater(
          () => pre_gen.run(context),
          throwsA(isA<ArgumentError>()),
        );
      });
    });
  });
}

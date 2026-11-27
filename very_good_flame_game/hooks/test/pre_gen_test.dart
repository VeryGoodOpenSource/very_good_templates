import 'package:clock/clock.dart';
import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../pre_gen.dart' as pre_gen;

class _MockHookContext extends Mock implements HookContext;

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
          'publishable': false,
          'workspace': false,
          'platforms': ['android', 'ios', 'macos', 'windows', 'web', 'linux'],
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
            'publishable': false,
            'workspace': false,
            'current_year': '2020',
            'pubspec_description': '"A new Flame project."',
            'platforms': ['android', 'ios', 'macos', 'windows', 'web', 'linux'],
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

    test('throws $ArgumentError if platforms is not a list', () async {
      await withClock(Clock.fixed(DateTime(2020)), () async {
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

    group('description', () {
      const descriptions = [
        'Sign-in client: Google Identity wrapper',
        '# not a comment',
        '- not a list',
        '&anchor',
        '*alias',
        '{not: a map}',
        '[not, a, list]',
        "Google's app",
        'A "quoted" app',
        r'C:\path\to\app',
        'multi\nline',
        'Café 🚀',
        '',
      ];

      Map<String, dynamic> run(String description) {
        when(() => context.vars).thenReturn({
          'project_name': 'my_game',
          'application_id': 'app.id',
          'description': description,
          'platforms': ['android'],
        });

        pre_gen.run(context);

        return verify(() => context.vars = captureAny()).captured.last
            as Map<String, dynamic>;
      }

      for (final description in descriptions) {
        test('round-trips through pubspec.yaml: "$description"', () {
          final vars = run(description);
          final pubspec = loadYaml(
            'description: ${vars['pubspec_description']}',
          ) as YamlMap;

          expect(pubspec['description'], equals(description));
        });
      }
    });
  });
}

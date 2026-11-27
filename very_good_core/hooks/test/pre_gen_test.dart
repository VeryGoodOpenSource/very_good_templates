import 'dart:convert';

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
          'project_name': 'my_app',
          'org_name': 'com.example',
          'application_id': 'app.id',
          'description': 'A new Flutter project.',
          'platforms': ['android', 'ios', 'linux', 'macos', 'web', 'windows'],
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
            'linux_application_id': 'app.id',
            'macos_application_id': 'app.id',
            'windows_application_id': 'app.id',
            'platforms': ['android', 'ios', 'linux', 'macos', 'web', 'windows'],
            'publishable': false,
            'workspace': false,
            'current_year': '2020',
            'pubspec_description': '"A new Flutter project."',
            'manifest_description': '"A new Flutter project."',
            'android': true,
            'ios': true,
            'linux': true,
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
        expect(newVars['linux'], isFalse);
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
        expect(newVars['linux'], isFalse);
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
          'project_name': 'my_app',
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

        test('round-trips through manifest.json: "$description"', () {
          final vars = run(description);
          final manifest = jsonDecode(
            '{"description": ${vars['manifest_description']}}',
          ) as Map<String, dynamic>;

          expect(manifest['description'], equals(description));
        });
      }
    });
  });
}

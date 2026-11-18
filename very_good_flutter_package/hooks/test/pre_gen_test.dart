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
          'project_name': 'my_package',
          'org_name': 'Very Good Ventures',
          'description': 'A very good flutter package.',
          'publishable': false,
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        final newVars =
            verify(() => context.vars = captureAny()).captured.last
                as Map<String, dynamic>;

        expect(
          newVars,
          equals({
            'project_name': 'my_package',
            'org_name': 'Very Good Ventures',
            'description': 'A very good flutter package.',
            'publishable': false,
            'current_year': '2020',
            'pubspec_description': '"A very good flutter package."',
          }),
        );
      });
    });

    group('pubspec_description', () {
      const descriptions = [
        'Sign-in client: Google Identity wrapper',
        '# not a comment',
        '- not a list',
        '&anchor',
        '*alias',
        '{not: a map}',
        '[not, a, list]',
        "Google's package",
        'A "quoted" package',
        r'C:\path\to\package',
        'multi\nline',
        'Café 🚀',
        '',
      ];

      for (final description in descriptions) {
        test('round-trips through YAML: "$description"', () {
          when(() => context.vars).thenReturn({'description': description});

          pre_gen.run(context);

          final newVars =
              verify(() => context.vars = captureAny()).captured.last
                  as Map<String, dynamic>;
          final pubspec = loadYaml(
            'description: ${newVars['pubspec_description']}',
          ) as YamlMap;

          expect(pubspec['description'], equals(description));
        });
      }
    });
  });
}

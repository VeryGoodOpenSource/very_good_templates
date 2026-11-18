import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
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
          'project_name': 'my_cli',
          'executable_name': 'my_cli',
          'description': 'A Very Good Dart CLI',
          'publishable': false,
          'org_name': 'Very Good Ventures',
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        final newVars =
            verify(() => context.vars = captureAny()).captured.last
                as Map<String, dynamic>;

        expect(
          newVars,
          equals({
            'project_name': 'my_cli',
            'executable_name': 'my_cli',
            'description': 'A Very Good Dart CLI',
            'publishable': false,
            'org_name': 'Very Good Ventures',
            'current_year': '2020',
            'pubspec_description': '"A Very Good Dart CLI"',
            'dart_description': "'A Very Good Dart CLI'",
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
        "Google's CLI",
        'A "quoted" CLI',
        r'C:\path\to\CLI',
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

    group('dart_description', () {
      String run(String description) {
        when(() => context.vars).thenReturn({'description': description});

        pre_gen.run(context);

        final newVars =
            verify(() => context.vars = captureAny()).captured.last
                as Map<String, dynamic>;
        return newVars['dart_description'] as String;
      }

      String parse(String literal) {
        final result = parseString(content: 'const description = $literal;');
        final declaration =
            result.unit.declarations.single as TopLevelVariableDeclaration;
        final initializer = declaration.variables.variables.single.initializer;
        return (initializer! as SimpleStringLiteral).value;
      }

      const descriptions = [
        'Sign-in client: Google Identity wrapper',
        "Google's CLI",
        'A "quoted" CLI',
        'Google\'s "quoted" CLI',
        r'C:\path\to\CLI',
        r'Costs $5 or ${amount}',
        r"Google's $5 \ CLI",
        'It\'s "\$5" \\ CLI',
        'multi\n\$line',
        'multi\nline',
        'carriage\rreturn',
        'Café 🚀',
        '',
      ];

      for (final description in descriptions) {
        test('round-trips through a Dart literal: "$description"', () {
          expect(parse(run(description)), equals(description));
        });
      }

      test('uses single quotes by default', () {
        expect(run('A "quoted" CLI'), equals("""'A "quoted" CLI'"""));
      });

      test('uses double quotes to avoid escaping single quotes', () {
        expect(run("Google's CLI"), equals('''"Google's CLI"'''));
      });

      test('escapes single quotes when both quote types are present', () {
        expect(
          run('Google\'s "quoted" CLI'),
          equals(r"""'Google\'s "quoted" CLI'"""),
        );
      });

      test(
        'uses a raw string when only backslashes or dollars need escaping',
        () {
          expect(run(r'C:\$HOME'), equals(r"r'C:\$HOME'"));
        },
      );

      test(
        'uses a raw double-quoted string when it contains single quotes',
        () {
          expect(run(r"Google's $5"), equals(r'''r"Google's $5"'''));
        },
      );

      test('escapes instead of using a raw string for newlines', () {
        expect(run('multi\n\$line'), equals(r"'multi\n\$line'"));
      });
    });
  });
}

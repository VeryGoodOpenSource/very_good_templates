import 'package:clock/clock.dart';
import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

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
          'project_name': 'my_docs_site',
          'org_name': 'my_org',
          'description': 'A very good docs site',
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
            'project_name': 'my_docs_site',
            'org_name': 'my_org',
            'description': 'A very good docs site',
            'publishable': false,
            'config_description': "'A very good docs site'",
            'current_year': '2020',
          }),
        );
      });
    });

    group('description', () {
      const descriptions = [
        'Sign-in client: Google Identity wrapper',
        "Google's docs",
        'A "quoted" docs site',
        r'C:\path\to\docs',
        'multi\nline',
        'Café 🚀',
        '',
      ];

      Map<String, dynamic> run(String description) {
        when(() => context.vars).thenReturn({
          'project_name': 'my_docs_site',
          'org_name': 'my_org',
          'description': description,
          'publishable': false,
        });

        pre_gen.run(context);

        return verify(() => context.vars = captureAny()).captured.last
            as Map<String, dynamic>;
      }

      for (final description in descriptions) {
        test('round-trips through docusaurus.config.js: "$description"', () {
          final vars = run(description);
          final literal = vars['config_description'] as String;

          // Prettier prefers single quotes, switching to double quotes only
          // when that reduces the number of escapes.
          final quote =
              "'".allMatches(description).length >
                  '"'.allMatches(description).length
              ? '"'
              : "'";
          expect(literal, startsWith(quote));
          expect(literal, endsWith(quote));

          expect(_decodeJsStringLiteral(literal), equals(description));
        });
      }
    });
  });
}

/// Decodes a JavaScript string literal produced by the hook, recovering the
/// original value.
String _decodeJsStringLiteral(String literal) {
  final inner = literal.substring(1, literal.length - 1);
  final buffer = StringBuffer();
  for (var i = 0; i < inner.length; i++) {
    final char = inner[i];
    if (char == r'\') {
      final next = inner[i + 1];
      i++;
      switch (next) {
        case 'n':
          buffer.write('\n');
        case 'r':
          buffer.write('\r');
        default:
          buffer.write(next);
      }
    } else {
      buffer.write(char);
    }
  }
  return buffer.toString();
}

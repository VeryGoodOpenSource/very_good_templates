import 'dart:convert';

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
            'config_description': '"A very good docs site"',
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
          // A JSON string is also a valid JavaScript string literal, so
          // decoding it as JSON recovers the original value.
          final tagline = jsonDecode(vars['config_description'] as String);

          expect(tagline, equals(description));
        });
      }
    });
  });
}

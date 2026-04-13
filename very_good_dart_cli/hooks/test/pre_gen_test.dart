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
          }),
        );
      });
    });
  });
}

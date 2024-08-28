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
      final clock = Clock.fixed(DateTime(2020));
      withClock(clock, () {
        final vars = {
          'project_name': 'my_game',
          'org_name': 'com.example',
          'application_id': 'app.id',
          'description': 'A new Flame project.',
          'current_year': clock.now().year,
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        final newVars = verify(() => context.vars = captureAny()).captured.last
            as Map<String, dynamic>;

        expect(
          newVars,
          equals(
            {
              'project_name': 'my_game',
              'org_name': 'com.example',
              'description': 'A new Flame project.',
              'android_namespace': 'app.id',
              'android_application_id': 'app.id',
              'ios_application_id': 'app.id',
              'macos_application_id': 'app.id',
              'windows_application_id': 'app.id',
              'current_year': clock.now().year,
            },
          ),
        );
      });
    });
  });
}

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
      final vars = {
        'project_name': 'my_app',
        'org_name': 'com.example',
        'application_id': 'app.id',
        'description': 'A new Flutter project.',
        'current_year': '2024',
      };
      when(() => context.vars).thenReturn(vars);

      pre_gen.run(context);

      final newVars = verify(() => context.vars = captureAny()).captured.last
          as Map<String, dynamic>;

      expect(
        newVars,
        equals(
          {
            'project_name': 'my_app',
            'org_name': 'com.example',
            'description': 'A new Flutter project.',
            'android_namespace': 'app.id',
            'android_application_id': 'app.id',
            'ios_application_id': 'app.id',
            'macos_application_id': 'app.id',
            'windows_application_id': 'app.id',
            'current_year': 2024,
          },
        ),
      );
    });
  });
}

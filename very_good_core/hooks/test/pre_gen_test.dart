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

    group('application_id_android', () {
      test('when specified is unmodified', () {
        final vars = <String, String>{
          'project_name': 'project_name',
          'org_name': 'org_name',
          'application_id': 'com.example.app',
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(context.vars['application_id_android'], 'com.example.app');
      });

      test(
        '''when not specified is set to `org_name + "." + project_name(snake_case)`''',
        () {
          final vars = <String, String>{
            'project_name': 'Project Name',
            'org_name': 'org_name',
          };
          when(() => context.vars).thenReturn(vars);

          pre_gen.run(context);

          expect(
            context.vars['application_id_android'],
            'org_name.project_name',
          );
        },
      );
    });

    group('application_id', () {
      test('when specified is unmodified', () {
        final vars = <String, String>{
          'project_name': 'project_name',
          'org_name': 'org_name',
          'application_id': 'com.example.app',
        };
        when(() => context.vars).thenReturn(vars);

        pre_gen.run(context);

        expect(context.vars['application_id'], 'com.example.app');
      });

      test(
        '''when not specified is set to `org_name + "." + project_name(param-case)`''',
        () {
          final vars = <String, String>{
            'project_name': 'Project Name',
            'org_name': 'org_name',
          };
          when(() => context.vars).thenReturn(vars);

          pre_gen.run(context);

          expect(
            context.vars['application_id'],
            'org_name.project-name',
          );
        },
      );
    });
  });
}

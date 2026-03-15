import 'package:test/test.dart';
import 'package:very_good_core_hooks/very_good_core_hooks.dart';

void main() {
  group('$VeryGoodCoreConfiguration', () {
    group('defaults', () {
      test('project_name to "my_app"', () {
        const configuration = VeryGoodCoreConfiguration();
        expect(configuration.projectName, 'my_app');
      });

      test('description to "A Very Good App"', () {
        const configuration = VeryGoodCoreConfiguration();
        expect(configuration.description, 'A Very Good App');
      });
    });

    group('fromHookVars', () {
      test('decodes as expected', () {
        final vars = {
          'project_name': 'very good app',
          'description': 'A Very Good App',
        };

        final configuration = VeryGoodCoreConfiguration.fromHookVars(vars);
        expect(
          configuration,
          equals(
            const VeryGoodCoreConfiguration(
              projectName: 'very good app',
              description: 'A Very Good App',
            ),
          ),
        );
      });

      test('defaults id when empty', () {
        final vars = {
          'project_name': 'very good app',
          'description': 'A Very Good App',
        };

        final configuration = VeryGoodCoreConfiguration.fromHookVars(vars);
        expect(
          configuration,
          equals(
            const VeryGoodCoreConfiguration(
              projectName: 'very good app',
              description: 'A Very Good App',
            ),
          ),
        );
      });

      group('throws $ArgumentError', () {
        test('when "project_name" is not a String?', () {
          final vars = <String, dynamic>{'project_name': 42};

          expect(
            () => VeryGoodCoreConfiguration.fromHookVars(vars),
            throwsA(
              isA<ArgumentError>().having(
                (error) => error.message,
                'message',
                '''Expected a value for key "project_name" to be of type String?, got 42.''',
              ),
            ),
          );
        });

        test('when "description" is not a String?', () {
          final vars = <String, dynamic>{'description': 42};

          expect(
            () => VeryGoodCoreConfiguration.fromHookVars(vars),
            throwsA(
              isA<ArgumentError>().having(
                (error) => error.message,
                'message',
                '''Expected a value for key "description" to be of type String?, got 42.''',
              ),
            ),
          );
        });
      });
    });
  });
}

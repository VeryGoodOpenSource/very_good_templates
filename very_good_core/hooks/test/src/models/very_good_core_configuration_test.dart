import 'package:test/test.dart';
import 'package:very_good_core_hooks/very_good_core_hooks.dart';

void main() {
  group('$VeryGoodCoreConfiguration', () {
    group('defaults', () {
      test('project_name to "my_app"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.projectName, 'my_app');
      });

      test('organization_name to "com.example"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.organizationName, 'com.example');
      });

      test('description to "A Very Good App"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.description, 'A Very Good App');
      });

      test('windowsApplicationId to "com.example.my-app"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.windowsApplicationId.value, 'com.example.my-app');
      });

      test('iOsApplicationId to "com.example.my-app"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.iOsApplicationId.value, 'com.example.my-app');
      });

      test('macOsApplicationId to "com.example.my-app"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.macOsApplicationId.value, 'com.example.my-app');
      });

      test('androidApplicationId to "com.example.my_app"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.androidApplicationId.value, 'com.example.my_app');
      });

      test('currentYear to the current year', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.currentYear, DateTime.now().year);
      });
    });

    group('throws', () {
      group('a $InvalidAndroidApplicationIdFormat when Android ID', () {
        test('has special characters', () {
          expect(
            () => VeryGoodCoreConfiguration(
              androidApplicationId: AndroidApplicationId('com.example.my_app!'),
            ),
            throwsA(isA<InvalidAndroidApplicationIdFormat>()),
          );
        });

        test('parts start with numeric character', () {
          expect(
            () => VeryGoodCoreConfiguration(
              androidApplicationId:
                  AndroidApplicationId('1com.1example.1my_app'),
            ),
            throwsA(isA<InvalidAndroidApplicationIdFormat>()),
          );
        });

        test('has a single part', () {
          expect(
            () => VeryGoodCoreConfiguration(
              androidApplicationId: AndroidApplicationId('com'),
            ),
            throwsA(isA<InvalidAndroidApplicationIdFormat>()),
          );
        });
      });
    });

    group('fromHookVars', () {
      test('decodes as expected', () {
        final vars = {
          'project_name': 'very good app',
          'org_name': 'com.verygood',
          'application_id': 'com.verygood.very_good_app',
          'description': 'A Very Good App',
          'current_year': 2024,
        };

        final configuration = VeryGoodCoreConfiguration.fromHookVars(vars);
        expect(
          configuration,
          equals(
            VeryGoodCoreConfiguration(
              projectName: 'very good app',
              organizationName: 'com.verygood',
              description: 'A Very Good App',
              windowsApplicationId:
                  WindowsApplicationId('com.verygood.very_good_app'),
              iOsApplicationId:
                  AppleApplicationId('com.verygood.very_good_app'),
              macOsApplicationId:
                  AppleApplicationId('com.verygood.very_good_app'),
              androidApplicationId:
                  AndroidApplicationId('com.verygood.very_good_app'),
              androidNamespace: AndroidNamespace('com.verygood.very_good_app'),
            ),
          ),
        );
      });

      test('defaults id when empty', () {
        final vars = {
          'project_name': 'very good app',
          'org_name': 'com.verygood',
          'application_id': '',
          'description': 'A Very Good App',
          'current_year': 2024,
        };

        final configuration = VeryGoodCoreConfiguration.fromHookVars(vars);
        expect(
          configuration,
          equals(
            VeryGoodCoreConfiguration(
              projectName: 'very good app',
              organizationName: 'com.verygood',
              description: 'A Very Good App',
              currentYear: 2024,
              windowsApplicationId:
                  WindowsApplicationId('com.verygood.very-good-app'),
              iOsApplicationId:
                  AppleApplicationId('com.verygood.very-good-app'),
              macOsApplicationId:
                  AppleApplicationId('com.verygood.very-good-app'),
              androidApplicationId:
                  AndroidApplicationId('com.verygood.very_good_app'),
              androidNamespace: AndroidNamespace('com.verygood.very_good_app'),
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

        test('when "org_name" is not a String?', () {
          final vars = <String, dynamic>{'org_name': 42};

          expect(
            () => VeryGoodCoreConfiguration.fromHookVars(vars),
            throwsA(
              isA<ArgumentError>().having(
                (error) => error.message,
                'message',
                '''Expected a value for key "org_name" to be of type String?, got 42.''',
              ),
            ),
          );
        });

        test('when "application_id" is not a String?', () {
          final vars = <String, dynamic>{'application_id': 42};

          expect(
            () => VeryGoodCoreConfiguration.fromHookVars(vars),
            throwsA(
              isA<ArgumentError>().having(
                (error) => error.message,
                'message',
                '''Expected a value for key "application_id" to be of type String?, got 42.''',
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

        test('when "current_year" is not an int?', () {
          final vars = <String, dynamic>{'current_year': 'string_value'};

          expect(
            () => VeryGoodCoreConfiguration.fromHookVars(vars),
            throwsA(
              isA<ArgumentError>().having(
                (error) => error.message,
                'message',
                '''Expected a value for key "current_year" to be of type int?, got string_value.''',
              ),
            ),
          );
        });
      });
    });
  });
}

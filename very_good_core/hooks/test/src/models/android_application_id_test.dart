import 'package:test/test.dart';
import 'package:very_good_core_hooks/very_good_core_hooks.dart';

void main() {
  group('$AndroidApplicationId', () {
    group('fallback', () {
      test(
        'concatenates organization name with project name in snake case',
        () {
          const organizationName = 'com.example.hello-world';
          const projectName = 'my app';
          final androidApplicationId = AndroidApplicationId.fallback(
            organizationName: organizationName,
            projectName: projectName,
          );
          expect(androidApplicationId.value, 'com.example.hello_world.my_app');
        },
      );

      test(
        'ignores empty segments',
        () {
          const organizationName = 'com..example..hello-world';
          const projectName = 'my app';
          final androidApplicationId = AndroidApplicationId.fallback(
            organizationName: organizationName,
            projectName: projectName,
          );
          expect(androidApplicationId.value, 'com.example.hello_world.my_app');
        },
      );
    });

    group('isValid', () {
      group('returns true', () {
        test('when Android ID is valid', () {
          final androidApplicationId = AndroidApplicationId('com.example.app');
          expect(androidApplicationId.isValid, isTrue);
        });
      });

      group('returns false', () {
        test('when Android ID has less than two segments', () {
          final androidApplicationId = AndroidApplicationId('com');
          expect(androidApplicationId.isValid, isFalse);
        });

        test('when Android ID has a segment that starts with a non-letter', () {
          final androidApplicationId = AndroidApplicationId('1com.example.app');
          expect(androidApplicationId.isValid, isFalse);
        });

        test('when Android ID has a segment with a special character', () {
          final androidApplicationId = AndroidApplicationId('com.example.app!');
          expect(androidApplicationId.isValid, isFalse);
        });
      });
    });
  });
}

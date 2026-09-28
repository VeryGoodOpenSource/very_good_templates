import 'package:test/test.dart';
import 'package:very_good_core_hooks/very_good_core_hooks.dart';

void main() {
  group('$LinuxApplicationId', () {
    group('fallback', () {
      test(
        'concatenates organization name with project name in snake case',
        () {
          const organizationName = 'com.example.hello-world';
          const projectName = 'my app';
          final linuxApplicationId = LinuxApplicationId.fallback(
            organizationName: organizationName,
            projectName: projectName,
          );
          expect(linuxApplicationId.value, 'com.example.hello_world.my_app');
        },
      );

      test('ignores empty parts', () {
        const organizationName = 'com..example..hello-world';
        const projectName = 'my app';
        final linuxApplicationId = LinuxApplicationId.fallback(
          organizationName: organizationName,
          projectName: projectName,
        );
        expect(linuxApplicationId.value, 'com.example.hello_world.my_app');
      });
    });

    group('isValid', () {
      group('returns true', () {
        test('when Linux ID is valid', () {
          final linuxApplicationId = LinuxApplicationId('com.example.app');
          expect(linuxApplicationId.isValid, isTrue);
        });
      });

      group('returns false', () {
        test('when Linux ID has less than two segments', () {
          final linuxApplicationId = LinuxApplicationId('com');
          expect(linuxApplicationId.isValid, isFalse);
        });

        test('when Linux ID has a segment that starts with a non-letter', () {
          final linuxApplicationId = LinuxApplicationId('1com.example.app');
          expect(linuxApplicationId.isValid, isFalse);
        });

        test('when Linux ID has a segment with a special character', () {
          final linuxApplicationId = LinuxApplicationId('com.example.app!');
          expect(linuxApplicationId.isValid, isFalse);
        });
      });
    });
  });
}

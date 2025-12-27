import 'package:dependency_tightener/dependency_tightener.dart';
import 'package:test/test.dart';

void main() {
  group('getAutoSkipPackages', () {
    test('returns intl when flutter_localizations is present', () {
      const pubspecContent = '''
name: my_app
description: A Flutter app.

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.18.0

dev_dependencies:
  flutter_test:
    sdk: flutter
''';

      final result = getAutoSkipPackages(pubspecContent);

      expect(result, contains('intl'));
      expect(result.length, equals(1));
    });

    test('returns empty set when no SDK dependencies', () {
      const pubspecContent = '''
name: my_package
description: A Dart package.

dependencies:
  bloc: ^8.0.0
  http: ^1.0.0

dev_dependencies:
  test: ^1.24.0
''';

      final result = getAutoSkipPackages(pubspecContent);

      expect(result, isEmpty);
    });

    test('returns empty set when only flutter SDK dependency', () {
      const pubspecContent = '''
name: my_app
description: A Flutter app.

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
''';

      final result = getAutoSkipPackages(pubspecContent);

      expect(result, isEmpty);
    });

    test('handles mustache template syntax gracefully', () {
      const pubspecContent = '''
name: {{project_name.snakeCase()}}
description: A very good {{project_name.snakeCase()}} project.
version: 0.1.0+1
{{^publishable}}publish_to: none{{/publishable}}

environment:
  sdk: {{{dartSdkVersionBounds}}}

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.18.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  very_good_analysis: ^5.1.0
''';

      final result = getAutoSkipPackages(pubspecContent);

      expect(result, contains('intl'));
    });

    test('handles different whitespace patterns', () {
      // Tab indentation
      const pubspecWithTabs = '''
name: my_app

dependencies:
\tflutter_localizations:
\t\tsdk: flutter
''';

      expect(getAutoSkipPackages(pubspecWithTabs), contains('intl'));

      // Extra spaces
      const pubspecWithExtraSpaces = '''
name: my_app

dependencies:
  flutter_localizations:
      sdk:   flutter
''';

      expect(getAutoSkipPackages(pubspecWithExtraSpaces), contains('intl'));
    });

    test('does not match flutter_localizations when not SDK dependency', () {
      const pubspecContent = '''
name: my_app

dependencies:
  flutter_localizations: ^1.0.0
''';

      final result = getAutoSkipPackages(pubspecContent);

      expect(result, isEmpty);
    });
  });

  group('sdkPinnedPackages', () {
    test('contains flutter_localizations mapping', () {
      expect(sdkPinnedPackages, contains('flutter_localizations'));
      expect(sdkPinnedPackages['flutter_localizations'], contains('intl'));
    });
  });
}

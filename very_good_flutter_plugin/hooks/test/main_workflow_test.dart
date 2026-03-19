import 'dart:io';

import 'package:mason/mason.dart';
import 'package:test/test.dart';

void main() {
  group('main workflow template', () {
    late String templateContent;

    setUpAll(() {
      final brickDir = Uri.directory(Directory.current.path)
          .resolve('../__brick__/')
          .toFilePath();
      final templateFile = File(
        '$brickDir.github/workflows/{{project_name.snakeCase()}}.yaml',
      );
      templateContent = templateFile.readAsStringSync();
    });

    /// Renders the main workflow template with the given [platforms] enabled.
    String renderWorkflow({
      required List<String> platforms,
      bool publishable = false,
    }) {
      const allPlatforms = [
        'android',
        'ios',
        'linux',
        'macos',
        'web',
        'windows',
      ];
      final vars = <String, dynamic>{
        'project_name': 'test_plugin',
        'flutterVersion': '3.38.0',
        'publishable': publishable,
        for (final p in allPlatforms) p: platforms.contains(p),
      };
      return templateContent.render(vars);
    }

    /// Matches a YAML job key at the top level of the `jobs:` block.
    ///
    /// E.g. `  android:` (two-space indent followed by the job name and colon).
    Matcher containsJob(String jobName) =>
        matches(RegExp('^  $jobName:', multiLine: true));

    group('includes only selected platform jobs', () {
      test('when only android and ios are selected', () {
        final output = renderWorkflow(platforms: ['android', 'ios']);

        expect(output, containsJob('android'));
        expect(output, containsJob('ios'));
        expect(output, isNot(containsJob('linux')));
        expect(output, isNot(containsJob('macos')));
        expect(output, isNot(containsJob('web')));
        expect(output, isNot(containsJob('windows')));
      });

      test('when only web and linux are selected', () {
        final output = renderWorkflow(platforms: ['web', 'linux']);

        expect(output, containsJob('web'));
        expect(output, containsJob('linux'));
        expect(output, isNot(containsJob('android')));
        expect(output, isNot(containsJob('ios')));
        expect(output, isNot(containsJob('macos')));
        expect(output, isNot(containsJob('windows')));
      });

      test('when all platforms are selected', () {
        final output = renderWorkflow(
          platforms: ['android', 'ios', 'linux', 'macos', 'web', 'windows'],
        );

        expect(output, containsJob('android'));
        expect(output, containsJob('ios'));
        expect(output, containsJob('linux'));
        expect(output, containsJob('macos'));
        expect(output, containsJob('web'));
        expect(output, containsJob('windows'));
      });

      test('when a single platform is selected', () {
        final output = renderWorkflow(platforms: ['macos']);

        expect(output, containsJob('macos'));
        expect(output, isNot(containsJob('android')));
        expect(output, isNot(containsJob('ios')));
        expect(output, isNot(containsJob('linux')));
        expect(output, isNot(containsJob('web')));
        expect(output, isNot(containsJob('windows')));
      });
    });

    group('always includes non-platform jobs', () {
      test('spell-check is always present', () {
        final output = renderWorkflow(platforms: ['android']);
        expect(output, containsJob('spell-check'));
      });

      test('build is always present', () {
        final output = renderWorkflow(platforms: ['android']);
        expect(output, containsJob('build'));
      });
    });

    group('publishable conditional', () {
      test('includes pana job when publishable is true', () {
        final output = renderWorkflow(
          platforms: ['android'],
          publishable: true,
        );
        expect(output, containsJob('pana'));
      });

      test('excludes pana job when publishable is false', () {
        final output = renderWorkflow(
          platforms: ['android'],
        );
        expect(output, isNot(containsJob('pana')));
      });
    });
  });
}

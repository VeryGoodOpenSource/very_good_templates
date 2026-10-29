import 'dart:convert';
import 'dart:io';

import 'package:dependency_tightener/dependency_tightener.dart';
import 'package:test/test.dart';

import '../fixtures/fixtures.dart';

void main() {
  group('buildResolvablePubspec', () {
    test('keeps only hosted and SDK dependencies', () {
      const pubspec = '''
name: {{project_name.snakeCase()}}

environment:
  sdk: {{{dartSdkVersionBounds}}}

dependencies:
  {{project_name.snakeCase()}}_platform_interface:
    path: ../{{project_name.snakeCase()}}_platform_interface
  build_version: ^2.2.1
  1: ^1.0.0

dev_dependencies:
{{^workspace}}  build_verify: ^3.1.1
{{/workspace}}  build_runner: ^2.16.2
''';

      expect(buildResolvablePubspec(pubspec), {
        'name': 'dependency_tightener_check',
        'publish_to': 'none',
        'environment': {'sdk': '^3.0.0'},
        'dependencies': {'build_version': '^2.2.1'},
        'dev_dependencies': {
          'build_verify': '^3.1.1',
          'build_runner': '^2.16.2',
        },
      });
    });

    test('keeps Flutter SDK dependencies', () {
      expect(buildResolvablePubspec(pubspec1), {
        'name': 'dependency_tightener_check',
        'publish_to': 'none',
        'environment': {'sdk': '^3.0.0'},
        'dependencies': {
          'flutter': {'sdk': 'flutter'},
          'plugin_platform_interface': '^2.1.0',
          'pub_updater': '0.3.0',
        },
        'dev_dependencies': {
          'mocktail': '^1.0.3',
          'flutter_test': {'sdk': 'flutter'},
          'very_good_analysis': '^5.1.0',
        },
      });
    });

    test('returns no dependencies when the YAML is not a map', () {
      final pubspec = buildResolvablePubspec('not a map');

      expect(pubspec['dependencies'], isEmpty);
      expect(pubspec['dev_dependencies'], isEmpty);
    });
  });

  group('dependsOnFlutter', () {
    test('is true when depending on the Flutter SDK', () {
      expect(dependsOnFlutter(buildResolvablePubspec(pubspec1)), isTrue);
    });

    test('is false when not depending on the Flutter SDK', () {
      expect(
        dependsOnFlutter(
          buildResolvablePubspec('''
dependencies:
  args: ^2.5.0
'''),
        ),
        isFalse,
      );
    });
  });

  group('PubspecResolver', () {
    late Directory tempDirectory;
    late List<String> commands;
    late Map<String, Object?> writtenPubspec;
    late int exitCode;

    Future<ProcessResult> runProcess(
      String executable,
      List<String> arguments, {
      String? workingDirectory,
    }) async {
      commands.add([executable, ...arguments].join(' '));
      expect(workingDirectory, tempDirectory.path);
      writtenPubspec = jsonDecode(
        File('$workingDirectory/pubspec.yaml').readAsStringSync(),
      ) as Map<String, Object?>;
      return ProcessResult(0, exitCode, '', '');
    }

    setUp(() {
      tempDirectory = Directory.systemTemp.createTempSync('resolver_test');
      addTearDown(() {
        if (tempDirectory.existsSync()) {
          tempDirectory.deleteSync(recursive: true);
        }
      });
      commands = [];
      exitCode = 0;
    });

    PubspecResolver buildResolver() => PubspecResolver(
      runProcess: runProcess,
      createTempDirectory: () => tempDirectory,
    );

    test('resolves Flutter packages with flutter pub get', () async {
      expect(await buildResolver().canResolve(pubspec1), isTrue);

      expect(commands, ['flutter pub get']);
      expect(writtenPubspec, buildResolvablePubspec(pubspec1));
    });

    test('resolves Dart packages with dart pub get', () async {
      const pubspec = '''
dependencies:
  args: ^2.5.0
''';

      expect(await buildResolver().canResolve(pubspec), isTrue);

      expect(commands, ['dart pub get']);
      expect(writtenPubspec, buildResolvablePubspec(pubspec));
    });

    test('returns false when pub get fails', () async {
      exitCode = 1;

      expect(await buildResolver().canResolve(pubspec1), isFalse);
    });

    test('deletes the temporary directory', () async {
      await buildResolver().canResolve(pubspec1);

      expect(tempDirectory.existsSync(), isFalse);
    });

    test('creates a system temporary directory by default', () async {
      final resolver = PubspecResolver(
        runProcess: (executable, arguments, {workingDirectory}) async {
          expect(workingDirectory, startsWith(Directory.systemTemp.path));
          return ProcessResult(0, 0, '', '');
        },
      );

      expect(await resolver.canResolve(pubspec1), isTrue);
    });
  });
}

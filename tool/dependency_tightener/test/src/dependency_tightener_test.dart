import 'dart:io';

import 'package:dependency_tightener/dependency_tightener.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:test/test.dart';

import '../fixtures/fixtures.dart';

class _MockPubUpdater extends Mock implements PubUpdater {}

class _MockFile extends Mock implements File {}

void main() {
  late File pubspec;
  late PubUpdater pubUpdater;

  setUp(() {
    pubspec = _MockFile();
    when(() => pubspec.readAsStringSync()).thenReturn(pubspec1);
    when(() => pubspec.path).thenReturn('pubspec.yaml');

    pubUpdater = _MockPubUpdater();

    when(
      () => pubUpdater.isUpToDate(
        packageName: any(
          named: 'packageName',
          that: equals('plugin_platform_interface'),
        ),
        currentVersion: any(
          named: 'currentVersion',
          that: equals('2.1.0'),
        ),
      ),
    ).thenAnswer((_) async => false);
    when(
      () => pubUpdater.getLatestVersion(
        any(that: equals('plugin_platform_interface')),
      ),
    ).thenAnswer((_) async => '2.2.0');

    when(
      () => pubUpdater.isUpToDate(
        packageName: any(
          named: 'packageName',
          that: equals('pub_updater'),
        ),
        currentVersion: any(
          named: 'currentVersion',
          that: equals('0.3.0'),
        ),
      ),
    ).thenAnswer((_) async => true);

    when(
      () => pubUpdater.isUpToDate(
        packageName: any(
          named: 'packageName',
          that: equals('mocktail'),
        ),
        currentVersion: any(
          named: 'currentVersion',
          that: equals('1.0.3'),
        ),
      ),
    ).thenAnswer((_) async => false);
    when(
      () => pubUpdater.getLatestVersion(
        any(that: equals('mocktail')),
      ),
    ).thenAnswer((_) async => '1.0.4');

    when(
      () => pubUpdater.isUpToDate(
        packageName: any(
          named: 'packageName',
          that: equals('very_good_analysis'),
        ),
        currentVersion: any(
          named: 'currentVersion',
          that: equals('5.1.0'),
        ),
      ),
    ).thenAnswer((_) async => false);
    when(
      () => pubUpdater.getLatestVersion(
        any(that: equals('very_good_analysis')),
      ),
    ).thenAnswer((_) async => '6.0.0');
  });

  test('updates the file according to the latest versions', () async {
    await tightenDependencies(
      pubspec,
      pubUpdater: pubUpdater,
      log: (object) => {},
    );

    const expectedPubspec = '''
name: {{project_name.snakeCase()}}
description: A very good {{project_name.snakeCase()}} project.
version: 0.1.0+1
{{^publishable}}publish_to: none{{/publishable}}

environment:
  sdk: {{{dartSdkVersionBounds}}}

dependencies:
  flutter:
    sdk: flutter
  plugin_platform_interface: ^2.2.0
  pub_updater: 0.3.0

dev_dependencies:
{{#my_variable}}  mocktail: ^1.0.4{{/my_variable}}
  flutter_test:
    sdk: flutter
  very_good_analysis: ^6.0.0
''';

    verify(() => pubspec.writeAsStringSync(expectedPubspec)).called(1);
  });

  test('logs updated dependencies', () async {
    final logs = <Object?>[];

    await tightenDependencies(
      pubspec,
      pubUpdater: pubUpdater,
      log: logs.add,
    );

    expect(
      logs,
      containsAll([
        'Updated plugin_platform_interface to ^2.2.0 in pubspec.yaml',
        'Updated mocktail to ^1.0.4 in pubspec.yaml',
        'Updated very_good_analysis to ^6.0.0 in pubspec.yaml',
      ]),
    );
  });
}

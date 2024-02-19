@Tags(['e2e'])
library e2e;

import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

/// Exit code indicating a command completed successfully.
///
/// [Source](https://www.freebsd.org/cgi/man.cgi?query=sysexits).
const _sucessfulExitCode = 0;

void main() {
  group('very_good_wear_app brick', () {
    test(
      'creates a tested application',
      timeout: const Timeout(Duration(minutes: 2)),
      () async {
        final rootPath = Directory.current.parent.parent.path;
        final brickPath = path.join(rootPath, 'brick');
        final brick = Brick.path(brickPath);
        final masonGenerator = await MasonGenerator.fromBrick(brick);
        final tempDirectory = Directory.systemTemp.createTempSync();
        final directoryGeneratorTarget = DirectoryGeneratorTarget(
          tempDirectory,
        );
        final vars = <String, dynamic>{
          'project_name': 'test_app',
          'org_name': 'ventures.verygood',
          'application_id': 'ventures.verygood.test',
          'description': 'very_good_wear_app test',
        };
        await masonGenerator.generate(directoryGeneratorTarget, vars: vars);

        final applicationPath = path.join(
          directoryGeneratorTarget.dir.path,
          vars['project_name'] as String,
        );
        final flutterPubGetResult = await Process.run(
          'flutter',
          ['pub', 'get'],
          workingDirectory: applicationPath,
          runInShell: true,
        );
        expect(
          flutterPubGetResult.exitCode,
          equals(_sucessfulExitCode),
          reason: '`flutter pub get` failed',
        );
        expect(
          flutterPubGetResult.stderr,
          isEmpty,
          reason: '`flutter pub get` failed',
        );

        final flutterTest = await Process.run(
          'flutter',
          ['test'],
          workingDirectory: applicationPath,
          runInShell: true,
        );
        expect(
          flutterTest.exitCode,
          equals(_sucessfulExitCode),
          reason: '`flutter test` failed',
        );
        expect(
          flutterTest.stderr,
          isEmpty,
          reason: '`flutter test` failed',
        );

        tempDirectory.deleteSync(recursive: true);
      },
    );
  });
}

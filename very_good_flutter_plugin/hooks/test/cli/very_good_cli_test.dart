import 'dart:io';

import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:very_good_flutter_plugin_hooks/src/cli/cli.dart';

class _TestProcess {
  Future<ProcessResult> run(
    String command,
    List<String> args, {
    bool runInShell = false,
    String? workingDirectory,
  }) {
    throw UnimplementedError();
  }
}

class _MockProcess extends Mock implements _TestProcess {}

class _MockLogger extends Mock implements Logger {}

void main() {
  group('$VeryGoodCli', () {
    final processResult = ProcessResult(42, ExitCode.success.code, '', '');
    late _TestProcess process;
    late Logger logger;

    setUp(() {
      logger = _MockLogger();

      process = _MockProcess();
      when(
        () => process.run(
          any(),
          any(),
          runInShell: any(named: 'runInShell'),
          workingDirectory: any(named: 'workingDirectory'),
        ),
      ).thenAnswer((_) async => processResult);
      runProcess = process.run;
    });

    tearDown(() {
      runProcess = null;
    });

    group('isInstalled', () {
      test('returns true when dart is installed', () async {
        await expectLater(
          VeryGoodCli.instance.isInstalled(logger: logger),
          completion(isTrue),
        );
      });

      test('returns false when dart is not installed', () async {
        final processResult = ProcessResult(42, ExitCode.software.code, '', '');

        when(
          () => process.run(
            any(),
            any(),
            runInShell: any(named: 'runInShell'),
            workingDirectory: any(named: 'workingDirectory'),
          ),
        ).thenAnswer((_) async => processResult);

        await expectLater(
          VeryGoodCli.instance.isInstalled(logger: logger),
          completion(isFalse),
        );
      });
    });

    group('packagesGet', () {
      test('completes normally', () async {
        await expectLater(
          VeryGoodCli.instance.packagesGet(logger: logger),
          completes,
        );
      });

      test('calls `very_good packages get .`', () {
        VeryGoodCli.instance.packagesGet(logger: logger);

        verify(
          () => process.run(
            'very_good',
            ['packages', 'get'],
            runInShell: true,
            workingDirectory: '.',
          ),
        ).called(1);
      });

      test('calls with given working directory', () {
        VeryGoodCli.instance.packagesGet(logger: logger, cwd: 'foo');

        verify(
          () => process.run(
            'very_good',
            ['packages', 'get'],
            runInShell: true,
            workingDirectory: 'foo',
          ),
        ).called(1);
      });

      test(
        '''calls `very_good packages get --recursive .` when recursive is true''',
        () {
          VeryGoodCli.instance.packagesGet(logger: logger, recursive: true);

          verify(
            () => process.run(
              'very_good',
              ['packages', 'get', '--recursive'],
              runInShell: true,
              workingDirectory: '.',
            ),
          ).called(1);
        },
      );
    });
  });
}

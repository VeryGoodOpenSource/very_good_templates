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
  group('$DartCli', () {
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
          DartCli.instance.isInstalled(logger: logger),
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
          DartCli.instance.isInstalled(logger: logger),
          completion(isFalse),
        );
      });
    });

    group('format', () {
      test('completes normally', () async {
        await expectLater(DartCli.instance.format(logger: logger), completes);
      });

      test('calls with given working directory', () async {
        await DartCli.instance.format(logger: logger, cwd: 'foo');

        verify(
          () => process.run(
            'dart',
            ['format'],
            runInShell: true,
            workingDirectory: 'foo',
          ),
        ).called(1);
      });

      test('calls `dart format .`', () async {
        await DartCli.instance.format(logger: logger);

        verify(
          () => process.run(
            'dart',
            ['format'],
            runInShell: true,
            workingDirectory: '.',
          ),
        ).called(1);
      });
    });

    group('fix', () {
      test('completes normally', () async {
        await expectLater(DartCli.instance.fix(logger: logger), completes);
      });

      test('calls with given working directory', () async {
        await DartCli.instance.fix(logger: logger, cwd: 'foo');

        verify(
          () => process.run(
            'dart',
            ['fix'],
            runInShell: true,
            workingDirectory: 'foo',
          ),
        ).called(1);
      });

      test('calls `dart fix .`', () async {
        await DartCli.instance.fix(logger: logger);

        verify(
          () => process.run(
            'dart',
            ['fix'],
            runInShell: true,
            workingDirectory: '.',
          ),
        ).called(1);
      });

      test('calls `dart fix --apply .` when apply is true', () async {
        await DartCli.instance.fix(logger: logger, apply: true);

        verify(
          () => process.run(
            'dart',
            ['fix', '--apply'],
            runInShell: true,
            workingDirectory: '.',
          ),
        ).called(1);
      });
    });
  });
}

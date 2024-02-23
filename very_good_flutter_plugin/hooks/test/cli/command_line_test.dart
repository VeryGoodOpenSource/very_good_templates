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
  group('$CommandLine', () {
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

    group('logs', () {
      test('when started running', () {
        CommandLine.run(
          'foo',
          ['bar'],
          logger: logger,
        );
        verify(
          () => logger.detail('Running: foo with [bar]'),
        ).called(1);
      });

      test('stdout when finished running', () async {
        const stdout = 'hello world!';
        final processResult = ProcessResult(
          42,
          ExitCode.success.code,
          stdout,
          '',
        );
        when(
          () => process.run(
            any(),
            any(),
            runInShell: any(named: 'runInShell'),
            workingDirectory: any(named: 'workingDirectory'),
          ),
        ).thenAnswer((_) async => processResult);

        await CommandLine.run(
          'foo',
          ['bar'],
          logger: logger,
        );

        verify(() => logger.detail('stdout:\n$stdout')).called(1);
      });

      test('stderr when finished running', () async {
        const stderr = 'hello world!';
        final processResult = ProcessResult(
          42,
          ExitCode.success.code,
          '',
          stderr,
        );
        when(
          () => process.run(
            any(),
            any(),
            runInShell: any(named: 'runInShell'),
            workingDirectory: any(named: 'workingDirectory'),
          ),
        ).thenAnswer((_) async => processResult);

        await CommandLine.run(
          'foo',
          ['bar'],
          logger: logger,
        );

        verify(() => logger.detail('stderr:\n$stderr')).called(1);
      });
    });

    group('throws ProcessException', () {
      test('when exit code is non-zero', () async {
        final processResult = ProcessResult(
          42,
          ExitCode.software.code,
          '',
          '',
        );
        when(
          () => process.run(
            any(),
            any(),
            runInShell: any(named: 'runInShell'),
            workingDirectory: any(named: 'workingDirectory'),
          ),
        ).thenAnswer((_) async => processResult);

        const executable = 'foo';
        const arguments = ['bar'];
        await expectLater(
          CommandLine.run(
            executable,
            arguments,
            logger: logger,
          ),
          throwsA(
            isA<ProcessException>()
                .having(
                  (exception) => exception.executable,
                  'executable',
                  equals(executable),
                )
                .having(
                  (exception) => exception.errorCode,
                  'errorCode',
                  equals(processResult.exitCode),
                )
                .having(
                  (exception) => exception.arguments,
                  'arguments',
                  equals(arguments),
                ),
          ),
        );
      });

      test(
        'with "Unknown error" message if stderr and stdout are empty',
        () {
          final processResult = ProcessResult(
            42,
            ExitCode.software.code,
            '',
            '',
          );
          when(
            () => process.run(
              any(),
              any(),
              runInShell: any(named: 'runInShell'),
              workingDirectory: any(named: 'workingDirectory'),
            ),
          ).thenAnswer((_) async => processResult);

          const message = 'Unknown error';
          expect(
            () => CommandLine.run(
              'foo',
              ['bar'],
              logger: logger,
            ),
            throwsA(
              isA<ProcessException>().having(
                (exception) => exception.message,
                'message',
                equals(message),
              ),
            ),
          );
        },
      );

      test(
        'with stdout and stderr message if stderr and stdout are non-empty',
        () {
          const stdout = 'hello stdout!';
          const stderr = 'hello stderr!';
          final processResult = ProcessResult(
            42,
            ExitCode.software.code,
            stdout,
            stderr,
          );
          when(
            () => process.run(
              any(),
              any(),
              runInShell: any(named: 'runInShell'),
              workingDirectory: any(named: 'workingDirectory'),
            ),
          ).thenAnswer((_) async => processResult);

          const message = '''
Standard out:
hello stdout!
Standard error:
hello stderr!''';
          expect(
            () => CommandLine.run(
              'foo',
              ['bar'],
              logger: logger,
            ),
            throwsA(
              isA<ProcessException>().having(
                (exception) => exception.message,
                'message',
                equals(message),
              ),
            ),
          );
        },
      );
    });
  });
}

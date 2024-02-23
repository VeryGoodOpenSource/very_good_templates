// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:very_good_flutter_plugin_hooks/src/cli/cli.dart';

import '../post_gen.dart' as post_gen;

class _MockHookContext extends Mock implements HookContext {}

class _MockLogger extends Mock implements Logger {}

class _MockDartCli extends Mock implements DartCli {}

class _MockVeryGoodCli extends Mock implements VeryGoodCli {}

void main() {
  group('post gen', () {
    late HookContext context;
    late Logger logger;

    setUp(() {
      context = _MockHookContext();
      logger = _MockLogger();

      when(() => context.vars).thenReturn({});
      when(() => context.logger).thenReturn(logger);
    });

    group('dart fix output', () {
      late DartCli dartCli;
      late VeryGoodCli veryGoodCli;

      setUpAll(() {
        registerFallbackValue('');
      });

      setUp(() {
        dartCli = _MockDartCli();
        veryGoodCli = _MockVeryGoodCli();

        when(() => dartCli.isInstalled(logger: logger)).thenAnswer(
          (_) => Future.value(true),
        );

        when(() => veryGoodCli.isInstalled(logger: logger)).thenAnswer(
          (_) => Future.value(true),
        );

        when(() => context.vars).thenReturn(
          {post_gen.dartFixOutputVariableKey: true},
        );

        when(
          () => veryGoodCli.packagesGet(
            logger: logger,
            recursive: true,
            cwd: any(named: 'cwd'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => dartCli.fix(
            logger: logger,
            apply: true,
            cwd: any(named: 'cwd'),
          ),
        ).thenAnswer((_) async {});
        when(
          () => dartCli.format(
            logger: logger,
            cwd: any(named: 'cwd'),
          ),
        ).thenAnswer((_) async {});
      });

      test('runs when enabled', () async {
        await post_gen.run(
          context,
          dartCli: dartCli,
          veryGoodCli: veryGoodCli,
        );

        verify(
          () => veryGoodCli.packagesGet(
            logger: logger,
            recursive: true,
            cwd: any(named: 'cwd'),
          ),
        ).called(1);
        verify(
          () => dartCli.fix(
            logger: logger,
            apply: true,
            cwd: any(named: 'cwd'),
          ),
        ).called(1);
        verify(
          () => dartCli.format(
            logger: logger,
            cwd: any(named: 'cwd'),
          ),
        ).called(1);
      });

      test('does not run when disabled', () async {
        when(() => context.vars).thenReturn(
          {post_gen.dartFixOutputVariableKey: false},
        );

        await post_gen.run(
          context,
          veryGoodCli: veryGoodCli,
          dartCli: dartCli,
        );

        verifyZeroInteractions(dartCli);
        verifyZeroInteractions(veryGoodCli);
      });

      test('does not run when no key exists', () async {
        when(() => context.vars).thenReturn({});

        await post_gen.run(
          context,
          veryGoodCli: veryGoodCli,
          dartCli: dartCli,
        );

        verifyZeroInteractions(dartCli);
        verifyZeroInteractions(veryGoodCli);
      });

      group('warns', () {
        test('if Dart CLI is not installed', () async {
          when(() => dartCli.isInstalled(logger: logger)).thenAnswer(
            (_) => Future.value(false),
          );

          await post_gen.run(
            context,
            dartCli: dartCli,
          );

          verify(
            () => logger.warn(
              'Could not fix output because Dart CLI is not installed.',
            ),
          ).called(1);
        });

        test('if Very Good CLI is not installed', () async {
          when(() => veryGoodCli.isInstalled(logger: logger)).thenAnswer(
            (_) => Future.value(false),
          );

          await post_gen.run(
            context,
            dartCli: dartCli,
            veryGoodCli: veryGoodCli,
          );

          verify(
            () => logger.warn(
              'Could not fix output because Very Good CLI is not installed.',
            ),
          ).called(1);
        });
      });

      group('errors', () {
        test(
          'if a $ProcessException is thrown by VeryGoodCLI.packagesGet',
          () async {
            const exception = ProcessException('executable', ['arguments']);
            when(
              () => veryGoodCli.packagesGet(
                logger: logger,
                recursive: true,
                cwd: any(named: 'cwd'),
              ),
            ).thenAnswer((_) => Future.error(exception));

            await post_gen.run(
              context,
              dartCli: dartCli,
              veryGoodCli: veryGoodCli,
            );

            verify(
              () => logger.err('''
Running process ${exception.executable} with ${exception.arguments} failed:
${exception.message}
'''),
            ).called(1);
          },
        );

        test(
          'if an unknown error is thrown by VeryGoodCLI.packagesGet',
          () async {
            final exception = Exception('error');
            when(
              () => veryGoodCli.packagesGet(
                logger: logger,
                recursive: true,
                cwd: any(named: 'cwd'),
              ),
            ).thenAnswer((_) => Future.error(exception));

            await post_gen.run(
              context,
              dartCli: dartCli,
              veryGoodCli: veryGoodCli,
            );

            verify(
              () => logger.err(
                '''Unknown error occurred when fixing output: $exception''',
              ),
            ).called(1);
          },
        );

        test(
          'if a $ProcessException is thrown by DartCli.fix',
          () async {
            const exception = ProcessException('executable', ['arguments']);
            when(
              () => dartCli.fix(
                logger: logger,
                apply: true,
                cwd: any(named: 'cwd'),
              ),
            ).thenAnswer((_) => Future.error(exception));

            await post_gen.run(
              context,
              dartCli: dartCli,
              veryGoodCli: veryGoodCli,
            );

            verify(
              () => logger.err('''
Running process ${exception.executable} with ${exception.arguments} failed:
${exception.message}
'''),
            ).called(1);
          },
        );

        test(
          'if an unknown error is thrown by DartCli.fix',
          () async {
            final exception = Exception('error');
            when(
              () => dartCli.fix(
                logger: logger,
                apply: true,
                cwd: any(named: 'cwd'),
              ),
            ).thenAnswer((_) => Future.error(exception));

            await post_gen.run(
              context,
              dartCli: dartCli,
              veryGoodCli: veryGoodCli,
            );

            verify(
              () => logger.err(
                '''Unknown error occurred when fixing output: $exception''',
              ),
            ).called(1);
          },
        );

        test(
          'if a $ProcessException is thrown by DartCli.format',
          () async {
            const exception = ProcessException('executable', ['arguments']);
            when(
              () => dartCli.format(
                logger: logger,
                cwd: any(named: 'cwd'),
              ),
            ).thenAnswer((_) => Future.error(exception));

            await post_gen.run(
              context,
              dartCli: dartCli,
              veryGoodCli: veryGoodCli,
            );

            verify(
              () => logger.err('''
Running process ${exception.executable} with ${exception.arguments} failed:
${exception.message}
'''),
            ).called(1);
          },
        );

        test(
          'if an unknown error is thrown by DartCli.format',
          () async {
            final exception = Exception('error');
            when(
              () => dartCli.format(
                logger: logger,
                cwd: any(named: 'cwd'),
              ),
            ).thenAnswer((_) => Future.error(exception));

            await post_gen.run(
              context,
              dartCli: dartCli,
              veryGoodCli: veryGoodCli,
            );

            verify(
              () => logger.err(
                '''Unknown error occurred when fixing output: $exception''',
              ),
            ).called(1);
          },
        );
      });
    });
  });
}

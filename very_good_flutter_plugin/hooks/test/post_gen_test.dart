import 'dart:io';

import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:very_good_flutter_plugin_hooks/src/cli/cli.dart';
import 'package:very_good_flutter_plugin_hooks/version.dart';

import '../post_gen.dart' as post_gen;

class _MockHookContext extends Mock implements HookContext {}

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

class _MockDartCli extends Mock implements DartCli {}

class _MockVeryGoodCli extends Mock implements VeryGoodCli {}

void main() {
  group('post gen', () {
    late HookContext context;
    late Logger logger;
    late Progress progress;
    late DartCli dartCli;
    late VeryGoodCli veryGoodCli;

    setUpAll(() {
      registerFallbackValue('');
    });

    setUp(() {
      context = _MockHookContext();
      logger = _MockLogger();
      progress = _MockProgress();
      dartCli = _MockDartCli();
      veryGoodCli = _MockVeryGoodCli();

      when(() => context.vars).thenReturn({});
      when(() => context.logger).thenReturn(logger);
      when(
        () => logger.progress(
          any(),
          options: any(named: 'options'),
        ),
      ).thenReturn(progress);

      when(() => context.vars).thenReturn({
        post_gen.dartFixOutputVariableKey: true,
        post_gen.projectNameVariableKey: 'project_name',
        for (final platform in $availablePlatforms) platform: true,
      });

      when(
        () => dartCli.isInstalled(logger: logger),
      ).thenAnswer((_) => Future.value(true));

      when(
        () => veryGoodCli.isInstalled(logger: logger),
      ).thenAnswer((_) => Future.value(true));

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

      when(
        () => dartCli.run(
          logger: logger,
          cwd: any(named: 'cwd'),
          args: any(named: 'args'),
          command: any(named: 'command'),
        ),
      ).thenAnswer((_) async {});
    });

    test('runs when enabled', () async {
      await post_gen.run(context, dartCli: dartCli, veryGoodCli: veryGoodCli);

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
      verify(
        () => dartCli.run(
          logger: logger,
          cwd: any(named: 'cwd'),
          args: any(named: 'args'),
          command: any(named: 'command'),
        ),
      ).called($availablePlatforms.length);
    });

    group('warns', () {
      test('if Dart CLI is not installed', () async {
        when(
          () => dartCli.isInstalled(logger: logger),
        ).thenAnswer((_) => Future.value(false));

        await post_gen.run(context, dartCli: dartCli);

        verify(
          () => logger.warn(
            'Could not fix output because Dart CLI is not installed.',
          ),
        ).called(1);
      });

      test('if Very Good CLI is not installed', () async {
        when(
          () => veryGoodCli.isInstalled(logger: logger),
        ).thenAnswer((_) => Future.value(false));

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
            () => logger.err(
              '''Running process ${exception.executable} with ${exception.arguments} failed: ${exception.message}''',
            ),
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
            () => logger.err('Unknown error occurred: $exception'),
          ).called(1);
        },
      );
    });

    group('dart fix output', () {
      test('does not run when disabled', () async {
        when(() => context.vars).thenReturn({
          post_gen.dartFixOutputVariableKey: false,
          post_gen.projectNameVariableKey: 'project_name',
          for (final platform in $availablePlatforms) platform: true,
        });

        await post_gen.run(context, veryGoodCli: veryGoodCli, dartCli: dartCli);

        verifyNever(
          () => dartCli.fix(
            logger: logger,
            apply: true,
            cwd: any(named: 'cwd'),
          ),
        );
        verifyNever(
          () => dartCli.format(
            logger: logger,
            cwd: any(named: 'cwd'),
          ),
        );
      });

      test('does not run when no key exists', () async {
        when(() => context.vars).thenReturn({
          post_gen.projectNameVariableKey: 'project_name',
          for (final platform in $availablePlatforms) platform: true,
        });

        await post_gen.run(context, veryGoodCli: veryGoodCli, dartCli: dartCli);

        verifyNever(
          () => dartCli.fix(
            logger: logger,
            apply: true,
            cwd: any(named: 'cwd'),
          ),
        );
        verifyNever(
          () => dartCli.format(
            logger: logger,
            cwd: any(named: 'cwd'),
          ),
        );
      });

      test('if a $ProcessException is thrown by DartCli.fix', () async {
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
          () => logger.err(
            '''Running process ${exception.executable} with ${exception.arguments} failed: ${exception.message}''',
          ),
        ).called(1);
      });

      test('if an unknown error is thrown by DartCli.fix', () async {
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
          () => logger.err('Unknown error occurred: $exception'),
        ).called(1);
      });

      test('if a $ProcessException is thrown by DartCli.format', () async {
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
          () => logger.err(
            '''Running process ${exception.executable} with ${exception.arguments} failed: ${exception.message}''',
          ),
        ).called(1);
      });

      test('if an unknown error is thrown by DartCli.format', () async {
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
          () => logger.err('Unknown error occurred: $exception'),
        ).called(1);
      });
    });
  });
}

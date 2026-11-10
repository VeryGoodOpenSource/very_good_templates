import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../post_gen.dart' as post_gen;

class _MockHookContext extends Mock implements HookContext;

class _MockLogger extends Mock implements Logger;

class _MockProgress extends Mock implements Progress;

void main() {
  group('post_gen', () {
    late HookContext context;
    late Logger logger;
    late Progress progress;
    late ProcessResult processResult;
    late List<Invocation> invocations;

    /// The value of the `project_name` context variable.
    const projectName = 'project_name';

    /// The value of the `executable_name` context variable.
    const executableName = 'executable-name';

    setUp(() {
      context = _MockHookContext();
      when(() => context.vars).thenReturn({
        'project_name': projectName,
        'executable_name': executableName,
      });

      logger = _MockLogger();
      when(() => context.logger).thenReturn(logger);

      progress = _MockProgress();
      when(() => logger.progress(any())).thenReturn(progress);

      processResult = ProcessResult(0, ExitCode.success.code, null, null);
      invocations = [];
    });

    Future<ProcessResult> runProcess(
      String executable,
      List<String> arguments, {
      String? workingDirectory,
      bool runInShell = false,
    }) async {
      final positionalArguments = [executable, arguments];
      final namedArguments = {
        const Symbol('workingDirectory'): workingDirectory,
        const Symbol('runInShell'): runInShell,
      };
      final invocation = Invocation.method(
        const Symbol('runProcess'),
        positionalArguments,
        namedArguments,
      );
      invocations.add(invocation);

      return processResult;
    }

    test(
      '''fixes `directives_ordering` Dart linter rule after `pub get`''',
      () async {
        await post_gen.run(context, runProcess: runProcess);

        expect(invocations[0], isDartPubGet(directory: projectName));
        expect(invocations[1], isDartDirectiveOrderingFix(path: projectName));
      },
    );

    test('makes the entrypoint executable when not on Windows', () async {
      await post_gen.run(context, runProcess: runProcess, isWindows: false);

      expect(invocations, hasLength(3));
      expect(
        invocations[2],
        isChmodExecutable(path: 'bin/executable_name.dart'),
      );
    });

    test('does not make the entrypoint executable on Windows', () async {
      await post_gen.run(context, runProcess: runProcess, isWindows: true);

      expect(invocations, hasLength(2));
      verifyNever(() => progress.update('Making entrypoint executable...'));
    });

    test('logs progress', () async {
      final pubGetCompleter = Completer<void>();
      final fixCompleter = Completer<void>();

      // Using the shortcut here as its just a test
      // ignore: prefer_function_declarations_over_variables
      final runProcess =
          (
            String executable,
            List<String> arguments, {
            String? workingDirectory,
            bool runInShell = false,
          }) async {
            switch (arguments.first) {
              case 'pub':
                await pubGetCompleter.future;
              case 'fix':
                await fixCompleter.future;
            }
            return processResult;
          };

      final postGen = post_gen.run(
        context,
        runProcess: runProcess,
        isWindows: false,
      );

      verify(() => logger.progress('Getting Dart dependencies...')).called(1);

      pubGetCompleter.complete();
      await Future<void>.delayed(Duration.zero);

      verify(() => progress.update('Fixing Dart imports ordering...'))
          .called(1);

      fixCompleter.complete();
      await Future<void>.delayed(Duration.zero);

      verify(() => progress.update('Making entrypoint executable...'))
          .called(1);
      verify(() => progress.complete('Completed post generation')).called(1);

      await postGen;
    });
  });
}

Matcher isDartDirectiveOrderingFix({required String path}) {
  return _IsDartDirectiveOrderingFix(path: path);
}

class const _IsDartDirectiveOrderingFix({
  /// The value of the path to apply the `dart fix` to.
  required final String _path,
}) extends Matcher {
  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! Invocation) {
      return false;
    }

    final invocation = item;
    final executableName = invocation.positionalArguments[0] as String;
    final arguments = invocation.positionalArguments[1] as List<String>;
    final workingDirectory =
        invocation.namedArguments[const Symbol('workingDirectory')] as String?;

    return executableName == 'dart' &&
        arguments.contains('fix') &&
        arguments.contains(_path) &&
        arguments.contains('--apply') &&
        arguments.contains('--code=directives_ordering') &&
        workingDirectory == Directory.current.path;
  }

  @override
  Description describe(Description description) {
    return description.add('is a `dart fix` for directives_ordering');
  }

  @override
  Description describeMismatch(
    dynamic item,
    Description mismatchDescription,
    Map<dynamic, dynamic> matchState,
    bool verbose,
  ) {
    return mismatchDescription.add(
      'is not a `dart fix` for directives_ordering',
    );
  }
}

Matcher isChmodExecutable({required String path}) {
  return _IsChmodExecutable(path: path);
}

class const _IsChmodExecutable({
  /// The path of the file to make executable.
  required final String _path,
}) extends Matcher {
  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! Invocation) {
      return false;
    }

    final invocation = item;
    final executableName = invocation.positionalArguments[0] as String;
    final arguments = invocation.positionalArguments[1] as List<String>;
    final workingDirectory =
        invocation.namedArguments[const Symbol('workingDirectory')] as String?;

    return executableName == 'chmod' &&
        arguments.length == 2 &&
        arguments[0] == '+x' &&
        arguments[1] == _path &&
        workingDirectory == Directory.current.path;
  }

  @override
  Description describe(Description description) {
    return description.add('is a `chmod +x $_path`');
  }

  @override
  Description describeMismatch(
    dynamic item,
    Description mismatchDescription,
    Map<dynamic, dynamic> matchState,
    bool verbose,
  ) {
    return mismatchDescription.add('is not a `chmod +x $_path`');
  }
}

Matcher isDartPubGet({required String directory}) {
  return _IsDartPubGet(directory: directory);
}

class const _IsDartPubGet({
  /// The value of the `--directory` argument passed to `dart pub get`.
  required final String _directory,
}) extends Matcher {
  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! Invocation) {
      return false;
    }

    final invocation = item;
    final executableName = invocation.positionalArguments[0] as String;
    final arguments = invocation.positionalArguments[1] as List<String>;
    final workingDirectory =
        invocation.namedArguments[const Symbol('workingDirectory')] as String?;

    return executableName == 'dart' &&
        arguments.contains('pub') &&
        arguments.contains('get') &&
        arguments.contains('--directory=$_directory') &&
        workingDirectory == Directory.current.path;
  }

  @override
  Description describe(Description description) {
    return description.add('is a `dart pub get --directory=$_directory`');
  }

  @override
  Description describeMismatch(
    dynamic item,
    Description mismatchDescription,
    Map<dynamic, dynamic> matchState,
    bool verbose,
  ) {
    return mismatchDescription.add(
      'is not a `dart pub get --directory=$_directory`',
    );
  }
}

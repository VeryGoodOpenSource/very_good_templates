import 'dart:async';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../post_gen.dart' as post_gen;

class _MockHookContext extends Mock implements HookContext {}

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

void main() {
  group('post_gen', () {
    late HookContext context;
    late Logger logger;
    late Progress progress;
    late ProcessResult processResult;
    late List<Invocation> invocations;

    /// The value of the `project_name` context variable.
    const projectName = 'project_name';

    setUp(() {
      context = _MockHookContext();
      when(() => context.vars).thenReturn({'project_name': projectName});

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

    test('logs progress', () async {
      final pubGetCompleter = Completer<void>();
      final fixCompleter = Completer<void>();

      // Using the shortcut here as its just a test
      // ignore: prefer_function_declarations_over_variables
      final runProcess = (
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

      final postGen = post_gen.run(context, runProcess: runProcess);

      verify(() => logger.progress('Getting Dart dependencies...')).called(1);

      pubGetCompleter.complete();
      await Future<void>.delayed(Duration.zero);

      verify(
        () => progress.update('Fixing Dart imports ordering...'),
      ).called(1);

      fixCompleter.complete();
      await Future<void>.delayed(Duration.zero);

      verify(() => progress.complete('Completed post generation')).called(1);

      await postGen;
    });
  });
}

Matcher isDartDirectiveOrderingFix({required String path}) {
  return _IsDartDirectiveOrderingFix(path: path);
}

class _IsDartDirectiveOrderingFix extends Matcher {
  const _IsDartDirectiveOrderingFix({required String path}) : _path = path;

  /// The value of the path to apply the `dart fix` to.
  final String _path;

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

Matcher isDartPubGet({required String directory}) {
  return _IsDartPubGet(directory: directory);
}

class _IsDartPubGet extends Matcher {
  const _IsDartPubGet({required String directory}) : _directory = directory;

  /// The value of the `--directory` argument passed to `dart pub get`.
  final String _directory;

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

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
      '''fixes `directives_ordering` Dart linter rule and formats after `very_good packages get`''',
      () async {
        await post_gen.run(context, runProcess: runProcess);

        expect(invocations[0], isVeryGoodPackagesGet(directory: projectName));
        expect(invocations[1], isDartDirectiveOrderingFix(path: projectName));
        expect(invocations[2], isDartFormat(path: projectName));
      },
    );

    test('logs progress', () async {
      final packagesGetCompleter = Completer<void>();
      final fixCompleter = Completer<void>();
      final formatCompleter = Completer<void>();

      Future<ProcessResult> runProcess(
        String executable,
        List<String> arguments, {
        String? workingDirectory,
        bool runInShell = false,
      }) async {
        switch (arguments.first) {
          case 'packages':
            await packagesGetCompleter.future;
          case 'fix':
            await fixCompleter.future;
          case 'format':
            await formatCompleter.future;
        }
        return processResult;
      }

      final postGen = post_gen.run(context, runProcess: runProcess);

      verify(() => logger.progress('Getting Dart dependencies...')).called(1);

      packagesGetCompleter.complete();
      await Future<void>.delayed(Duration.zero);

      verify(
        () => progress.update('Fixing Dart imports ordering...'),
      ).called(1);

      fixCompleter.complete();
      await Future<void>.delayed(Duration.zero);

      verify(() => progress.update('Fixing formatting...')).called(1);

      formatCompleter.complete();
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

Matcher isVeryGoodPackagesGet({required String directory}) {
  return _IsVeryGoodPackagesGet(directory: directory);
}

class _IsVeryGoodPackagesGet extends Matcher {
  const _IsVeryGoodPackagesGet({required String directory})
    : _directory = directory;

  /// The value of the directory argument passed to `very_good packages get`.
  final String _directory;

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! Invocation) return false;

    final invocation = item;
    final executableName = invocation.positionalArguments.first as String;
    final arguments = invocation.positionalArguments.last as List<String>;
    final workingDirectory =
        invocation.namedArguments[const Symbol('workingDirectory')] as String?;

    return executableName == 'very_good' &&
        arguments.contains('packages') &&
        arguments.contains('get') &&
        arguments.contains(_directory) &&
        workingDirectory == Directory.current.path;
  }

  @override
  Description describe(Description description) {
    return description.add('is a `very_good packages get $_directory`');
  }

  @override
  Description describeMismatch(
    dynamic item,
    Description mismatchDescription,
    Map<dynamic, dynamic> matchState,
    bool verbose,
  ) {
    return mismatchDescription.add(
      'is not a `very_good packages get $_directory`',
    );
  }
}

Matcher isDartFormat({required String path}) {
  return _IsDartFormat(path: path);
}

class _IsDartFormat extends Matcher {
  const _IsDartFormat({required String path}) : _path = path;

  /// The value of the path to apply the `dart format` to.
  final String _path;

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! Invocation) return false;

    final invocation = item;
    final executableName = invocation.positionalArguments.first as String;
    final arguments = invocation.positionalArguments.last as List<String>;
    final workingDirectory =
        invocation.namedArguments[const Symbol('workingDirectory')] as String?;

    return executableName == 'dart' &&
        arguments.contains('format') &&
        arguments.contains('--set-exit-if-changed') &&
        arguments.contains(_path) &&
        workingDirectory == Directory.current.path;
  }

  @override
  Description describe(Description description) {
    return description.add('is a `dart format --set-exit-if-changed $_path`');
  }

  @override
  Description describeMismatch(
    dynamic item,
    Description mismatchDescription,
    Map<dynamic, dynamic> matchState,
    bool verbose,
  ) {
    return mismatchDescription.add(
      'is not a `dart format --set-exit-if-changed $_path`',
    );
  }
}

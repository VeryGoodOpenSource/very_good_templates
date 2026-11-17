import 'dart:io';

import 'package:mason/mason.dart';
import 'package:meta/meta.dart';

/// Type definition for [Process.run].
typedef RunProcess = Future<ProcessResult> Function(
  String executable,
  List<String> arguments, {
  String? workingDirectory,
  bool runInShell,
});

Future<void> run(
  HookContext context, {
  @visibleForTesting RunProcess runProcess = Process.run,
  @visibleForTesting bool? isWindows,
}) async {
  final executableName = (context.vars['executable_name'] as String).snakeCase;

  final progress = context.logger.progress('Getting Dart dependencies...');

  // Mason runs this hook with the generated project root as the working
  // directory and the brick writes its files directly there, with no
  // `<project_name>/` subfolder, so every command targets the current
  // directory.

  // We have to `pub get` the generated project to ensure that the analysis
  // is able to fix the imports with the correct analysis options.
  await _runOrFail(context, progress, runProcess, const [
    'pub',
    'get',
    '--directory=.',
  ]);

  progress.update('Fixing Dart imports ordering...');

  // Some imports are relative to the user specified package name, hence
  // we try to fix the import directive ordering after the template has
  // been generated.
  //
  // We only fix for the [directives_ordering](https://dart.dev/tools/linter-rules/directives_ordering)
  // linter rules, as the other rule should be tackled by the template itself.
  await _runOrFail(context, progress, runProcess, const [
    'fix',
    '.',
    '--apply',
    '--code=directives_ordering',
  ]);

  // Mason does not preserve file permissions, so the entrypoint is made
  // executable to allow running it directly through its shebang.
  if (!(isWindows ?? Platform.isWindows)) {
    progress.update('Making entrypoint executable...');

    await runProcess('chmod', [
      '+x',
      'bin/$executableName.dart',
    ], workingDirectory: Directory.current.path);
  }

  progress.complete('Completed post generation');
}

/// Runs `dart` with the given [arguments] in the current directory, surfacing
/// a non-zero exit code by failing the [progress] and throwing a
/// [ProcessException] instead of silently ignoring the failure.
Future<void> _runOrFail(
  HookContext context,
  Progress progress,
  RunProcess runProcess,
  List<String> arguments,
) async {
  final result = await runProcess(
    'dart',
    arguments,
    workingDirectory: Directory.current.path,
  );

  if (result.exitCode != ExitCode.success.code) {
    progress.fail();
    context.logger.err('${result.stderr}');
    throw ProcessException(
      'dart',
      arguments,
      '${result.stderr}',
      result.exitCode,
    );
  }
}

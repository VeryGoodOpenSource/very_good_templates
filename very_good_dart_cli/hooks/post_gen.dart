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
}) async {
  final projectName = context.vars['project_name'] as String;

  final progress = context.logger.progress('Getting Dart dependencies...');

  // We have to `pub get` the generated project to ensure that the analysis
  // is able to fix the imports with the correct analysis options.
  await runProcess(
    'dart',
    [
      'pub',
      'get',
      '--directory=$projectName',
    ],
    workingDirectory: Directory.current.path,
  );

  progress.update('Fixing Dart imports ordering...');

  // Some imports are relative to the user specified package name, hence
  // we try to fix the import directive ordering after the template has
  // been generated.
  //
  // We only fix for the [directives_ordering](https://dart.dev/tools/linter-rules/directives_ordering)
  // linter rules, as the other rule should be tackled by the template itself.
  await runProcess(
    'dart',
    [
      'fix',
      projectName,
      '--apply',
      '--code=directives_ordering',
    ],
    workingDirectory: Directory.current.path,
  );

  progress.complete('Completed post generation');
}

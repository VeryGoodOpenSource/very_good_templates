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

/// The key for the `dartFixOutput` context variable.
@visibleForTesting
const dartFixOutputVariableKey = 'dart_fix_output';

/// The key for the `projectName` context variable.
@visibleForTesting
const projectNameOutputVariableKey = 'project_name';

/// The key for the `platforms` context variable.
@visibleForTesting
const platformsOutputVariableKey = 'platforms';

Future<void> run(
  HookContext context, {
  @visibleForTesting RunProcess runProcess = Process.run,
}) async {
  final dartFixOutput = context.vars.containsKey(dartFixOutputVariableKey) &&
      context.vars[dartFixOutputVariableKey] as bool;

  if (!dartFixOutput) return;

  final projectName = context.vars[projectNameOutputVariableKey] as String;
  final platforms = context.vars[platformsOutputVariableKey] as String;
  final selectedPlatforms = platforms.split(',')..forEach((e) => e.trim());
  final workingDirectory = Directory.current.path;

  final progress = context.logger.progress('Getting dependencies...');

  // We have to `very_good packages get` the generated project
  // to ensure that the analysis is able to fix the imports
  // with the correct analysis options.
  await runProcess(
    'very_good',
    ['packages', 'get', '--recursive', projectName],
    workingDirectory: workingDirectory,
  );

  progress.complete('Got dependencies!');

  await _dartFixAndFormatOutput(
    logger: context.logger,
    runProcess: runProcess,
    projectName: '$projectName/$projectName',
    workingDirectory: workingDirectory,
  );

  for (final platform in selectedPlatforms) {
    final platformProjectName = '$projectName/${projectName}_$platform';
    await _dartFixAndFormatOutput(
      logger: context.logger,
      runProcess: runProcess,
      projectName: platformProjectName,
      workingDirectory: workingDirectory,
    );
  }
}

/// Attempts to `dart` fix and format the output.
///
/// Since the template includes Dart files with templated variables, generating
/// the template can cause the generated Dart files to be invalid. For example,
/// if the user inputs a long enough package name, the generated Dart files may
/// exceed the 80 character line limit enforced by the the Dart formatter.
/// Running `dart fix` and `dart format` on the generated output ensures that
/// the generated output is always valid.
///
/// Before we can run `dart fix` and `dart format`, we need to ensure that the
/// dependencies are installed. Doing so allows getting remote analysis options
/// and allows the Dart code to resolve the imports.
Future<void> _dartFixAndFormatOutput({
  required Logger logger,
  required String projectName,
  required String workingDirectory,
  RunProcess runProcess = Process.run,
}) async {
  try {
    final progress = logger.progress(
      'Fixing Dart imports ordering in $projectName...',
    );

    // Some imports are relative to the user specified package name, hence
    // we try to fix the import directive ordering after the template has
    // been generated.
    //
    // We only fix for the [directives_ordering](https://dart.dev/tools/linter-rules/directives_ordering)
    // linter rules, as the other rule should be tackled by the template itself.
    await runProcess(
      'dart',
      ['fix', projectName, '--apply', '--code=directives_ordering'],
      workingDirectory: workingDirectory,
    );

    progress.update('Fixing formatting in $projectName...');

    await runProcess(
      'dart',
      ['format', '--set-exit-if-changed', projectName],
      workingDirectory: workingDirectory,
    );

    progress.complete('Fixed and formatted $projectName!');
  } on ProcessException catch (e) {
    logger.err(
      '''Running process ${e.executable} with ${e.arguments} failed: ${e.message}''',
    );
  } on Exception catch (e) {
    logger.err('Unknown error occurred when fixing output: $e');
  }
}

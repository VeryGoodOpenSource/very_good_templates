import 'dart:io';

import 'package:mason/mason.dart';
import 'package:meta/meta.dart';
import 'package:very_good_flutter_plugin_hooks/src/cli/cli.dart';
import 'package:very_good_flutter_plugin_hooks/version.dart';

/// The key for the `projectName` context variable.
@visibleForTesting
const projectNameVariableKey = 'project_name';

/// The key for the `dartFixOutput` context variable.
@visibleForTesting
const dartFixOutputVariableKey = 'dart_fix_output';

Future<void> run(
  HookContext context, {
  @visibleForTesting DartCli dartCli = DartCli.instance,
  @visibleForTesting VeryGoodCli veryGoodCli = VeryGoodCli.instance,
}) async {
  final logger = context.logger;

  if (!await dartCli.isInstalled(logger: logger)) {
    return logger.warn(
      '''Could not fix output because Dart CLI is not installed.''',
    );
  }

  if (!await veryGoodCli.isInstalled(logger: logger)) {
    return logger.warn(
      '''Could not fix output because Very Good CLI is not installed.''',
    );
  }

  final progress = logger.progress('Getting dependencies 📦');

  await veryGoodCli.packagesGet(
    logger: logger,
    recursive: true,
    cwd: Directory.current.path,
  );

  final projectName = context.vars[projectNameVariableKey] as String;
  final directories = $availablePlatforms
      .where((platform) => context.vars[platform] as bool)
      .map((platform) => '${Directory.current.path}/${projectName}_$platform');

  progress.update('Generating Pigeon bindings 🦾');

  await Future.wait(
    directories.map(
      (directory) => dartCli.run(
        cwd: directory,
        logger: logger,
        command: 'pigeon',
        args: ['--input', 'pigeons/messages.dart'],
      ),
    ),
  );

  final dartFixOutput =
      context.vars.containsKey(dartFixOutputVariableKey) &&
      context.vars[dartFixOutputVariableKey] as bool;

  if (dartFixOutput) {
    progress.update('Fixing Dart imports ordering 🔨');
    await _dartFixOutput(
      logger: logger,
      dartCli: dartCli,
      veryGoodCli: veryGoodCli,
      workingDirectory: Directory.current.path,
    );
  }

  progress.complete('Completed post generation ✅');
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
///
/// If the [DartCli] or [VeryGoodCli] is not installed, this function will log
/// a warning and return immediately.
Future<void> _dartFixOutput({
  required Logger logger,
  required DartCli dartCli,
  required VeryGoodCli veryGoodCli,
  required String workingDirectory,
}) async {
  try {
    await dartCli.fix(logger: logger, cwd: workingDirectory, apply: true);
    await dartCli.format(logger: logger, cwd: workingDirectory);
  } on ProcessException catch (e) {
    logger.err(
      '''Running process ${e.executable} with ${e.arguments} failed: ${e.message}''',
    );
  } on Exception catch (e) {
    logger.err('Unknown error occurred when fixing output: $e');
  }
}

import 'dart:async';
import 'dart:io';
import 'package:mason/mason.dart';
import 'package:meta/meta.dart';

/// [Process.run] function signature.
typedef RunProcess =
    Future<ProcessResult> Function(
      String executable,
      List<String> arguments, {
      String? workingDirectory,
      bool runInShell,
    });

/// Starts a process and runs it non-interactively to completion.
///
/// Used for overriding the default [Process.run] implementation
/// during testing.
@visibleForTesting
RunProcess? runProcess;

/// Abstraction for running commands via command-line.
abstract class CommandLine {
  /// Runs the specified [cmd] with the provided [args].
  ///
  /// Throws a [ProcessException] if the process fails.
  static Future<ProcessResult> run(
    String cmd,
    List<String> args, {
    required Logger logger,
    bool throwOnError = true,
    String? workingDirectory,
  }) async {
    logger.detail('Running: $cmd with $args');
    final runner = runProcess ?? Process.run;
    final result = await runner(
      cmd,
      args,
      workingDirectory: workingDirectory,
      runInShell: true,
    );
    logger
      ..detail('stdout:\n${result.stdout}')
      ..detail('stderr:\n${result.stderr}');

    if (throwOnError) {
      _throwIfProcessFailed(result, cmd, args);
    }
    return result;
  }

  static void _throwIfProcessFailed(
    ProcessResult pr,
    String process,
    List<String> args,
  ) {
    if (pr.exitCode != 0) {
      final values = {
        'Standard out': pr.stdout.toString().trim(),
        'Standard error': pr.stderr.toString().trim(),
      }..removeWhere((k, v) => v.isEmpty);

      var message = 'Unknown error';
      if (values.isNotEmpty) {
        message = values.entries.map((e) => '${e.key}:\n${e.value}').join('\n');
      }

      throw ProcessException(process, args, message, pr.exitCode);
    }
  }
}

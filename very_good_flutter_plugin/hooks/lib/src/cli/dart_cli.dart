import 'package:mason/mason.dart';
import 'package:very_good_flutter_plugin_hooks/src/cli/cli.dart';

/// A wrapper around the Dart Command Line Interface (CLI).
///
/// The Dart CLI is part of the Dart SDK.
///
/// See also:
///
/// * [The Dart command-line tool documentation](https://dart.dev/tools/dart-tool)
/// * [The Dart command-line source code](https://github.com/dart-lang/sdk/tree/main/pkg/dartdev)
class DartCli {
  const DartCli._();

  /// A singleton instance of [DartCli].
  static const instance = DartCli._();

  static const _executableName = 'dart';

  /// Determine whether dart is installed.
  Future<bool> isInstalled({required Logger logger}) async {
    try {
      await CommandLine.run(
        _executableName,
        ['--version'],
        logger: logger,
      );
      return true;
    } on Exception {
      return false;
    }
  }

  /// Idiomatically format Dart source code.
  Future<void> format({
    required Logger logger,
    String cwd = '.',
  }) async {
    await CommandLine.run(
      _executableName,
      ['format'],
      workingDirectory: cwd,
      logger: logger,
    );
  }

  /// Apply automated fixes to Dart source code.
  ///
  /// Enabling [apply] applies the proposed changes.
  Future<void> fix({
    required Logger logger,
    bool apply = false,
    String cwd = '.',
  }) async {
    await CommandLine.run(
      _executableName,
      ['fix', if (apply) '--apply'],
      workingDirectory: cwd,
      logger: logger,
    );
  }
}

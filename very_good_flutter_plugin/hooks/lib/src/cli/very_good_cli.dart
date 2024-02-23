import 'package:mason/mason.dart';
import 'package:very_good_flutter_plugin_hooks/src/cli/cli.dart';

/// A wrapper around the Very Good Command Line Interface (CLI).
///
/// See also:
///
/// * [The Very Good CLI documentation](https://cli.vgv.dev/)
class VeryGoodCli {
  const VeryGoodCli._();

  /// A singleton instance of [VeryGoodCli].
  static const instance = VeryGoodCli._();

  static const _executableName = 'very_good';

  /// Determine whether dart is installed.
  Future<bool> isInstalled({required Logger logger}) async {
    try {
      await CommandLine.run(
        _executableName,
        ['--version'],
        logger: logger,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Get packages in a Dart or Flutter project.
  ///
  /// Enabling [recursive] installs dependencies recursively for all nested
  /// packages.
  Future<void> packagesGet({
    required Logger logger,
    String cwd = '.',
    bool recursive = false,
  }) async {
    await CommandLine.run(
      _executableName,
      ['packages', 'get', if (recursive) '--recursive'],
      workingDirectory: cwd,
      logger: logger,
    );
  }
}

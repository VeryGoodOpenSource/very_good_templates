import 'dart:io';

import 'package:args/args.dart';
import 'package:dependency_tightener/dependency_tightener.dart';
import 'package:pub_updater/pub_updater.dart';

/// Tightens the dependencies in all `pubspec.yaml` files in the given
/// directory.
///
/// For a more comprehensive documentation, read the `README.md`.
///
/// See also:
///
/// * [tightenDependencies], which tightens the dependencies in a single
/// `pubspec.yaml` file.
Future<void> main(List<String> args) async {
  final argumentParser = ArgParser()
    ..addOption(
      'directory',
      help: 'The directory to search for `pubspec.yaml` files.',
      defaultsTo: Directory.current.path,
    )
    ..addOption(
      'skip-packages',
      help: 'A comma-separated list of additional package names to skip '
          'version tightening. Note: Pinned packages '
          '(${pinnedPackageNames.join(', ')}) are always skipped by default.',
    )
    ..addFlag(
      'include-pinned',
      help: 'Include pinned packages in version tightening (not recommended).',
      negatable: false,
    );
  final arguments = argumentParser.parse(args);

  final targetDirectory = Directory(arguments['directory'] as String);
  final includePinned = arguments['include-pinned'] as bool;

  final skipPackages = <String>{};
  if (!includePinned) {
    skipPackages.addAll(pinnedPackageNames);
  }

  final additionalSkipPackages = arguments['skip-packages'] as String?;
  if (additionalSkipPackages != null) {
    skipPackages.addAll(additionalSkipPackages.split(','));
  }

  final pubspecFiles = targetDirectory
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('pubspec.yaml'))
      .toList();

  final pubUpdater = PubUpdater();
  for (final pubspec in pubspecFiles) {
    await tightenDependencies(
      pubspec,
      skipPackages: skipPackages.isEmpty ? null : skipPackages,
      pubUpdater: pubUpdater,
    );
  }
}

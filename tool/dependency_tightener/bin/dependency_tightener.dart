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
      defaultsTo: Directory.current.path,
    );
  final arguments = argumentParser.parse(args);

  final targetDirectory = Directory(arguments['directory'] as String);

  final pubspecFiles = targetDirectory
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('pubspec.yaml'))
      .toList();

  final pubUpdater = PubUpdater();
  for (final pubspec in pubspecFiles) {
    await tightenDependencies(
      pubspec,
      pubUpdater: pubUpdater,
    );
  }
}

import 'dart:io';

import 'package:args/args.dart';
import 'package:dependency_tightener/src/pubspec_parse.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pub_updater/pub_updater.dart';

export 'src/dependency_tightener.dart';

final _argumentParser = ArgParser()
  ..addOption(
    'directory',
    defaultsTo: Directory.current.path,
  );

final _pubUpdater = PubUpdater();

Future<void> main(
  List<String> args, {
  void Function(Object? object) log = print,
}) async {
  final arguments = _argumentParser.parse(args);

  final targetDirectory = Directory(arguments['directory'] as String);

  final pubspecFiles = targetDirectory
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('pubspec.yaml'))
      .toList();

  for (final pubspec in pubspecFiles) {
    final pubspecContent = pubspec.readAsStringSync();
    final dependencies = parseDirectHostedDependencies(pubspecContent);

    for (final dependency in dependencies) {
      final name = dependency.hosted!.name;
      final versionConstraint = dependency.version;

      late Version minVersion;

      if (versionConstraint is VersionRange && versionConstraint.min != null) {
        minVersion = versionConstraint.min!;
      } else if (versionConstraint is Version) {
        minVersion = versionConstraint;
      } else {
        // If the version constraint is not a Version or VersionRange, skip it,
        // since we can't determine the minimum version.
        continue;
      }

      final isUpToDate = await _pubUpdater.isUpToDate(
        packageName: name,
        currentVersion: minVersion.toString(),
      );

      if (!isUpToDate) {
        final rawLatestVersion = await _pubUpdater.getLatestVersion(
          dependency.hosted!.name,
        );

        final isPinned = versionConstraint is! VersionRange ||
            (versionConstraint.min == versionConstraint.max);

        final newVersionConstraint =
            isPinned ? rawLatestVersion : '^$rawLatestVersion';

        final newPubspecContent = pubspecContent.replaceAll(
          '$name: $versionConstraint',
          '$name: $newVersionConstraint',
        );

        pubspec.writeAsStringSync(newPubspecContent);
        log('Updated $name to $newVersionConstraint in ${pubspec.path}');
      }
    }
  }
}

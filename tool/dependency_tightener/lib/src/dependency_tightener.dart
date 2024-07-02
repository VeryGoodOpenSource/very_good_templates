import 'dart:io';

import 'package:dependency_tightener/src/graceful_pubspec_parse.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pub_updater/pub_updater.dart';

/// Tightens the dependencies in the given [pubspec] file.
///
/// It will only consider direct hosted dependencies.
///
/// It parses the [pubspec] file gracefully, by using
/// [parseDirectHostedDependencies].
///
/// It will replace the previous versions, of those not up-to-date direct hosted
/// dependencies with a version constraint range that is tightened to the latest
/// version. It will always use the [caret syntax](https://dart.dev/tools/pub/dependencies#caret-syntax),
/// even if the previous version was pinned.
///
/// If you wish to skip tightening the version of certain packages, you can
/// provide the name of those packages in [skipPackages].
///
/// See also:
///
/// * [parseDirectHostedDependencies], which parses the direct hosted
/// dependencies from a provided YAML string, that might have mustache
/// variables.
/// * [Caret syntax documentation](https://dart.dev/tools/pub/dependencies#caret-syntax)
Future<void> tightenDependencies(
  File pubspec, {
  required PubUpdater pubUpdater,
  Set<String>? skipPackages,
  void Function(Object? object) log = print,
}) async {
  final pubspecContent = pubspec.readAsStringSync();
  var newPubspecContent = pubspecContent;

  final dependencies = parseDirectHostedDependencies(newPubspecContent);

  for (final dependency in dependencies) {
    final name = dependency.hosted!.name;
    final versionConstraint = dependency.version;

    if (skipPackages != null && skipPackages.contains(name)) {
      continue;
    }

    late Version minVersion;

    if (versionConstraint is VersionRange && versionConstraint.min != null) {
      minVersion = versionConstraint.min!;
    } else {
      // If the version constraint doesn't have a min version, skip it, since we
      // can't determine the minimum version.
      continue;
    }

    final isUpToDate = await pubUpdater.isUpToDate(
      packageName: name,
      currentVersion: minVersion.toString(),
    );

    if (!isUpToDate) {
      final rawLatestVersion = await pubUpdater.getLatestVersion(
        dependency.hosted!.name,
      );
      final newVersionConstraint = '^$rawLatestVersion';

      newPubspecContent = newPubspecContent.replaceAll(
        '$name: $versionConstraint',
        '$name: $newVersionConstraint',
      );

      log('Updated $name to $newVersionConstraint in ${pubspec.path}');
    }
  }

  if (newPubspecContent != pubspecContent) {
    pubspec.writeAsStringSync(newPubspecContent);
  }
}

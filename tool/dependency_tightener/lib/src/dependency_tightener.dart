import 'dart:io';

import 'package:dependency_tightener/src/graceful_pubspec_parse.dart';
import 'package:dependency_tightener/src/pubspec_resolver.dart';
import 'package:dependency_tightener/src/sdk_pinned_config.dart';
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
/// If [autoDetectSdkPinned] is `true` (the default), packages that are pinned
/// by SDK dependencies (like `intl` being pinned by `flutter_localizations`)
/// will be automatically detected and skipped.
///
/// If a [resolver] is provided, tightened constraints that would make the
/// dependencies fail to resolve are skipped. When the dependencies don't
/// resolve before tightening, no constraint is tightened, since the conflicts
/// can't be attributed to a specific update.
///
/// See also:
///
/// * [parseDirectHostedDependencies], which parses the direct hosted
/// dependencies from a provided YAML string, that might have mustache
/// variables.
/// * [getAutoSkipPackages], which detects SDK-pinned packages.
/// * [PubspecResolver], which checks whether the dependencies resolve.
/// * [Caret syntax documentation](https://dart.dev/tools/pub/dependencies#caret-syntax)
Future<void> tightenDependencies(
  File pubspec, {
  required PubUpdater pubUpdater,
  Set<String>? skipPackages,
  bool autoDetectSdkPinned = true,
  PubspecResolver? resolver,
  void Function(Object? object) log = print,
}) async {
  final pubspecContent = pubspec.readAsStringSync();

  // Combine manually specified skip packages with auto-detected SDK-pinned
  final effectiveSkipPackages = <String>{
    ...?skipPackages,
    if (autoDetectSdkPinned) ...getAutoSkipPackages(pubspecContent),
  };

  if (effectiveSkipPackages.isNotEmpty) {
    log('Skipping packages: $effectiveSkipPackages');
  }

  final dependencies = parseDirectHostedDependencies(pubspecContent);
  final updates = <_DependencyUpdate>[];

  for (final dependency in dependencies) {
    final name = dependency.hosted!.name;
    final versionConstraint = dependency.version;

    if (effectiveSkipPackages.contains(name)) {
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
      updates.add(
        _DependencyUpdate(
          name: name,
          previousConstraint: '$versionConstraint',
          newConstraint: '^$rawLatestVersion',
        ),
      );
    }
  }

  if (updates.isEmpty) return;

  var newPubspecContent = updates.fold(
    pubspecContent,
    (content, update) => update.applyTo(content),
  );
  var appliedUpdates = updates;

  if (resolver != null && !await resolver.canResolve(newPubspecContent)) {
    if (!await resolver.canResolve(pubspecContent)) {
      log(
        'Skipped tightening ${pubspec.path}, its dependencies do not resolve '
        'before tightening',
      );
      return;
    }

    // Apply the updates one at a time, keeping only those that still resolve.
    newPubspecContent = pubspecContent;
    appliedUpdates = [];
    for (final update in updates) {
      final candidateContent = update.applyTo(newPubspecContent);
      if (await resolver.canResolve(candidateContent)) {
        newPubspecContent = candidateContent;
        appliedUpdates.add(update);
      } else {
        log(
          'Skipped updating ${update.name} to ${update.newConstraint} in '
          '${pubspec.path}, its dependencies would not resolve',
        );
      }
    }
  }

  for (final update in appliedUpdates) {
    log('Updated ${update.name} to ${update.newConstraint} in ${pubspec.path}');
  }

  if (newPubspecContent != pubspecContent) {
    pubspec.writeAsStringSync(newPubspecContent);
  }
}

class _DependencyUpdate {
  const new({
    required this.name,
    required this.previousConstraint,
    required this.newConstraint,
  });

  final String name;
  final String previousConstraint;
  final String newConstraint;

  String applyTo(String pubspecContent) {
    return pubspecContent.replaceAll(
      '$name: $previousConstraint',
      '$name: $newConstraint',
    );
  }
}

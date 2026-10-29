/// Provides utilities to check whether a templated `pubspec.yaml` resolves.
library;

import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

/// Signature for [Process.run].
typedef ProcessRunner = Future<ProcessResult> Function(
  String executable,
  List<String> arguments, {
  String? workingDirectory,
});

/// Checks whether the dependencies of a templated `pubspec.yaml` resolve.
///
/// Since templated `pubspec.yaml` files can't be resolved directly, a
/// resolvable copy is built with [buildResolvablePubspec] and resolved with
/// `pub get` in a temporary directory.
///
/// A full `pub get` is used rather than `pub get --dry-run`, since
/// `flutter pub get --dry-run` exits with an error even when the dependencies
/// resolve.
class PubspecResolver {
  /// Creates a new [PubspecResolver].
  new({ProcessRunner? runProcess, Directory Function()? createTempDirectory})
    : _runProcess = runProcess ?? Process.run,
      _createTempDirectory =
          createTempDirectory ??
          (() => Directory.systemTemp.createTempSync('dependency_tightener'));

  final ProcessRunner _runProcess;
  final Directory Function() _createTempDirectory;

  /// Whether the dependencies in [pubspecContent] resolve.
  ///
  /// Uses `flutter pub get` when the pubspec depends on the Flutter SDK, and
  /// `dart pub get` otherwise.
  Future<bool> canResolve(String pubspecContent) async {
    final pubspec = buildResolvablePubspec(pubspecContent);
    final directory = _createTempDirectory();
    try {
      File('${directory.path}/pubspec.yaml')
          .writeAsStringSync(jsonEncode(pubspec));

      final result = await _runProcess(
        dependsOnFlutter(pubspec) ? 'flutter' : 'dart',
        ['pub', 'get'],
        workingDirectory: directory.path,
      );
      return result.exitCode == 0;
    } finally {
      directory.deleteSync(recursive: true);
    }
  }
}

/// Builds a resolvable pubspec from the provided templated [yaml].
///
/// Only the direct hosted and SDK dependencies are kept, since other
/// dependencies (like path dependencies) usually point to templated
/// locations that don't exist.
///
/// The returned map is JSON encodable, and since JSON is valid YAML, it can
/// be written as a `pubspec.yaml`.
Map<String, Object?> buildResolvablePubspec(String yaml) {
  final cleanedYaml = yaml.replaceAll(RegExp(r'\{{2,3}[^{}]+\}{2,3}'), '');
  final yamlTree = loadYaml(cleanedYaml);

  Map<String, Object?> resolvableDependencies(Object? node) {
    final dependencies = <String, Object?>{};
    if (node is! YamlMap) return dependencies;

    for (final MapEntry(:key, :value) in node.entries) {
      if (key is! String) continue;
      if (value is String) {
        dependencies[key] = value;
      } else if (value is YamlMap && value['sdk'] is String) {
        dependencies[key] = {'sdk': value['sdk']};
      }
    }
    return dependencies;
  }

  return {
    'name': 'dependency_tightener_check',
    'publish_to': 'none',
    'environment': {'sdk': '^3.0.0'},
    'dependencies': resolvableDependencies(
      yamlTree is YamlMap ? yamlTree['dependencies'] : null,
    ),
    'dev_dependencies': resolvableDependencies(
      yamlTree is YamlMap ? yamlTree['dev_dependencies'] : null,
    ),
  };
}

/// Whether the resolvable [pubspec] depends on the Flutter SDK.
///
/// See also:
///
/// * [buildResolvablePubspec], which builds the resolvable pubspec.
bool dependsOnFlutter(Map<String, Object?> pubspec) {
  return [pubspec['dependencies'], pubspec['dev_dependencies']]
      .whereType<Map<String, Object?>>()
      .expand((dependencies) => dependencies.values)
      .any((value) => value is Map && value['sdk'] == 'flutter');
}

import 'package:pub_semver/pub_semver.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:yaml/yaml.dart';

/// Parses the direct hosted dependencies from the provided [yaml].
///
/// The provided yaml may contain templated mustache variables. It gracefully,
/// ignores those unlike [Pubspec.parse].
///
/// For example:
/// ```yaml
/// name: {{project_name.snakeCase()}}
/// description: A very good {{project_name.snakeCase()}} plugin.
/// version: 0.1.0+1
/// {{^publishable}}publish_to: none{{/publishable}}
///
/// environment:
///   sdk: {{{dartSdkVersionBounds}}}
///
/// dependencies:
///   flutter:
///     sdk: flutter
///   plugin_platform_interface: ^2.1.0
///
/// dev_dependencies:
///   flutter_test:
///     sdk: flutter
///   very_good_analysis: ^5.1.0
/// ```
///
/// Would report the `plugin_platform_interface` and `very_good_analysis` as
/// direct hosted dependencies.
Set<HostedDependency> parseDirectHostedDependencies(String yaml) {
  final cleanedYaml = yaml.replaceAll(RegExp(r'\{{2,3}[^{}]+\}{2,3}'), '');
  final yamlTree = loadYaml(cleanedYaml);
  if (yamlTree is! YamlMap) return {};

  final dependencies = <HostedDependency>{};

  void addDependencies(YamlMap dependencyYamlMap) {
    for (final entry in dependencyYamlMap.entries) {
      final key = entry.key;
      final value = entry.value;
      if (key is! String || value is! String) continue;

      final versionConstraint = VersionConstraint.parse(value);
      dependencies.add(
        HostedDependency(
          version: versionConstraint,
          hosted: HostedDetails(key, null),
        ),
      );
    }
  }

  final dependenciesNode = yamlTree['dependencies'];
  if (dependenciesNode is YamlMap) {
    addDependencies(dependenciesNode);
  }

  final devDependenciesNode = yamlTree['dev_dependencies'];
  if (devDependenciesNode is YamlMap) {
    addDependencies(devDependenciesNode);
  }

  return dependencies;
}

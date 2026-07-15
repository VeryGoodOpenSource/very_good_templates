import 'package:equatable/equatable.dart';

/// The name of the flavor that is always present and carries no naming
/// decoration (no application id suffix, no display name prefix).
const defaultFlavorName = 'production';

/// Human friendly abbreviations for the well known flavors.
///
/// Any flavor that is not present in this map falls back to using its own
/// name as the abbreviation. This keeps the generated output identical to the
/// previous hardcoded behavior for the default flavors while still supporting
/// arbitrary flavor names.
const _flavorAbbreviations = <String, String>{
  'development': 'dev',
  'staging': 'stg',
};

/// {@template flavor}
/// A single application flavor (for example `development`, `staging` or
/// `production`).
///
/// Every derived value that the templates need is computed here so that the
/// logic-less Mustache templates can simply iterate over the list of flavors.
/// {@endtemplate}
class Flavor extends Equatable {
  /// {@macro flavor}
  const Flavor(this.name);

  /// The flavor name, for example `development`.
  final String name;

  /// Whether this is the naming-less default (`production`) flavor.
  bool get isDefault => name == defaultFlavorName;

  /// The abbreviation used for suffixes, labels and icon names.
  String get _abbreviation => _flavorAbbreviations[name] ?? name;

  /// The application id suffix, for example `.dev`.
  ///
  /// The default flavor has no suffix.
  String get applicationIdSuffix => isDefault ? '' : '.$_abbreviation';

  /// The display name prefix, for example `[DEV] `.
  ///
  /// The default flavor has no prefix.
  String get label => isDefault ? '' : '[${_abbreviation.toUpperCase()}] ';

  /// The app icon asset name suffix, for example `-dev`.
  ///
  /// The default flavor has no suffix.
  String get iconSuffix => isDefault ? '' : '-$_abbreviation';

  /// The entry point associated with this flavor, for example
  /// `lib/main_development.dart`.
  String get main => 'lib/main_$name.dart';

  /// The entry point file name associated with this flavor, for example
  /// `main_development.dart`.
  ///
  /// Used as the last path segment of a file-loop so that the vanilla
  /// (no flavors) generation collapses to an empty, skipped path.
  String get mainFile => 'main_$name.dart';

  /// The IntelliJ run configuration file name, for example
  /// `development.xml`.
  String get runConfigurationFile => '$name.xml';

  /// The Xcode scheme file name, for example `development.xcscheme`.
  String get schemeFile => '$name.xcscheme';

  /// The variables consumed by the templates for this flavor.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'is_default': isDefault,
    'application_id_suffix': applicationIdSuffix,
    'label': label,
    'icon_suffix': iconSuffix,
    'main': main,
    'main_file': mainFile,
    'run_configuration_file': runConfigurationFile,
    'scheme_file': schemeFile,
    for (final entry in _xcodeConfigurationIds().entries)
      entry.key: entry.value,
  };

  /// Deterministic, collision-safe Xcode object identifiers used within the
  /// generated `project.pbxproj` files.
  ///
  /// Xcode only requires these identifiers to be unique within a single
  /// `project.pbxproj`; the exact values are irrelevant. They are derived from
  /// the flavor name so that generation is reproducible.
  Map<String, String> _xcodeConfigurationIds() {
    const slots = [
      'debug_project_id',
      'debug_target_id',
      'debug_tests_id',
      'release_project_id',
      'release_target_id',
      'release_tests_id',
      'profile_project_id',
      'profile_target_id',
      'profile_tests_id',
      // macOS additionally has a "Flutter Assemble" aggregate target.
      'debug_assemble_id',
      'release_assemble_id',
      'profile_assemble_id',
    ];
    return <String, String>{
      for (final slot in slots) slot: _identifier('$name-$slot'),
    };
  }

  /// Builds a 24 character uppercase hexadecimal identifier from [seed].
  static String _identifier(String seed) {
    final buffer = StringBuffer();
    // Combine three FNV-1a hashes with different salts to obtain enough
    // deterministic entropy for a 24 character identifier.
    for (var salt = 0; salt < 3; salt++) {
      buffer.write(
        _fnv1a('$salt:$seed').toRadixString(16).padLeft(8, '0').substring(0, 8),
      );
    }
    return buffer.toString().toUpperCase();
  }

  /// A 32-bit FNV-1a hash of [input].
  static int _fnv1a(String input) {
    var hash = 0x811c9dc5;
    for (final unit in input.codeUnits) {
      hash ^= unit;
      hash = (hash * 0x01000193) & 0xffffffff;
    }
    return hash;
  }

  @override
  List<Object?> get props => [name];
}

/// Resolves the raw `flavors` hook variable into a list of [Flavor]s.
///
/// The raw value can either be a comma separated [String] (for example
/// `"development,staging"`) or a [List]. The [defaultFlavorName] flavor is
/// always guaranteed to be present.
///
/// When the resolved set contains only the default flavor the returned list is
/// empty, signaling that the project should be generated without any flavors
/// (a plain Flutter app).
List<Flavor> resolveFlavors(Object? raw) {
  final names = switch (raw) {
    null => const <String>[],
    final String value =>
      value
          .split(',')
          .map((name) => name.trim())
          .where((name) => name.isNotEmpty)
          .toList(),
    final List<dynamic> value =>
      value
          .map((name) => name.toString().trim())
          .where((name) => name.isNotEmpty)
          .toList(),
    _ => throw ArgumentError.value(
      raw,
      'flavors',
      'Expected a List or a comma separated String of flavors',
    ),
  };

  final ordered = <String>[];
  for (final name in names) {
    if (!ordered.contains(name)) ordered.add(name);
  }
  if (!ordered.contains(defaultFlavorName)) ordered.add(defaultFlavorName);

  // Only the default flavor means the project has no flavors at all.
  if (ordered.length == 1) return const [];

  return ordered.map(Flavor.new).toList();
}

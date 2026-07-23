import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The name of the flavor that carries no naming decoration
/// (no application id suffix, no display name prefix).

const defaultFlavorName = 'production';

/// The flavors generated when the `flavors` hook variable is absent.
const defaultFlavorNames = ['development', 'staging', 'production'];

/// Human friendly abbreviations for the well known flavors.
@internal
const flavorAbbreviations = {
  'development': 'dev',
  'staging': 'stg',
};

/// {@template flavor}
/// A single application flavor.
/// {@endtemplate}
class Flavor extends Equatable {
  /// {@macro flavor}
  const Flavor(this.name);

  /// The flavor name.
  final String name;

  /// Whether this is the naming-less default flavor.
  bool get isDefault => name == defaultFlavorName;

  /// The abbreviation used for suffixes, labels and icon names.
  String get _abbreviation => flavorAbbreviations[name] ?? name;

  /// The application id suffix, for example `.dev`.
  ///
  /// The default flavor has no suffix.
  String get applicationIdSuffix => isDefault ? '' : '.$_abbreviation';

  /// The display name prefix, for example `[DEV] `.
  ///
  /// The default flavor has no prefix.
  String get label => isDefault ? '' : '[${_abbreviation.toUpperCase()}] ';

  /// The app icon asset name suffix.
  ///
  /// The default flavor has no suffix.
  String get iconSuffix => isDefault ? '' : '-$_abbreviation';

  /// The entry point associated with this flavor.
  String get main => 'lib/main_$name.dart';

  /// The entry point file name associated with this flavor.
  String get mainFile => 'main_$name.dart';

  /// The IntelliJ run configuration file name, for example
  /// `development.xml`.
  String get runConfigurationFile => '$name.xml';

  /// The Xcode scheme file name, for example `development.xcscheme`.
  String get schemeFile => '$name.xcscheme';

  /// The variables consumed by the templates for this flavor.
  Map<String, dynamic> toJson() => {
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

  /// XCode object identifiers used in the generated `project.pbxproj` files.
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
    final entries = slots.map(
      (slot) => MapEntry(slot, _identifier('$name-$slot')),
    );
    return Map.fromEntries(entries);
  }

  static String _identifier(String seed) {
    final buffer = StringBuffer();
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
List<Flavor> resolveFlavors(Object? raw) {
  // Absent: preserve the historical default flavors.
  if (raw == null) return defaultFlavorNames.map(Flavor.new).toList();

  final names = switch (raw) {
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

  // Present but empty: generate a plain app without flavors.
  if (names.isEmpty) return const [];

  // Present and non-empty: respect the provided flavors as-is.
  final ordered = <String>[];
  for (final name in names) {
    if (!ordered.contains(name)) ordered.add(name);
  }

  return ordered.map(Flavor.new).toList();
}

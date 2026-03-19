/// Packages that should not be auto-updated by the dependency tightener.
///
/// These packages are typically tied to specific Flutter SDK versions and
/// updating them could cause version conflicts.
library;

/// Represents a package that should not be auto-updated.
class PinnedPackage {
  /// Creates a new [PinnedPackage] with the given [name] and [reason].
  const PinnedPackage({
    required this.name,
    required this.reason,
  });

  /// The package name as it appears in pubspec.yaml.
  final String name;

  /// The reason this package is pinned.
  final String reason;
}

/// The set of packages that should not be auto-updated.
///
/// These packages are tied to the Flutter SDK version and updating them
/// could cause version conflicts. See each package's [PinnedPackage.reason]
/// for details.
const pinnedPackages = <PinnedPackage>{
  PinnedPackage(
    name: 'intl',
    reason:
        'The intl package version is constrained by the Flutter SDK. '
        'Flutter SDK includes flutter_localizations which depends on a '
        'specific intl version. Updating intl independently causes conflicts.',
  ),
};

/// Returns the set of package names that should be skipped during
/// dependency tightening.
Set<String> get pinnedPackageNames {
  return pinnedPackages.map((p) => p.name).toSet();
}

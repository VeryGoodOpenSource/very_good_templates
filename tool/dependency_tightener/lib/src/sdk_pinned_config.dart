/// Provides configuration for SDK-pinned packages.
///
/// Some packages are pinned by the Flutter SDK and should not be
/// automatically updated by the dependency tightener. This library
/// provides utilities to detect and skip such packages.
library;

/// Maps SDK dependencies to the packages they constrain.
///
/// When a pubspec includes one of these SDK dependencies, the corresponding
/// packages should be skipped during dependency tightening because their
/// versions are constrained by the Flutter SDK itself.
///
/// For example, `flutter_localizations` pins the `intl` package to a specific
/// version that matches the Flutter SDK.
const Map<String, Set<String>> sdkPinnedPackages = {
  'flutter_localizations': {'intl'},
};

/// Returns packages that should be skipped based on SDK dependencies
/// found in the given [pubspecContent].
///
/// Analyzes the pubspec content to detect SDK dependencies (like
/// `flutter_localizations`) and returns all packages that are pinned
/// by those SDK dependencies.
///
/// The [pubspecContent] may contain mustache template variables, which
/// will be handled gracefully.
///
/// Example:
/// ```yaml
/// dependencies:
///   flutter_localizations:
///     sdk: flutter
///   intl: ^0.18.0
/// ```
///
/// For this pubspec, the function would return `{'intl'}` because
/// `flutter_localizations` pins the `intl` package.
Set<String> getAutoSkipPackages(String pubspecContent) {
  final skipPackages = <String>{};

  for (final entry in sdkPinnedPackages.entries) {
    final sdkDependency = entry.key;
    final pinnedPackages = entry.value;

    if (_hasSdkDependency(pubspecContent, sdkDependency)) {
      skipPackages.addAll(pinnedPackages);
    }
  }

  return skipPackages;
}

/// Checks if the pubspec content contains a specific SDK dependency.
///
/// Looks for patterns like:
/// ```yaml
/// flutter_localizations:
///   sdk: flutter
/// ```
bool _hasSdkDependency(String pubspecContent, String dependencyName) {
  // Match patterns like:
  // flutter_localizations:
  //   sdk: flutter
  // With flexible whitespace handling
  final pattern = RegExp(
    '$dependencyName:\\s*\\n\\s*sdk:\\s*flutter',
    multiLine: true,
  );

  return pattern.hasMatch(pubspecContent);
}

import 'package:mason/mason.dart';
import 'package:very_good_flutter_plugin_hooks/version.dart';

void run(HookContext context) {
  const availablePlatforms = [
    'android',
    'ios',
    'macos',
    'linux',
    'web',
    'windows',
  ];

  final selectedPlatformsVar = context.vars['platforms'];

  final selectedPlatforms = switch (selectedPlatformsVar) {
    final String value => value.split(',')..forEach((e) => e.trim()),
    final List<dynamic> value => value,
    _ => throw ArgumentError.value(
      selectedPlatformsVar,
      'platforms',
      'Expected a List of platforms',
    ),
  };

  context.vars.addAll({
    'flutterVersion': $flutterVersion,
    'dartSdkVersionBounds': '^${$minDartVersion}',
    for (final platform in availablePlatforms)
      platform: selectedPlatforms.contains(platform),
  });
}

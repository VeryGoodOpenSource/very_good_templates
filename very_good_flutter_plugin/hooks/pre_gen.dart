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

  late final List<dynamic> selectedPlatforms;
  if (selectedPlatformsVar is String) {
    selectedPlatforms = selectedPlatformsVar.split(',')
      ..forEach((e) => e.trim());
  } else if (selectedPlatformsVar is List) {
    selectedPlatforms = selectedPlatformsVar;
  } else {
    throw ArgumentError.value(
      selectedPlatformsVar,
      'platforms',
      'Expected a List of platforms',
    );
  }

  context.vars.addAll({
    'flutterVersion': $flutterVersion,
    'dartSdkVersionBounds': '^${$minDartVersion}',
    for (final platform in availablePlatforms)
      platform: selectedPlatforms.contains(platform),
  });
}

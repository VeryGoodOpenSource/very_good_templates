import 'package:mason/mason.dart';

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

  context.logger.info(selectedPlatforms.toString());

  context.vars.addAll({
    'flutterVersion': '3.13.2',
    'dartSdkVersionBounds': '>=3.0.0 <4.0.0',
    for (final platform in availablePlatforms)
      platform: selectedPlatforms.contains(platform),
  });

  context.logger.info(context.vars.toString());
}

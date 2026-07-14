import 'package:clock/clock.dart';
import 'package:mason/mason.dart';
import 'package:very_good_flutter_plugin_hooks/version.dart';

void run(HookContext context) {
  final selectedPlatformsVar = context.vars['platforms'] as Object?;

  final selectedPlatforms = switch (selectedPlatformsVar) {
    final String value => value.split(',')..forEach((e) => e.trim()),
    final List<dynamic> value => value,
    _ => throw ArgumentError.value(
      selectedPlatformsVar,
      'platforms',
      'Expected a List of platforms',
    ),
  };

  final darwin = selectedPlatforms.contains('darwin');
  final ios = !darwin && selectedPlatforms.contains('ios');
  final macos = !darwin && selectedPlatforms.contains('macos');

  context.vars.addAll({
    'current_year': clock.now().year.toString(),
    'flutterVersion': $flutterVersion,
    'dartSdkVersionBounds': '^${$minDartVersion}',
    'currentYear': DateTime.now().year.toString(),
    for (final platform in $availablePlatforms)
      platform: selectedPlatforms.contains(platform),
    'ios': ios,
    'macos': macos,
    'supports_ios': ios || darwin,
    'supports_macos': macos || darwin,
    'darwin': darwin,
  });
}

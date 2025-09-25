import 'package:clock/clock.dart';
import 'package:mason/mason.dart';
import 'package:very_good_flame_game_hooks/very_good_flame_game_hooks.dart';

void run(HookContext context) {
  final config = VeryGoodFlameGameConfiguration.fromHookVars(context.vars);
  const availablePlatforms = [
    'android',
    'ios',
    'macos',
    'web',
    'windows',
  ];

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

  context.vars = {
    /// Below are all the variables that are accessible in the templates.
    ///
    /// You can access them using the Mustache syntax within the template files
    /// (those under `__brick__`). For example:
    ///
    /// ```dart
    /// // __brick__/pubspec.yaml
    /// name: {{project_name}}
    /// ```
    ///
    /// This will be replaced with the value of the `project_name` variable.
    ///
    /// By design, Mustache is a  "logic-less" template language, meaning it
    /// does not have the ability to construct logical expressions. From the
    /// documentation:
    ///
    /// > We call it "logic-less" because there are no if statements, else
    /// > clauses, or for loops. Instead there are only tags.
    ///
    /// This means that you can't use Mustache to add logical expressions to
    /// your templates. If you need to add logical expressions, you should
    /// evaluate the expression within this pre-generation hook (`pre_gen.dart`)
    /// and pass the result as a variable to the template.
    ///
    /// See also:
    ///
    /// * [Mustache documentation](https://mustache.github.io/mustache.5.html)
    /// * [Mason conditional documentation](https://docs.brickhub.dev/brick-syntax#-conditionals)
    'project_name': config.projectName,
    'org_name': config.organizationName,
    'description': config.description,
    'android_namespace': config.androidNamespace,
    'android_application_id': config.androidApplicationId,
    'ios_application_id': config.iOsApplicationId,
    'macos_application_id': config.macOsApplicationId,
    'windows_application_id': config.windowsApplicationId,
    'platforms': selectedPlatformsVar,
    'current_year': clock.now().year.toString(),
    for (final platform in availablePlatforms)
      platform: selectedPlatforms.contains(platform),
  };
}

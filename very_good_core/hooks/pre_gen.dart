import 'package:clock/clock.dart';
import 'package:mason/mason.dart';
import 'package:very_good_core_hooks/very_good_core_hooks.dart';

void run(HookContext context) {
  final configuration = VeryGoodCoreConfiguration.fromHookVars(context.vars);

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
    'project_name': configuration.projectName,
    'org_name': configuration.organizationName,
    'description': configuration.description,
    'android_namespace': configuration.androidNamespace,
    'android_application_id': configuration.androidApplicationId,
    'ios_application_id': configuration.iOsApplicationId,
    'macos_application_id': configuration.macOsApplicationId,
    'windows_application_id': configuration.windowsApplicationId,
    'current_year': clock.now().year.toString(),
  };
}

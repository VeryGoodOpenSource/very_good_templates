import 'package:equatable/equatable.dart';

/// The variables specified by this hook.
///
/// The variables can be found in the Brick's `brick.yaml` file. They are
/// initially included in the `HookContext.vars` map.
///
/// See also:
///
/// * [brick.yaml documentation](https://docs.brickhub.dev/brick-structure#brickyaml)
enum _VeryGoodCoreConfigurationVariables {
  /// {@template very_good_core_configuration_variables.project_name}
  /// The project name.
  ///
  /// Defaults to `my_app`.
  /// {@endtemplate}
  projectName._('project_name'),

  /// {@template very_good_core_configuration_variables.description}
  /// A short project description.
  ///
  /// Defaults to `A Very Good App`.
  /// {@endtemplate}
  description._('description')
  ;

  const _VeryGoodCoreConfigurationVariables._(this.key);

  /// The key used in the `HookContext.vars` [Map].
  ///
  /// This should match the variable key in the `brick.yaml`.
  final String key;
}

/// {@template very_good_core_configuration}
/// Configuration for the `very_good_core` brick.
/// {@endtemplate}
class VeryGoodCoreConfiguration extends Equatable {
  /// {@macro very_good_core_configuration}
  const VeryGoodCoreConfiguration({
    String? projectName,
    String? description,
  }) : projectName = projectName ?? 'my_app',
       description = description ?? 'A Very Good App';

  /// Deserializes a [VeryGoodCoreConfiguration] from a `Map<String, dynamic>`
  /// used to represent the configuration in the `HookContext.vars` map.
  factory VeryGoodCoreConfiguration.fromHookVars(Map<String, dynamic> vars) {
    final projectName =
        vars[_VeryGoodCoreConfigurationVariables.projectName.key];
    if (projectName is! String?) {
      throw ArgumentError.value(
        vars,
        'vars',
        '''Expected a value for key "${_VeryGoodCoreConfigurationVariables.projectName.key}" to be of type String?, got $projectName.''',
      );
    }

    final description =
        vars[_VeryGoodCoreConfigurationVariables.description.key];
    if (description is! String?) {
      throw ArgumentError.value(
        vars,
        'vars',
        '''Expected a value for key "${_VeryGoodCoreConfigurationVariables.description.key}" to be of type String?, got $description.''',
      );
    }

    return VeryGoodCoreConfiguration(
      projectName: projectName,
      description: description,
    );
  }

  /// {@macro very_good_core_configuration_variables.project_name}
  final String projectName;

  /// {@macro very_good_core_configuration_variables.description}
  final String description;

  @override
  List<Object?> get props => [
    projectName,
    description,
  ];
}

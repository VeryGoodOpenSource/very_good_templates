import 'package:mason/mason.dart';
import 'package:very_good_core_hooks/very_good_core_hooks.dart';

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

  /// {@template very_good_core_configuration_variables.organization_name}
  /// The organization name.
  ///
  /// Defaults to `com.example`.
  /// {@endtemplate}
  organizationName._('org_name'),

  /// {@template very_good_core_configuration_variables.application_id}
  /// The application id on Android, Bundle ID on iOS and company name on
  /// Windows. If omitted value will be formed by org_name + . + project_name.
  ///
  /// Has no default specified within the `brick.yaml`.
  /// {@endtemplate}
  applicationId._('application_id'),

  /// {@template very_good_core_configuration_variables.description}
  /// A short project description.
  ///
  /// Defaults to `A Very Good App`.
  /// {@endtemplate}
  description._('description');

  const _VeryGoodCoreConfigurationVariables._(this.key);

  /// The key used in the `HookContext.vars` [Map].
  ///
  /// This should match the variable key in the `brick.yaml`.
  final String key;
}

/// {@template very_good_core_configuration}
/// Configuration for the `very_good_core` brick.
/// {@endtemplate}
class VeryGoodCoreConfiguration {
  /// {@macro very_good_core_configuration}
  VeryGoodCoreConfiguration({
    String? projectName,
    String? organizationName,
    String? applicationId,
    String? description,
    String? windowsApplicationId,
    String? iosApplicationId,
    AndroidApplicationId? androidApplicationId,
    AndroidNamespace? androidNamespace,
  })  : projectName = projectName ?? 'my_app',
        organizationName = organizationName ?? 'com.example',
        description = description ?? 'A Very Good App' {
    this.applicationId = applicationId ??
        '${this.organizationName.paramCase}.${this.projectName.paramCase}';

    this.windowsApplicationId = windowsApplicationId ?? this.applicationId;
    this.iosApplicationId = iosApplicationId ?? this.applicationId;

    this.androidApplicationId = androidApplicationId ??
        AndroidApplicationId.fallback(
          organizationName: this.organizationName,
          projectName: this.projectName,
        );
    if (!AndroidApplicationId.isValid(this.androidApplicationId)) {
      throw InvalidAndroidApplicationIdFormat(this.androidApplicationId);
    }

    this.androidNamespace = androidNamespace ??
        AndroidNamespace.fromApplicationId(this.androidApplicationId);
  }

  /// Deserializes a [VeryGoodCoreConfiguration] from a `Map<String, dynamic>`.
  factory VeryGoodCoreConfiguration.fromJson(Map<String, dynamic> json) {
    final projectName =
        json[_VeryGoodCoreConfigurationVariables.projectName.key];
    if (projectName is! String?) {
      throw ArgumentError.value(
        json,
        'json',
        '''Expected a value for key "${_VeryGoodCoreConfigurationVariables.projectName.key}" to be of type String?, got $projectName.''',
      );
    }

    final organizationName =
        json[_VeryGoodCoreConfigurationVariables.organizationName.key];
    if (organizationName is! String?) {
      throw ArgumentError.value(
        json,
        'json',
        '''Expected a value for key "${_VeryGoodCoreConfigurationVariables.organizationName.key}" to be of type String?, got $organizationName.''',
      );
    }

    final applicationId =
        json[_VeryGoodCoreConfigurationVariables.applicationId.key];
    if (applicationId is! String?) {
      throw ArgumentError.value(
        json,
        'json',
        '''Expected a value for key "${_VeryGoodCoreConfigurationVariables.applicationId.key}" to be of type String?, got $applicationId.''',
      );
    }

    final description =
        json[_VeryGoodCoreConfigurationVariables.description.key];
    if (description is! String?) {
      throw ArgumentError.value(
        json,
        'json',
        '''Expected a value for key "${_VeryGoodCoreConfigurationVariables.description.key}" to be of type String?, got $description.''',
      );
    }

    return VeryGoodCoreConfiguration(
      projectName: projectName,
      organizationName: organizationName,
      applicationId: applicationId,
      androidApplicationId:
          applicationId != null ? AndroidApplicationId(applicationId) : null,
      description: description,
    );
  }

  /// {@macro very_good_core_configuration_variables.project_name}
  final String projectName;

  /// {@macro very_good_core_configuration_variables.organization_name}
  final String organizationName;

  /// {@macro very_good_core_configuration_variables.description}
  final String description;

  /// {@macro very_good_core_configuration_variables.application_id}
  late final String applicationId;

  /// Identifies the Windows application.
  late final String windowsApplicationId;

  /// Identifies the iOS application.
  late final String iosApplicationId;

  /// {@macro android_namespace}
  late final AndroidNamespace androidNamespace;

  /// {@macro android_application_id}
  late final AndroidApplicationId androidApplicationId;

  /// Serializes a [VeryGoodCoreConfiguration] to a `Map<String, dynamic>`.
  ///
  /// Only those [_VeryGoodCoreConfigurationVariables] properties get
  /// serialized.
  Map<String, dynamic> toJson() {
    {
      return {
        _VeryGoodCoreConfigurationVariables.projectName.key: projectName,
        _VeryGoodCoreConfigurationVariables.organizationName.key:
            organizationName,
        _VeryGoodCoreConfigurationVariables.applicationId.key: applicationId,
        _VeryGoodCoreConfigurationVariables.description.key: description,
      };
    }
  }
}

import 'package:very_good_core_hooks/very_good_core_hooks.dart';

/// {@template android_namespace}
/// Every Android module has a namespace, which is used as the Kotlin or Java
/// package name for its generated R and BuildConfig classes.
///
/// The namespace can be different than the application ID, but it is usually
/// kept the same for a simpler workflow.
///
/// The name you set for the build.gradle file's namespace property should
/// always match your project's base package name, where you keep your
/// activities and other app code. You can have other sub-packages in your
/// project, but those files must import the R class using the namespace from
/// the namespace property.
///
/// See also:
///
/// * [Set the namespace Android documentation](https://developer.android.com/studio/build/application-id)
/// {@endtemplate}
extension type AndroidNamespace(String value) {
  /// Creates a new [AndroidNamespace] from the provided [applicationId].
  ///
  /// If a specific namespace is not provided, the namespace will default to the
  /// application ID. Such follows the documentation [Set the namespace Android documentation](https://developer.android.com/build/configure-app-module#set-namespace):
  ///
  /// > For a simpler workflow, keep your namespace the same as your application
  /// > ID, as they are by default.
  ///
  /// In addition, to the [Set the application ID Android documentation](https://developer.android.com/build/configure-app-module#set-application-id):
  ///
  /// > Keep the application ID the same as the namespace. The distinction
  /// > between the two properties can be a bit confusing, but if you keep them
  /// > the same, you have nothing to worry about.
  AndroidNamespace.fromApplicationId(
    AndroidApplicationId applicationId,
  ) : this(applicationId.value);
}

#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#endif

public class {{project_name.pascalCase()}}Plugin: NSObject, FlutterPlugin, {{project_name.pascalCase()}}Api {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // Workaround for https://github.com/flutter/flutter/issues/118103.
#if os(iOS)
    let binaryMessenger = registrar.messenger()
#else
    let binaryMessenger = registrar.messenger
#endif
    let instance = {{project_name.pascalCase()}}Plugin()
    {{project_name.pascalCase()}}ApiSetup.setUp(binaryMessenger: binaryMessenger, api: instance)
    registrar.publish(instance)
  }

  func getPlatformName() async throws -> String? {
#if os(iOS)
    return "iOS"
#else
    return "macOS"
#endif
  }
}

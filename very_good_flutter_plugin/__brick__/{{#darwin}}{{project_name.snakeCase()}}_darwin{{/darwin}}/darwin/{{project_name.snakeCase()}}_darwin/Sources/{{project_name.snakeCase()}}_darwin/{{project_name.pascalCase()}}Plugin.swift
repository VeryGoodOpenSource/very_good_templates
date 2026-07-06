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

  func getPlatformName(completion: @escaping (Result<String?, Error>) -> Void) {
    #if os(iOS)
    completion(.success("iOS"))
    #elseif os(macOS)
    completion(.success("macOS"))
    #endif
  }
}

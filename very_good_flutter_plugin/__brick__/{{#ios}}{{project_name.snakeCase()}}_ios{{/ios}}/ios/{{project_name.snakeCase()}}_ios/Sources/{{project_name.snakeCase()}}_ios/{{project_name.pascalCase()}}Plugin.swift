import Flutter

public class {{project_name.pascalCase()}}Plugin: NSObject, FlutterPlugin, {{project_name.pascalCase()}}Api {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let binaryMessenger = registrar.messenger()
    let instance = {{project_name.pascalCase()}}Plugin()
    {{project_name.pascalCase()}}ApiSetup.setUp(binaryMessenger: binaryMessenger, api: instance)
    registrar.publish(instance)
  }

  func getPlatformName(completion: @escaping (Result<String?, Error>) -> Void) {
    completion(.success("iOS"))
  }
}

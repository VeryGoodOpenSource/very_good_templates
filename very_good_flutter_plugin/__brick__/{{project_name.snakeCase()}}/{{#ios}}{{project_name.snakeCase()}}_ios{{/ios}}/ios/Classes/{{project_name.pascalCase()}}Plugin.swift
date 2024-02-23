import Flutter
import UIKit

public class {{project_name.pascalCase()}}Plugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "{{project_name.snakeCase()}}_ios", binaryMessenger: registrar.messenger())
    let instance = {{project_name.pascalCase()}}Plugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS")
  }
}

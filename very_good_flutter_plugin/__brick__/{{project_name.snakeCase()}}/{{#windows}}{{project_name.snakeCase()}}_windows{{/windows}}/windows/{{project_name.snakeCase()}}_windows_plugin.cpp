#include "include/{{project_name.snakeCase()}}_windows/{{project_name.snakeCase()}}_windows.h"

// This must be included before many other Windows headers.
#include <windows.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <map>
#include <memory>

namespace {

using flutter::EncodableValue;

class {{project_name.pascalCase()}}Windows : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  {{project_name.pascalCase()}}Windows();

  virtual ~{{project_name.pascalCase()}}Windows();

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

// static
void {{project_name.pascalCase()}}Windows::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "{{project_name.snakeCase()}}_windows",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<{{project_name.pascalCase()}}Windows>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

{{project_name.pascalCase()}}Windows::{{project_name.pascalCase()}}Windows() {}

{{project_name.pascalCase()}}Windows::~{{project_name.pascalCase()}}Windows() {}

void {{project_name.pascalCase()}}Windows::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("getPlatformName") == 0) {
    result->Success(EncodableValue("Windows"));
  }
  else {
    result->NotImplemented();
  }
}

}  // namespace

void {{project_name.pascalCase()}}WindowsRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  {{project_name.pascalCase()}}Windows::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

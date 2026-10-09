#include "include/{{project_name.snakeCase()}}_windows/{{project_name.snakeCase()}}_windows.h"

// This must be included before many other Windows headers.
#include <windows.h>

#include <flutter/plugin_registrar_windows.h>

#include <functional>
#include <memory>
#include <optional>
#include <string>

#include "messages.g.h"

namespace {

using {{project_name.snakeCase()}}::ErrorOr;
using {{project_name.snakeCase()}}::{{project_name.pascalCase()}}Api;

class {{project_name.pascalCase()}}Windows
    : public flutter::Plugin,
      public {{project_name.pascalCase()}}Api {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  {{project_name.pascalCase()}}Windows();

  virtual ~{{project_name.pascalCase()}}Windows();

  // Disallow copy and assign.
  {{project_name.pascalCase()}}Windows(const {{project_name.pascalCase()}}Windows &) = delete;
  {{project_name.pascalCase()}}Windows &operator=(const {{project_name.pascalCase()}}Windows &) = delete;

  // {{project_name.pascalCase()}}Api:
  void GetPlatformName(
      std::function<void(ErrorOr<std::optional<std::string>> reply)> result)
      override;
};

// static
void {{project_name.pascalCase()}}Windows::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto plugin = std::make_unique<{{project_name.pascalCase()}}Windows>();

  {{project_name.pascalCase()}}Api::SetUp(registrar->messenger(), plugin.get());

  registrar->AddPlugin(std::move(plugin));
}

{{project_name.pascalCase()}}Windows::{{project_name.pascalCase()}}Windows() {}

{{project_name.pascalCase()}}Windows::~{{project_name.pascalCase()}}Windows() {}

void {{project_name.pascalCase()}}Windows::GetPlatformName(
    std::function<void(ErrorOr<std::optional<std::string>> reply)> result) {
  result(std::optional<std::string>("Windows"));
}

}  // namespace

void {{project_name.pascalCase()}}WindowsRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  {{project_name.pascalCase()}}Windows::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

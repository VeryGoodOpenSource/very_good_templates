#ifndef FLUTTER_PLUGIN_{{project_name.constantCase()}}_LINUX_PLUGIN_H_
#define FLUTTER_PLUGIN_{{project_name.constantCase()}}_LINUX_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

G_DECLARE_FINAL_TYPE(Fl{{project_name.pascalCase()}}Plugin, fl_{{project_name.snakeCase()}}_plugin,
                     FL, {{project_name.constantCase()}}_PLUGIN, GObject)

FLUTTER_PLUGIN_EXPORT Fl{{project_name.pascalCase()}}Plugin*
fl_{{project_name.snakeCase()}}_plugin_new(FlPluginRegistrar* registrar);

FLUTTER_PLUGIN_EXPORT void {{project_name.snakeCase()}}_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS

#endif  // FLUTTER_PLUGIN_{{project_name.constantCase()}}_LINUX_PLUGIN_H_
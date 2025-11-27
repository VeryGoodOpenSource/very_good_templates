#include "include/{{project_name.snakeCase()}}_linux/{{project_name.snakeCase()}}_plugin.h"
#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>
#include <cstring>
#include "messages.g.h"

struct _Fl{{project_name.pascalCase()}}Plugin {
  GObject parent_instance;

  FlPluginRegistrar* registrar;
};

G_DEFINE_TYPE(Fl{{project_name.pascalCase()}}Plugin, fl_{{project_name.snakeCase()}}_plugin, g_object_get_type())

static void handle_get_platform_name(
    {{project_name.toPascalCase()}}{{project_name.toPascalCase()}}ApiResponseHandle* response_handle,
    gpointer user_data) {
  {{project_name.toPascalCase()}}_api_respond_get_platform_name(response_handle, "Linux");
}

static {{project_name.toPascalCase()}}ApiVTable api_vtable = {
    handle_get_platform_name,
};

static void fl_{{project_name.snakeCase()}}_plugin_dispose(GObject* object) {
  Fl{{project_name.pascalCase()}}Plugin* self = FL_{{project_name.snakeCase()}}_PLUGIN(object);
  {{project_name.toPascalCase()}}_api_clear_method_handlers(
      fl_plugin_registrar_get_messenger(self->registrar), nullptr);
  G_OBJECT_CLASS(fl_{{project_name.snakeCase()}}_plugin_parent_class)->dispose(object);
}

static void fl_{{project_name.snakeCase()}}_plugin_class_init(Fl{{project_name.pascalCase()}}PluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = fl_{{project_name.snakeCase()}}_plugin_dispose;
}

Fl{{project_name.pascalCase()}}Plugin* fl_{{project_name.snakeCase()}}_plugin_new(FlPluginRegistrar* registrar) {
  Fl{{project_name.pascalCase()}}Plugin* self = FL_{{project_name.snakeCase()}}_PLUGIN(
      g_object_new(fl_{{project_name.snakeCase()}}_plugin_get_type(), nullptr));

  self->registrar = FL_PLUGIN_REGISTRAR(g_object_ref(registrar));

  {{project_name.toPascalCase()}}_api_set_method_handlers(
      fl_plugin_registrar_get_messenger(registrar), nullptr,
      &api_vtable, g_object_ref(self), g_object_unref);

  return self;
}

static void fl_{{project_name.snakeCase()}}_plugin_init(Fl{{project_name.pascalCase()}}Plugin* self) {}

void {{project_name.snakeCase()}}_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  Fl{{project_name.pascalCase()}}Plugin* plugin = fl_{{project_name.snakeCase()}}_plugin_new(registrar);
  g_object_unref(plugin);
}

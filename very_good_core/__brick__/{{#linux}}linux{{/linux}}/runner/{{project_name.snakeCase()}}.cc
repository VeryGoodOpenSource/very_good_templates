#include "{{project_name.snakeCase()}}.h"

#include <flutter_linux/flutter_linux.h>
#ifdef GDK_WINDOWING_X11
#include <gdk/gdkx.h>
#endif

#include "flutter/generated_plugin_registrant.h"

struct _{{project_name.pascalCase()}} {
  GtkApplication parent_instance;
  char** dart_entrypoint_arguments;
};

G_DEFINE_TYPE({{project_name.pascalCase()}}, {{project_name.snakeCase()}}, GTK_TYPE_APPLICATION)

// Called when first Flutter frame received.
static void first_frame_cb({{project_name.pascalCase()}}* self, FlView* view) {
  gtk_widget_show(gtk_widget_get_toplevel(GTK_WIDGET(view)));
}

// Implements GApplication::activate.
static void {{project_name.snakeCase()}}_activate(GApplication* application) {
  {{project_name.pascalCase()}}* self = {{project_name.constantCase()}}_APP(application);
  GtkWindow* window =
      GTK_WINDOW(gtk_application_window_new(GTK_APPLICATION(application)));

  // Use a header bar when running in GNOME as this is the common style used
  // by applications and is the setup most users will be using (e.g. Ubuntu
  // desktop).
  // If running on X and not using GNOME then just use a traditional title bar
  // in case the window manager does more exotic layout, e.g. tiling.
  // If running on Wayland assume the header bar will work (may need changing
  // if future cases occur).
  gboolean use_header_bar = TRUE;
#ifdef GDK_WINDOWING_X11
  GdkScreen* screen = gtk_window_get_screen(window);
  if (GDK_IS_X11_SCREEN(screen)) {
    const gchar* wm_name = gdk_x11_screen_get_window_manager_name(screen);
    if (g_strcmp0(wm_name, "GNOME Shell") != 0) {
      use_header_bar = FALSE;
    }
  }
#endif
  if (use_header_bar) {
    GtkHeaderBar* header_bar = GTK_HEADER_BAR(gtk_header_bar_new());
    gtk_widget_show(GTK_WIDGET(header_bar));
    gtk_header_bar_set_title(header_bar, APPLICATION_NAME);
    gtk_header_bar_set_show_close_button(header_bar, TRUE);
    gtk_window_set_titlebar(window, GTK_WIDGET(header_bar));
  } else {
    gtk_window_set_title(window, APPLICATION_NAME);
  }

  gtk_window_set_default_size(window, 1280, 720);

  g_autoptr(FlDartProject) project = fl_dart_project_new();
  fl_dart_project_set_dart_entrypoint_arguments(
      project, self->dart_entrypoint_arguments);

  FlView* view = fl_view_new(project);
  GdkRGBA background_color;
  // Background defaults to black, override it here if necessary, e.g. #00000000
  // for transparent.
  gdk_rgba_parse(&background_color, "#000000");
  fl_view_set_background_color(view, &background_color);
  gtk_widget_show(GTK_WIDGET(view));
  gtk_container_add(GTK_CONTAINER(window), GTK_WIDGET(view));

  // Show the window when Flutter renders.
  // Requires the view to be realized so we can start rendering.
  g_signal_connect_swapped(view, "first-frame", G_CALLBACK(first_frame_cb),
                           self);
  gtk_widget_realize(GTK_WIDGET(view));

  fl_register_plugins(FL_PLUGIN_REGISTRY(view));

  gtk_widget_grab_focus(GTK_WIDGET(view));
}

// Implements GApplication::local_command_line.
static gboolean {{project_name.snakeCase()}}_local_command_line(GApplication* application,
                                              gchar*** arguments,
                                              int* exit_status) {
  {{project_name.pascalCase()}}* self = {{project_name.constantCase()}}_APP(application);
  // Strip out the first argument as it is the binary name.
  self->dart_entrypoint_arguments = g_strdupv(*arguments + 1);

  g_autoptr(GError) error = nullptr;
  if (!g_application_register(application, nullptr, &error)) {
    g_warning("Failed to register: %s", error->message);
    *exit_status = 1;
    return TRUE;
  }

  g_application_activate(application);
  *exit_status = 0;

  return TRUE;
}

// Implements GApplication::startup.
static void {{project_name.snakeCase()}}_startup(GApplication* application) {
  // {{project_name.pascalCase()}}* self = {{project_name.constantCase()}}_APP(object);

  // Perform any actions required at application startup.

  G_APPLICATION_CLASS({{project_name.snakeCase()}}_parent_class)->startup(application);
}

// Implements GApplication::shutdown.
static void {{project_name.snakeCase()}}_shutdown(GApplication* application) {
  // {{project_name.pascalCase()}}* self = {{project_name.constantCase()}}_APP(object);

  // Perform any actions required at application shutdown.

  G_APPLICATION_CLASS({{project_name.snakeCase()}}_parent_class)->shutdown(application);
}

// Implements GObject::dispose.
static void {{project_name.snakeCase()}}_dispose(GObject* object) {
  {{project_name.pascalCase()}}* self = {{project_name.constantCase()}}_APP(object);
  g_clear_pointer(&self->dart_entrypoint_arguments, g_strfreev);
  G_OBJECT_CLASS({{project_name.snakeCase()}}_parent_class)->dispose(object);
}

static void {{project_name.snakeCase()}}_class_init({{project_name.pascalCase()}}Class* klass) {
  G_APPLICATION_CLASS(klass)->activate = {{project_name.snakeCase()}}_activate;
  G_APPLICATION_CLASS(klass)->local_command_line =
      {{project_name.snakeCase()}}_local_command_line;
  G_APPLICATION_CLASS(klass)->startup = {{project_name.snakeCase()}}_startup;
  G_APPLICATION_CLASS(klass)->shutdown = {{project_name.snakeCase()}}_shutdown;
  G_OBJECT_CLASS(klass)->dispose = {{project_name.snakeCase()}}_dispose;
}

static void {{project_name.snakeCase()}}_init({{project_name.pascalCase()}}* self) {}

{{project_name.pascalCase()}}* {{project_name.snakeCase()}}_new() {
  // Set the program name to the application ID, which helps various systems
  // like GTK and desktop environments map this running application to its
  // corresponding .desktop file. This ensures better integration by allowing
  // the application to be recognized beyond its binary name.
  g_set_prgname(APPLICATION_ID);

  return {{project_name.constantCase()}}_APP(
      g_object_new({{project_name.snakeCase()}}_get_type(), "application-id",
                   APPLICATION_ID, "flags", G_APPLICATION_NON_UNIQUE,
                   nullptr));
}

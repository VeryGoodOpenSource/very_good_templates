#ifndef FLUTTER_{{project_name.constantCase()}}_H_
#define FLUTTER_{{project_name.constantCase()}}_H_

#include <gtk/gtk.h>

G_DECLARE_FINAL_TYPE({{project_name.pascalCase()}},
                     {{project_name.snakeCase()}},
                     {{project_name.constantCase()}},
                     APP,
                     GtkApplication)

/**
 * {{project_name.snakeCase()}}_new:
 *
 * Creates a new Flutter-based application.
 *
 * Returns: a new #{{project_name.pascalCase()}}.
 */
{{project_name.pascalCase()}}* {{project_name.snakeCase()}}_new();

#endif  // FLUTTER_{{project_name.constantCase()}}_H_

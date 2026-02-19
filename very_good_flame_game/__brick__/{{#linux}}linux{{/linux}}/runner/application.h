#ifndef FLUTTER_APPLICATION_H_
#define FLUTTER_APPLICATION_H_

#include <gtk/gtk.h>

G_DECLARE_FINAL_TYPE(Application, application, APPLICATION,
                     GtkApplication)

/**
 * application_new:
 *
 * Creates a new Flutter-based application.
 *
 * Returns: a new #Application.
 */
Application* application_new();

#endif  // FLUTTER_APPLICATION_H_

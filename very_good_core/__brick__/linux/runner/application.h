#ifndef FLUTTER_MY_APPLICATION_H_
#define FLUTTER_MY_APPLICATION_H_

#include <gtk/gtk.h>

G_DECLARE_FINAL_TYPE(Application, application, MY, APPLICATION,
                     GtkApplication)

/**
 * application_new:
 *
 * Creates a new Flutter-based application.
 *
 * Returns: a new #Application.
 */
Application* application_new();

#endif  // FLUTTER_MY_APPLICATION_H_

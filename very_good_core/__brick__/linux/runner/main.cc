#include "application.h"

int main(int argc, char** argv) {
  g_autoptr(Application) app = application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}

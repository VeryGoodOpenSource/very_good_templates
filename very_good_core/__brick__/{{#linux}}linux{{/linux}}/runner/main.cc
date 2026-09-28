#include "{{project_name.snakeCase()}}.h"

int main(int argc, char** argv) {
  g_autoptr({{project_name.pascalCase()}}) app = {{project_name.snakeCase()}}_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}

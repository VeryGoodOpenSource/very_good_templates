import 'dart:io';

import 'package:{{project_name.snakeCase()}}/src/command_runner.dart';

Future<void> main(List<String> args) async {
  exitCode = await {{project_name.pascalCase()}}CommandRunner().run(args);
}

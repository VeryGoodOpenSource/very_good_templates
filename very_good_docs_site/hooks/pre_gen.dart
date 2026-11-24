import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final description = context.vars['description'] as String;

  context.vars = {
    ...context.vars,
    // A JSON string is also a valid JavaScript string literal, so any
    // description renders safely into `docusaurus.config.js`.
    'config_description': jsonEncode(description),
    'current_year': clock.now().year.toString(),
  };
}

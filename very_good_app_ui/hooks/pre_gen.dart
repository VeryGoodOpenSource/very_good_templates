import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  context.vars = {
    ...context.vars,
    'current_year': clock.now().year.toString(),
    // A JSON string is a valid YAML double-quoted scalar, so any description
    // renders safely as the `description` value in `pubspec.yaml`.
    'pubspec_description': jsonEncode(context.vars['description']),
  };
}

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final description = context.vars['description'] as String;

  context.vars = {
    ...context.vars,
    'current_year': clock.now().year.toString(),
    // A JSON string is a valid YAML double-quoted scalar, so any description
    // renders safely as the `description` value in `pubspec.yaml`.
    'pubspec_description': jsonEncode(description),
    'dart_description': _dartStringLiteral(description),
  };
}

/// Encodes [value] as a Dart string literal that satisfies the
/// `prefer_single_quotes`, `avoid_escaping_inner_quotes` and
/// `use_raw_strings` lints.
String _dartStringLiteral(String value) {
  final quote = value.contains("'") && !value.contains('"') ? '"' : "'";
  final canBeRaw =
      !value.contains(quote) && !value.contains('\n') && !value.contains('\r');
  if (canBeRaw && (value.contains(r'\') || value.contains(r'$'))) {
    return 'r$quote$value$quote';
  }

  final escaped = value
      .replaceAll(r'\', r'\\')
      .replaceAll(r'$', r'\$')
      .replaceAll('\n', r'\n')
      .replaceAll('\r', r'\r');

  if (quote == '"') return '"$escaped"';
  return "'${escaped.replaceAll("'", r"\'")}'";
}

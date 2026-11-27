import 'package:clock/clock.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final description = context.vars['description'] as String;

  context.vars = {
    ...context.vars,
    // A JavaScript string literal renders any description safely into
    // `docusaurus.config.js`, and matching Prettier's quoting keeps the
    // generated file passing `prettier --check`.
    'config_description': _jsStringLiteral(description),
    'current_year': clock.now().year.toString(),
  };
}

/// Encodes [value] as a JavaScript string literal formatted the way Prettier
/// (configured with `singleQuote: true`) would emit it, so the generated
/// `docusaurus.config.js` passes `prettier --check`.
String _jsStringLiteral(String value) {
  // Prettier prefers single quotes, switching to double quotes only when that
  // results in fewer escapes.
  final singleQuotes = "'".allMatches(value).length;
  final doubleQuotes = '"'.allMatches(value).length;
  final quote = singleQuotes > doubleQuotes ? '"' : "'";

  final escaped = value
      .replaceAll(r'\', r'\\')
      .replaceAll('\n', r'\n')
      .replaceAll('\r', r'\r')
      .replaceAll(quote, '\\$quote');

  return '$quote$escaped$quote';
}

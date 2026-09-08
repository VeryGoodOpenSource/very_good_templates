import 'package:clock/clock.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  context.vars = {...context.vars, 'current_year': clock.now().year.toString()};
}

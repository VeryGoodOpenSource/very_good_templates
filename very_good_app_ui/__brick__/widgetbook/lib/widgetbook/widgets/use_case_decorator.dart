import 'package:material_ui/material_ui.dart';

/// A decorator that wraps every use case with a consistent background.
class const UseCaseDecorator({
  /// The use case widget to wrap.
  required final Widget child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: SizedBox.expand(child: Material(child: child)),
    );
  }
}

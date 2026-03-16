import 'package:flutter/material.dart';

/// A decorator that wraps every use case with a consistent background.
class UseCaseDecorator extends StatelessWidget {
  /// Creates a [UseCaseDecorator].
  const UseCaseDecorator({required this.child, super.key});

  /// The use case widget to wrap.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: SizedBox.expand(child: Material(child: child)),
    );
  }
}

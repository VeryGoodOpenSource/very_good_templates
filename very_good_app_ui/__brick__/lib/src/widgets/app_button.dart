import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

/// Visual variants for [AppButton].
enum AppButtonVariant {
  /// A filled button with the primary color.
  primary,

  /// A tonal filled button with a secondary color.
  secondary,

  /// An outlined button.
  outline,
}

/// Size variants for [AppButton].
enum AppButtonSize {
  /// A small button.
  small,

  /// A medium button.
  medium,

  /// A large button.
  large,
}

/// {@template app_button}
/// A styled button that composes Material's [FilledButton] and
/// [OutlinedButton] with app-specific sizing and theming.
/// {@endtemplate}
class AppButton extends StatelessWidget {
  /// {@macro app_button}
  const AppButton({
    required this.onPressed,
    required this.child,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    super.key,
  });

  /// Called when the button is tapped.
  final VoidCallback? onPressed;

  /// The button's content, typically a [Text] widget.
  final Widget child;

  /// The visual variant of the button.
  final AppButtonVariant variant;

  /// The size of the button.
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    final padding = switch (size) {
      AppButtonSize.small => EdgeInsets.symmetric(
        horizontal: spacing.sm,
        vertical: spacing.xxs,
      ),
      AppButtonSize.medium => EdgeInsets.symmetric(
        horizontal: spacing.md,
        vertical: spacing.xs,
      ),
      AppButtonSize.large => EdgeInsets.symmetric(
        horizontal: spacing.lg,
        vertical: spacing.sm,
      ),
    };

    final style = ButtonStyle(padding: WidgetStatePropertyAll(padding));

    return switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.secondary => FilledButton.tonal(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.outline => OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    };
  }
}

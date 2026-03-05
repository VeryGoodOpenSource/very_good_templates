import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_catalog/widgetbook/widgetbook.directories.g.dart';
import 'package:widgetbook_catalog/widgetbook/widgets/widgets.dart';
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

/// The Widgetbook catalog app.
@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  /// Creates a [WidgetbookApp].
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        BuilderAddon(
          name: 'Decorator',
          builder: (context, child) {
            return UseCaseDecorator(child: child);
          },
        ),
        ThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: AppTheme.light),
            WidgetbookTheme(name: 'Dark', data: AppTheme.dark),
          ],
          themeBuilder: (context, theme, child) {
            return Theme(
              data: theme,
              child: DefaultTextStyle(
                style: theme.textTheme.bodyMedium ?? const TextStyle(),
                child: child,
              ),
            );
          },
        ),
      ],
    );
  }
}

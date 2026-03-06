import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

/// Primary [AppButton] use case.
@widgetbook.UseCase(name: 'primary', type: AppButton)
Widget primary(BuildContext context) => Center(
  child: AppButton(onPressed: () {}, child: const Text('Primary')),
);

/// Secondary [AppButton] use case.
@widgetbook.UseCase(name: 'secondary', type: AppButton)
Widget secondary(BuildContext context) => Center(
  child: AppButton(
    onPressed: () {},
    variant: AppButtonVariant.secondary,
    child: const Text('Secondary'),
  ),
);

/// Outline [AppButton] use case.
@widgetbook.UseCase(name: 'outline', type: AppButton)
Widget outline(BuildContext context) => Center(
  child: AppButton(
    onPressed: () {},
    variant: AppButtonVariant.outline,
    child: const Text('Outline'),
  ),
);

/// Disabled [AppButton] use case.
@widgetbook.UseCase(name: 'disabled', type: AppButton)
Widget disabled(BuildContext context) =>
    const Center(child: AppButton(onPressed: null, child: Text('Disabled')));

/// All sizes [AppButton] use case.
@widgetbook.UseCase(name: 'all sizes', type: AppButton)
Widget allSizes(BuildContext context) => Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    spacing: 8,
    children: [
      for (final size in AppButtonSize.values)
        AppButton(onPressed: () {}, size: size, child: Text(size.name)),
    ],
  ),
);

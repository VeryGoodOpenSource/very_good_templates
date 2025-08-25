import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:{{project_name.snakeCase()}}/ambient_mode/ambient_mode.dart';

class AmbientModeBuilder extends StatelessWidget {
  AmbientModeBuilder({
    required this.builder,
    super.key,
    this.child,
    @visibleForTesting AmbientModeListener? listener,
  }) : _listener = listener ?? AmbientModeListener.instance;

  final AmbientModeListener _listener;

  final ValueWidgetBuilder<bool> builder;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _listener,
      builder: builder,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      ObjectFlagProperty<ValueWidgetBuilder<bool>>.has('builder', builder),
    );
  }
}

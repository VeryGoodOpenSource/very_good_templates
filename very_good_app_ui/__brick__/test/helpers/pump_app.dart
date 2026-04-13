import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

/// Extension on [WidgetTester] to pump a widget wrapped in [MaterialApp]
/// with the full app theme.
extension PumpApp on WidgetTester {
  /// Pumps [widget] wrapped in a [MaterialApp] with [AppTheme.light].
  Future<void> pumpApp(Widget widget, {ThemeData? theme}) {
    return pumpWidget(
      MaterialApp(
        theme: theme ?? AppTheme.light,
        home: Scaffold(body: widget),
      ),
    );
  }
}

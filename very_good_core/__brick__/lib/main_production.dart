import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}

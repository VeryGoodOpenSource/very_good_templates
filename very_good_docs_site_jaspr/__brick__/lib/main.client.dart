import 'package:jaspr/client.dart';
import 'package:{{project_name.snakeCase()}}/main.client.options.dart';

void main() {
  Jaspr.initializeApp(options: defaultClientOptions);
  runApp(const ClientApp());
}

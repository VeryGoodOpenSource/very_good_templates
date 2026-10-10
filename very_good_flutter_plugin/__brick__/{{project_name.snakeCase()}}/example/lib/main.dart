{{#web}}import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
{{/web}}import 'package:material_ui/material_ui.dart';
import 'package:{{project_name.snakeCase()}}/{{project_name.snakeCase()}}.dart';

{{#web}}void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Maestro finds widgets on the web through the semantics tree, which
  // Flutter web only builds when requested.
  if (kIsWeb) SemanticsBinding.instance.ensureSemantics();
  runApp(const MyApp());
}
{{/web}}{{^web}}void main() => runApp(const MyApp());
{{/web}}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _platformName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{project_name.pascalCase()}} Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_platformName == null)
              const SizedBox.shrink()
            else
              Text(
                'Platform Name: $_platformName',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (!context.mounted) return;
                try {
                  final result = await getPlatformName();
                  setState(() => _platformName = result);
                } on Exception catch (error) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Text('$error'),
                    ),
                  );
                }
              },
              child: const Text('Get Platform Name'),
            ),
          ],
        ),
      ),
    );
  }
}

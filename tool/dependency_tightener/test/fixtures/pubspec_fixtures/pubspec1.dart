const pubspec1 = '''
name: {{project_name.snakeCase()}}
description: A very good {{project_name.snakeCase()}} plugin.
version: 0.1.0+1
{{^publishable}}publish_to: none{{/publishable}}

environment:
  sdk: {{{dartSdkVersionBounds}}}

dependencies:
  flutter:
    sdk: flutter
  plugin_platform_interface: ^2.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  very_good_analysis: ^5.1.0
''';

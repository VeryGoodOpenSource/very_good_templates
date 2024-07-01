const pubspec1 = '''
name: {{project_name.snakeCase()}}
description: A very good {{project_name.snakeCase()}} project.
version: 0.1.0+1
{{^publishable}}publish_to: none{{/publishable}}

environment:
  sdk: {{{dartSdkVersionBounds}}}

dependencies:
  flutter:
    sdk: flutter
  plugin_platform_interface: ^2.1.0
  pub_updater: 0.3.0

dev_dependencies:
{{#my_variable}}  mocktail: ^1.0.3{{/my_variable}}
  flutter_test:
    sdk: flutter
  very_good_analysis: ^5.1.0
''';

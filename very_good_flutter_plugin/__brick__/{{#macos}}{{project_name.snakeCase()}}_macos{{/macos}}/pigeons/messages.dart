import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    dartPackageName: '{{project_name.snakeCase()}}',
    swiftOut: 'macos/{{project_name.snakeCase()}}_macos/Sources/{{project_name.snakeCase()}}_macos/Messages.g.swift',
    swiftOptions: SwiftOptions(),
    copyrightHeader: 'pigeons/copyright.txt',
  ),
)
@HostApi()
abstract class {{project_name.pascalCase()}}Api {
  @async
  String? getPlatformName();
}

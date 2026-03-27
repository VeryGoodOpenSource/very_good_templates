import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    dartPackageName: '{{project_name.snakeCase()}}',
    cppOptions: CppOptions(namespace: '{{project_name.snakeCase()}}'),
    cppHeaderOut: 'windows/include/{{project_name.snakeCase()}}_windows/messages.g.h',
    cppSourceOut: 'windows/messages.g.cpp',
    copyrightHeader: 'pigeons/copyright.txt',
  ),
)
@HostApi()
abstract class {{project_name.pascalCase()}}Api {
  @async
  String? getPlatformName();
}

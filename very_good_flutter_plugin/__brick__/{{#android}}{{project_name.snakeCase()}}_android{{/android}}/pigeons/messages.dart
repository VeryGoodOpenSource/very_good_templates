// {{project_name.pascalCase()}}Api must be abstract.
// ignore_for_file: one_member_abstracts

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    dartPackageName: '{{project_name.snakeCase()}}',
    kotlinOut: 'android/src/main/kotlin/{{org_name.pathCase()}}/Messages.g.kt',
    kotlinOptions: KotlinOptions(),
    copyrightHeader: 'pigeons/copyright.txt',
  ),
)
@HostApi()
abstract class {{project_name.pascalCase()}}Api {
  @async
  String? getPlatformName();
}

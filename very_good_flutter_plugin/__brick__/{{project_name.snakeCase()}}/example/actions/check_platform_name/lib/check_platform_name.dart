import 'package:fluttium/fluttium.dart';

import 'src/check_platform_name.dart';

export 'src/check_platform_name.dart';

/// Will be executed by Fluttium on startup.
void register(Registry registry) {
  registry.registerAction('checkPlatformName', CheckPlatformName.new);
}

import 'package:mason/mason.dart';

enum Platform {
  android,
  ios,
}

void run(HookContext context) {
  context.vars['application_id_android'] =
      _appId(context, platform: Platform.android);
  context.vars['application_id'] = _appId(context);
}

String _appId(HookContext context, {Platform? platform}) {
  final orgName = context.vars['org_name'] as String;
  final projectName = context.vars['project_name'] as String;

  var applicationId = context.vars['application_id'] as String?;
  applicationId = (applicationId?.isNotEmpty ?? false)
      ? applicationId
      : '''$orgName.${platform == Platform.android ? projectName.snakeCase : projectName.paramCase}''';

  return applicationId!;
}

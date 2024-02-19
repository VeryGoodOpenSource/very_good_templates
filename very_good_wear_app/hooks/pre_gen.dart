import 'package:mason/mason.dart';

void run(HookContext context) {
  context.vars['application_id'] = _appId(context);
}

String _appId(HookContext context) {
  final orgName = context.vars['org_name'] as String;
  final projectName = context.vars['project_name'] as String;

  var applicationId = context.vars['application_id'] as String?;
  applicationId = (applicationId?.isNotEmpty ?? false)
      ? applicationId
      : '$orgName.${projectName.snakeCase}';

  return applicationId!;
}

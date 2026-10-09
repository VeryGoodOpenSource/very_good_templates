import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'package:{{project_name.snakeCase()}}/layouts/site_chrome.dart';

/// A [DocsLayout] wrapped in the shared [SiteChrome].
class AppDocsLayout extends DocsLayout with SiteChrome {
  /// Creates a docs layout wrapped in the shared site chrome.
  const AppDocsLayout({
    super.header,
    super.sidebar,
    super.footer,
    this.siteFooter,
  });

  @override
  final Component? siteFooter;

  @override
  Component buildBody(Page page, Component child) {
    return buildShell(super.buildBody(page, child));
  }
}

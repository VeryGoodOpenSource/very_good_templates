import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'package:{{project_name.snakeCase()}}/layouts/site_chrome.dart';

/// A [DocsLayout] that also renders the shared site chrome — the
/// [SiteChrome.siteFooter] below the docs content and the site-wide head
/// tags — matching the Docusaurus template where the navigation footer
/// appears on every page.
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

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'package:{{project_name.snakeCase()}}/src/speculation_rules.dart';

/// Site-wide chrome shared by every layout: the head tags and page shell
/// that would otherwise be repeated per layout.
///
/// It is a mixin so it can apply both to jaspr_content's `DocsLayout` and to
/// a hand-written `PageLayoutBase`.
mixin SiteChrome on PageLayoutBase {
  /// The site-wide footer rendered at the bottom of the page shell.
  Component? get siteFooter;

  @override
  @mustCallSuper
  Iterable<Component> buildHead(Page page) sync* {
    yield* super.buildHead(page);
    yield speculationRules;
    yield Style(styles: _styles);
  }

  /// Wraps a layout's content in a full-viewport flex column above
  /// [siteFooter], so the footer stays anchored to the bottom of the viewport
  /// when the content is shorter than the screen.
  Component buildShell(Component content) =>
      div(classes: 'page-shell', [content, ?siteFooter]);

  static final List<StyleRule> _styles = [
    css('.page-shell').styles(
      display: Display.flex,
      minHeight: 100.vh,
      flexDirection: FlexDirection.column,
    ),
    // The content grows to push the footer to the bottom of the viewport.
    css('.page-shell > :first-child')
        .styles(flex: const Flex(grow: 1, shrink: 0, basis: Unit.auto)),
  ];
}

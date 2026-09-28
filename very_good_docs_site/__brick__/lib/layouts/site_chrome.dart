import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'package:{{project_name.snakeCase()}}/src/speculation_rules.dart';

/// Site-wide chrome shared by every layout, following dart.dev's `DashLayout`
/// pattern of centralizing cross-layout head tags and body wrappers in one
/// base instead of repeating them per layout.
///
/// dart.dev uses an abstract base class because its layouts are fully
/// hand-rolled. This template keeps jaspr_content's `DocsLayout` for the docs
/// chrome, so the shared pieces live in a mixin both layouts can apply.
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
  /// [siteFooter], the way Infima's `#__docusaurus` flex column does in the
  /// Docusaurus template: when the content is shorter than the screen, the
  /// footer is anchored to the bottom of the viewport.
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

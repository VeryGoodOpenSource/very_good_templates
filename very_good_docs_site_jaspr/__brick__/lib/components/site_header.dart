import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/sidebar_toggle_button.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'package:{{project_name.snakeCase()}}/src/colors.dart';

/// A navbar link entry.
typedef NavLink = ({String label, String href});

/// The site navbar, mirroring the Docusaurus template's navbar layout:
/// brand (logo + title) with left-aligned nav items immediately after it,
/// and icon items pushed to the right.
///
/// The site name comes from the `titleBase` key in `content/_data/site.yaml`,
/// the same source the tab title and landing hero use.
///
/// This replaces `jaspr_content`'s `Header`, whose `items` always render on
/// the right with no left-aligned slot.
class SiteHeader extends StatelessComponent {
  /// Creates a site navbar.
  const SiteHeader({
    required this.logo,
    this.leftItems = const [],
    this.rightItems = const [],
    this.showSidebarToggle = true,
    super.key,
  });

  /// The src href of the site logo.
  final String logo;

  /// Nav links rendered directly after the brand.
  final List<NavLink> leftItems;

  /// Components rendered at the far right, such as a theme toggle.
  final List<Component> rightItems;

  /// Whether to render the mobile sidebar toggle. Disable on pages without
  /// a sidebar, such as the landing page.
  final bool showSidebarToggle;

  @override
  Component build(BuildContext context) {
    final title = context.page.data.site['titleBase'] as String? ?? '';
    return Component.fragment([
      Document.head(children: [Style(styles: _styles)]),
      header(classes: 'header', [
        if (showSidebarToggle) const SidebarToggleButton(),
        a(classes: 'header-title', href: '/', [
          img(src: logo, alt: 'Logo'),
          span([Component.text(title)]),
        ]),
        if (leftItems.isNotEmpty)
          nav(classes: 'header-nav', [
            for (final item in leftItems)
              a(classes: 'header-nav-link', href: item.href, [
                Component.text(item.label),
              ]),
          ]),
        div(classes: 'header-content', [
          div(classes: 'header-items', rightItems),
        ]),
      ]),
    ]);
  }

  static final List<StyleRule> _styles = [
    css('.header', [
      css('&').styles(
        display: Display.flex,
        height: 4.rem,
        padding: Padding.symmetric(horizontal: 1.rem, vertical: .25.rem),
        margin: const Margin.symmetric(horizontal: Unit.auto),
        border: Border.only(
          bottom: BorderSide(color: AppColors.headerBorder, width: 1.px),
        ),
        alignItems: AlignItems.center,
        gap: Gap.column(1.rem),
      ),
      css.media(MediaQuery.all(minWidth: 768.px), [
        css('&').styles(padding: Padding.symmetric(horizontal: 2.5.rem)),
      ]),
      css('.header-title', [
        css('&').styles(
          display: Display.inlineFlex,
          alignItems: AlignItems.center,
          gap: Gap.column(.75.rem),
          textDecoration: TextDecoration.none,
        ),
        css('img').styles(width: Unit.auto, height: 1.5.rem),
        css('span').styles(fontWeight: FontWeight.w700),
      ]),
      css('.header-nav', [
        css('&').styles(
          display: Display.flex,
          height: 100.percent,
          alignItems: AlignItems.center,
          gap: Gap.column(1.rem),
        ),
        css('.header-nav-link', [
          // inline-flex + center keeps the label vertically centered instead
          // of stretching to the full navbar height.
          css('&').styles(
            display: Display.inlineFlex,
            transition: Transition('opacity', duration: 150.ms),
            alignItems: AlignItems.center,
            fontWeight: FontWeight.w500,
            textDecoration: TextDecoration.none,
          ),
          css('&:hover').styles(opacity: 0.7),
        ]),
      ]),
      css('.header-content').styles(
        display: Display.flex,
        justifyContent: JustifyContent.end,
        alignItems: AlignItems.center,
        flex: const Flex(grow: 1),
      ),
      css('.header-items').styles(
        display: Display.flex,
        alignItems: AlignItems.center,
        gap: Gap.column(0.75.rem),
      ),
    ]),
  ];
}

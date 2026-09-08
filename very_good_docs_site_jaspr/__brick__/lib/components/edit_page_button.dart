import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';

/// A footer link to edit the current page's source on GitHub, mirroring the
/// Docusaurus `editUrl` feature.
///
/// Rendered as plain text with no pencil icon, the way docs.flutter.dev
/// renders its "View source or report an issue" affordance.
class EditPageButton extends StatelessComponent {
  /// Creates an edit link built from [editUrlBase] and the page's source path.
  const EditPageButton({required this.editUrlBase, super.key});

  /// The URL the page's source path is appended to when building the edit
  /// link, e.g. `https://github.com/<org>/<repo>/edit/main/content`. Like
  /// Docusaurus's `editUrl`, this keeps the repository layout knowledge at
  /// the configuration site.
  final String editUrlBase;

  @override
  Component build(BuildContext context) {
    final pagePath = context.page.path;
    return Component.fragment([
      Document.head(children: [Style(styles: _styles)]),
      a(
        classes: 'edit-page-link',
        href: '$editUrlBase/$pagePath',
        target: Target.blank,
        const [Component.text('Edit this page')],
      ),
    ]);
  }

  static final List<StyleRule> _styles = [
    css('.edit-page-link', [
      css('&').styles(
        display: Display.inlineFlex,
        alignItems: AlignItems.center,
        gap: Gap.column(0.3.em),
        color: ContentColors.primary,
        fontWeight: FontWeight.w500,
        textDecoration: TextDecoration.none,
      ),
      css('&:hover').styles(
        textDecoration: const TextDecoration(
          line: TextDecorationLine.underline,
        ),
      ),
    ]),
  ];
}

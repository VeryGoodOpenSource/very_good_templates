import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';

/// A footer link to edit the current page's source on GitHub.
class EditPageButton extends StatelessComponent {
  /// Creates an edit link built from [editUrlBase] and the page's source path.
  const EditPageButton({required this.editUrlBase, super.key});

  /// The URL the page's source path is appended to when building the edit
  /// link, e.g. `https://github.com/<org>/<repo>/edit/main/content`. Passing
  /// it in keeps knowledge of the repository layout in `main.server.dart`.
  final String editUrlBase;

  @override
  Component build(BuildContext context) {
    final pagePath = context.page.path;
    return a(
      classes: 'edit-page-link',
      href: '$editUrlBase/$pagePath',
      target: .blank,
      const [.text('Edit this page')],
    );
  }

  /// The styles for this component, bundled into the site stylesheet.
  @css
  static List<StyleRule> get styles => [
    css('.edit-page-link', [
      css('&').styles(
        display: .inlineFlex,
        alignItems: .center,
        gap: .column(0.3.em),
        color: ContentColors.primary,
        fontWeight: .w500,
        textDecoration: .none,
      ),
      css('&:hover')
          .styles(textDecoration: const TextDecoration(line: .underline)),
    ]),
  ];
}

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// An icon-only link to the GitHub repository, mirroring the Docusaurus
/// template's `navbar-github-icon` item.
///
/// The mark is referenced out of `web/images/icons/github.svg`, which holds a
/// single `<symbol>` carrying its own `viewBox` and `fill="currentColor"`, so
/// the icon inherits the surrounding text color and is sized purely in CSS.
/// This is how dart.dev and docs.flutter.dev render their brand marks: the
/// path data stays out of the Dart source and out of every rendered page, and
/// the browser caches the file once for the site.
///
/// Material Symbols is the flagship answer for general UI icons (menu,
/// search, copy), but it costs a webfont download, so it only pays off once
/// the icon surface is more than a handful of marks.
class GitHubIconLink extends StatelessComponent {
  /// Creates an icon link to the given [repo].
  const GitHubIconLink({required this.repo, super.key});

  /// The GitHub repository in `org/name` form.
  final String repo;

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      Document.head(children: [Style(styles: _styles)]),
      a(
        classes: 'github-icon-link',
        href: 'https://github.com/$repo',
        target: Target.blank,
        attributes: const {'aria-label': 'GitHub repository'},
        // The link already carries the label, so the mark is decorative.
        const [
          svg(
            attributes: {'aria-hidden': 'true'},
            [
              Component.element(
                tag: 'use',
                attributes: {'href': '/images/icons/github.svg#github'},
              ),
            ],
          ),
        ],
      ),
    ]);
  }

  static final List<StyleRule> _styles = [
    css('.github-icon-link', [
      css('&').styles(
        display: Display.inlineFlex,
        transition: Transition('opacity', duration: 150.ms),
        alignItems: AlignItems.center,
      ),
      css('&:hover').styles(opacity: 0.7),
      css('svg').styles(width: 24.px, height: 24.px),
    ]),
  ];
}

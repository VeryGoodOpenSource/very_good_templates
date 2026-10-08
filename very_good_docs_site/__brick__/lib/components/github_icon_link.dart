import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// An icon-only link to the GitHub repository.
///
/// The mark is referenced out of `web/images/icons/github.svg`, which holds a
/// single `<symbol>` carrying its own `viewBox` and `fill="currentColor"`, so
/// the icon inherits the surrounding text color and is sized purely in CSS.
/// The path data stays out of every rendered page, and the browser caches the
/// file once for the whole site. Add more marks to `web/images/icons/` the
/// same way.
class GitHubIconLink extends StatelessComponent {
  /// Creates an icon link to the given [repo].
  const GitHubIconLink({required this.repo, super.key});

  /// The GitHub repository in `org/name` form.
  final String repo;

  @override
  Component build(BuildContext context) {
    return a(
      classes: 'github-icon-link',
      href: 'https://github.com/$repo',
      target: .blank,
      attributes: const {'aria-label': 'GitHub repository'},
      // The link already carries the label, so the mark is decorative.
      const [
        svg(
          attributes: {'aria-hidden': 'true'},
          [
            .element(
              tag: 'use',
              attributes: {'href': '/images/icons/github.svg#github'},
            ),
          ],
        ),
      ],
    );
  }

  /// The styles for this component, bundled into the site stylesheet.
  @css
  static List<StyleRule> get styles => [
    css('.github-icon-link', [
      css('&').styles(
        display: .inlineFlex,
        transition: Transition('opacity', duration: 150.ms),
        alignItems: .center,
      ),
      css('&:hover').styles(opacity: 0.7),
      css('svg').styles(width: 24.px, height: 24.px),
    ]),
  ];
}

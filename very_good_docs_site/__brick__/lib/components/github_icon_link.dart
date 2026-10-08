import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// An icon-only link to the GitHub repository.
///
/// The icon is a `<symbol>` in `web/images/icons/github.svg` that uses
/// `fill="currentColor"`, so it inherits the surrounding text color.
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

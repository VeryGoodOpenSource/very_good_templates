import 'package:jaspr/server.dart';
import 'package:jaspr_test/server_test.dart';
import 'package:{{project_name.snakeCase()}}/components/github_icon_link.dart';

import '../helpers/helpers.dart';

void main() {
  setUpAll(Jaspr.initializeApp);

  group(GitHubIconLink, () {
    testServer('links to the repository with an accessible label', (
      tester,
    ) async {
      final response = await tester.render(
        const GitHubIconLink(repo: 'org/repo'),
      );

      final link = response.document!.querySelector('a.github-icon-link')!;
      expect(link.attributes['href'], equals('https://github.com/org/repo'));
      expect(link.attributes['aria-label'], equals('GitHub repository'));
    });

    testServer('renders the icon as a decorative symbol reference', (
      tester,
    ) async {
      final response = await tester.render(
        const GitHubIconLink(repo: 'org/repo'),
      );

      final icon = response.document!.querySelector('a.github-icon-link svg')!;
      expect(icon.attributes['aria-hidden'], equals('true'));
      expect(
        icon.querySelector('use')!.attributes['href'],
        equals('/images/icons/github.svg#github'),
      );
    });

    testServer('declares styles for its classes', (tester) async {
      final css = await tester.renderCss(GitHubIconLink.styles);

      expect(css, contains('.github-icon-link'));
    });
  });
}

import 'package:jaspr/server.dart';
import 'package:jaspr_test/server_test.dart';
import 'package:{{project_name.snakeCase()}}/components/edit_page_button.dart';

import '../helpers/helpers.dart';

void main() {
  setUpAll(Jaspr.initializeApp);

  group(EditPageButton, () {
    testServer('links to the source of the current page', (tester) async {
      final response = await tester.render(
        const EditPageButton(editUrlBase: 'https://github.com/org/repo/edit'),
        page: buildPage(path: 'docs/overview.md'),
      );

      final link = response.document!.querySelector('a.edit-page-link')!;
      expect(
        link.attributes['href'],
        equals('https://github.com/org/repo/edit/docs/overview.md'),
      );
      expect(link.attributes['target'], equals('_blank'));
      expect(link.text, equals('Edit this page'));
    });
  });
}

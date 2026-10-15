import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_test/server_test.dart';
import 'package:{{project_name.snakeCase()}}/layouts/app_docs_layout.dart';

import '../helpers/helpers.dart';

void main() {
  setUpAll(Jaspr.initializeApp);

  group(AppDocsLayout, () {
    final page = buildPage(path: 'docs/overview.md');

    const layout = AppDocsLayout(
      siteFooter: footer(classes: 'test-footer', <Component>[]),
    );

    testServer('renders the site footer after the docs content', (
      tester,
    ) async {
      final response = await tester.render(
        layout.buildLayout(page, const .text('Page content')),
        page: page,
      );
      final shell = response.document!.querySelector('.page-shell')!;

      expect(shell.children, hasLength(2));
      expect(shell.children.first.text, contains('Page content'));
      expect(shell.children.last.classes, contains('test-footer'));
    });

    testServer('adds the site chrome to the head', (tester) async {
      final response = await tester.render(
        layout.buildLayout(page, const .text('')),
        page: page,
      );

      expect(
        response.document!.head!.querySelector(
          'script[type="speculationrules"]',
        ),
        isNotNull,
      );
    });
  });
}

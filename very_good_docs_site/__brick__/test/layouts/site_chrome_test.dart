import 'package:jaspr/server.dart';
import 'package:jaspr_test/server_test.dart';
import 'package:{{project_name.snakeCase()}}/layouts/site_chrome.dart';

import '../helpers/helpers.dart';

void main() {
  setUpAll(Jaspr.initializeApp);

  group('siteChromeStyles', () {
    testServer('declares styles for the page shell', (tester) async {
      final css = await tester.renderCss(siteChromeStyles);

      expect(css, contains('.page-shell'));
    });
  });
}

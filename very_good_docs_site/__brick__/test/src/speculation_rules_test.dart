import 'dart:convert';

import 'package:jaspr/server.dart';
import 'package:jaspr_test/server_test.dart';
import 'package:{{project_name.snakeCase()}}/src/speculation_rules.dart';

import '../helpers/helpers.dart';

void main() {
  setUpAll(Jaspr.initializeApp);

  group('speculationRules', () {
    testServer('prefetches on hover and prerenders on pointer-down', (
      tester,
    ) async {
      final response = await tester.render(speculationRules);
      final script = response.document!.querySelector(
        'script[type="speculationrules"]',
      )!;

      final rules = jsonDecode(script.text) as Map<String, Object?>;
      expect(rules['prefetch'], [
        {
          'where': {'href_matches': '/*'},
          'eagerness': 'moderate',
        },
      ]);
      expect(rules['prerender'], [
        {
          'where': {
            'and': [
              {'href_matches': '/*'},
              {
                'not': {'selector_matches': '.no-prerender'},
              },
            ],
          },
          'eagerness': 'conservative',
        },
      ]);
    });
  });
}

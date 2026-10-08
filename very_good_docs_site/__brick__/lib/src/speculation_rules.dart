import 'dart:convert';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// A `<script type="speculationrules">` tag that tells the browser to
/// prefetch same-origin links on hover and prerender them on click.
///
/// Add the `no-prerender` class to any link that must not be prerendered,
/// such as one with side effects.
final Component speculationRules = RawText(
  '<script type="speculationrules">${jsonEncode(_rules)}</script>',
);

const _internalLink = {'href_matches': '/*'};

const Map<String, Object?> _rules = {
  'prefetch': [
    {'where': _internalLink, 'eagerness': 'moderate'},
  ],
  'prerender': [
    {
      'where': {
        'and': [
          _internalLink,
          {
            'not': {'selector_matches': '.no-prerender'},
          },
        ],
      },
      'eagerness': 'conservative',
    },
  ],
};

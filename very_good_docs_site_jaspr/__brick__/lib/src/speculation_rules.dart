import 'dart:convert';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// A `<script type="speculationrules">` tag that tells the browser to
/// prefetch same-origin links on hover and prerender them on click.
///
/// A static Jaspr site has no client-side router, so every link is a real
/// browser navigation. Speculation Rules close most of the gap with an SPA:
/// the target page is already fetched (and usually fully rendered) by the
/// time the click lands, so navigation is effectively instant and back /
/// forward keep working natively.
///
/// This is the same approach dart.dev uses (`_buildSpeculationRulesHead` in
/// its `DashLayout`). Add the `no-prerender` class to any link that must not
/// be speculatively loaded, such as one with side effects.
///
/// Unsupported browsers simply ignore the tag.
final Component speculationRules = RawText(
  '<script type="speculationrules">${jsonEncode(_rules)}</script>',
);

const _internalLink = {'href_matches': '/*'};

const Map<String, Object?> _rules = {
  // 'moderate' starts a prefetch when the pointer rests on a link.
  'prefetch': [
    {'where': _internalLink, 'eagerness': 'moderate'},
  ],
  // 'conservative' starts a prerender on pointer-down.
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

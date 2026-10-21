import 'package:jaspr/dom.dart';
import 'package:jaspr_content/theme.dart';

/// The site palette.
///
/// Every token here must be registered on the `ContentTheme` in
/// `main.server.dart`, which emits it as a light/dark CSS custom property.
abstract final class AppColors {
  /// The brand color used for links, buttons, and highlights.
  static const primary = ThemeColor(Color('#2a48df'), dark: Color('#66fbd1'));

  /// The background of the site-wide footer.
  static const footerBackground = ColorToken(
    'footer-background',
    Color('#f8f9fa'),
    dark: Color('#232938'),
  );

  /// The navbar's bottom hairline.
  static const headerBorder = ColorToken('header-border', Color('#0000000d'));

  /// Text on the hero call to action.
  static const heroCtaText = ColorToken(
    'hero-cta-text',
    Colors.white,
    dark: Color('#1c1e21'),
  );

  /// The tokens to register on the `ContentTheme`.
  static const tokens = <ColorToken>[
    footerBackground,
    headerBorder,
    heroCtaText,
  ];
}

# Very Good App UI

[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

[![License: MIT][license_badge]][license_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A Very Good Flutter app UI package created by Very Good Ventures 🦄.

## What's Included ✨

- ✅ GitHub Workflow powered by [Very Good Workflows][very_good_workflows_link]
- ✅ Pull Request Template
- ✅ Issue Templates
- ✅ Dependabot Integration
- ✅ Strict lint rules powered by [Very Good Analysis][very_good_analysis_link]
- ✅ 100% Test Coverage
- ✅ Fully Documented Public API
- ✅ MIT License
- ✅ Changelog
- ✅ `ThemeExtension`-based theming with light and dark variants
- ✅ Custom color and spacing tokens
- ✅ Example `AppButton` widget composing Material widgets
- ✅ `BuildContext` extensions for easy theme access
- ✅ Widget test helpers
- ✅ Widgetbook catalog for browsing widgets in isolation

## Output 📦

```sh
├── .github
│   ├── ISSUE_TEMPLATE
│   │   ├── bug_report.md
│   │   ├── build.md
│   │   ├── chore.md
│   │   ├── ci.md
│   │   ├── config.yml
│   │   ├── documentation.md
│   │   ├── feature_request.md
│   │   ├── performance.md
│   │   ├── refactor.md
│   │   ├── revert.md
│   │   ├── style.md
│   │   └── test.md
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── dependabot.yaml
│   └── workflows
│       └── main.yaml
├── .gitignore
├── CHANGELOG.md
├── LICENSE
├── README.md
├── analysis_options.yaml
├── coverage_badge.svg
├── lib
│   ├── src
│   │   ├── extensions
│   │   │   └── build_context_extensions.dart
│   │   ├── theme
│   │   │   ├── app_colors.dart
│   │   │   ├── app_spacing.dart
│   │   │   └── app_theme.dart
│   │   └── widgets
│   │       └── app_button.dart
│   └── my_app_ui.dart
├── pubspec.yaml
├── test
│   ├── helpers
│   │   ├── helpers.dart
│   │   └── pump_app.dart
│   └── src
│       ├── theme
│       │   ├── app_colors_test.dart
│       │   ├── app_spacing_test.dart
│       │   └── app_theme_test.dart
│       └── widgets
│           └── app_button_test.dart
└── widgetbook
    ├── .gitignore
    ├── analysis_options.yaml
    ├── lib
    │   ├── main.dart
    │   └── widgetbook
    │       ├── use_cases
    │       │   └── app_button.dart
    │       ├── widgetbook.dart
    │       └── widgets
    │           ├── use_case_decorator.dart
    │           └── widgets.dart
    └── pubspec.yaml
```

By default `mason make` will generate the output in the current working directory but a custom output directory can be specified via the [-o option][mason_output_dir]:

```sh
mason make very_good_app_ui -o ./output_folder
```

[mason_output_dir]: https://docs.brickhub.dev/mason-make#-custom-output-directory
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_ventures_link]: https://verygood.ventures
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows

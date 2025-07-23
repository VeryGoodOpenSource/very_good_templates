# Very Good Dart CLI

[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

[![License: MIT][license_badge]][license_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A Very Good Dart CLI created by Very Good Ventures 🦄.

## What's Included ✨

- ✅ Argument parsing
- ✅ A sample command
- ✅ Colorful logging
- ✅ Automatic update prompts
- ✅ Tab completion for bash and zsh
- ✅ GitHub Workflow powered by [Very Good Workflows][very_good_workflows_link]
- ✅ Strict lint rules powered by [Very Good Analysis][very_good_analysis_link]
- ✅ Dependabot Integration
- ✅ 100% Test Coverage
- ✅ Fully Documented Public API
- ✅ MIT License
- ✅ Changelog

## Output 📦

```sh
├── .github
│   ├── dependabot.yaml
│   └── workflows
│       └── my_cli.yaml
├── .gitignore
├── LICENSE
├── README.md
├── analysis_options.yaml
├── bin
│   └── my_cli.dart
├── coverage_badge.svg
├── dart_test.yaml
├── lib
│   ├── my_cli.dart
│   └── src
│       ├── command_runner.dart
│       ├── commands
│       │   ├── commands.dart
│       │   ├── sample_command.dart
│       │   └── update_command.dart
│       └── version.dart
├── pubspec.yaml
└── test
    ├── ensure_build_test.dart
    └── src
        ├── command_runner_test.dart
        └── commands
            ├── sample_command_test.dart
            └── update_command_test.dart
```

By default `mason make` will generate the output in the current working directory but a custom output directory can be specified via the [-o option][mason_output_dir]:

```sh
mason make very_good_dart_cli -o ./output_folder
```

[mason_output_dir]: https://docs.brickhub.dev/mason-make#-custom-output-directory
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_ventures_link]: https://verygood.ventures
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows

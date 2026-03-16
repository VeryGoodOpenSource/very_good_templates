# Very Good Flutter Plugin

[![Very Good Ventures][logo_white]][very_good_ventures_link]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

[![License: MIT][license_badge]][license_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A Very Good federated Flutter plugin created by Very Good Ventures 🦄.

## What's Included ✨

- ✅ Federated Plugin Architecture
- ✅ Configurable Platforms (Android, iOS, MacOS, Linux, Web, Windows)
- ✅ GitHub Workflow powered by [Very Good Workflows][very_good_workflows_link]
- ✅ Strict lint rules powered by [Very Good Analysis][very_good_analysis_link]
- ✅ Pull Request Template
- ✅ Issue Templates
- ✅ Dependabot Integration
- ✅ 100% Test Coverage
- ✅ Fully Documented Public API
- ✅ MIT License

## Output 📦

```
├── .github
│   ├── ISSUE_TEMPLATE
│   └── workflows
├── my_plugin
│   ├── example
│   │   ├── android
│   │   ├── integration_test
│   │   ├── ios
│   │   ├── lib
│   │   ├── linux
│   │   ├── macos
│   │   ├── test_driver
│   │   ├── web
│   │   └── windows
│   ├── lib
│   └── test
├── my_plugin_android
│   ├── android
│   ├── lib
│   └── test
├── my_plugin_ios
│   ├── ios
│   ├── lib
│   └── test
├── my_plugin_linux
│   ├── lib
│   ├── linux
│   └── test
├── my_plugin_macos
│   ├── lib
│   ├── macos
│   └── test
├── my_plugin_platform_interface
│   ├── lib
│   └── test
├── my_plugin_web
│   ├── lib
│   └── test
├── my_plugin_windows
│   ├── lib
│   └── test
│   └── windows
└── LICENSE  
```

By default `mason make` will generate the output in the current working directory but a custom output directory can be specified via the [-o option][mason_output_dir]:

```sh
mason make very_good_flutter_plugin -o ./output_folder
```

[mason_output_dir]: https://docs.brickhub.dev/mason-make#-custom-output-directory
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_ventures_link]: https://verygood.ventures
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows

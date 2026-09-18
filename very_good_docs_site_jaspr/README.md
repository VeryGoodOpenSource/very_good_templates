# Very Good Docs Site (Jaspr)

[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

[![License: MIT][license_badge]][license_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A Very Good documentation site template powered by [Jaspr][jaspr_link] created by Very Good Ventures 🦄.

This is the all-Dart counterpart to [`very_good_docs_site`][docs_site_link],
which is built on Docusaurus. Generated sites have no Node.js toolchain: no
`package.json`, no npm, and no JavaScript build configuration.

## What's Included ✨

- ✅ GitHub Workflow
- ✅ Pull Request Template
- ✅ Issue Templates
- ✅ Dependabot Integration
- ✅ Light/Dark Mode
- ✅ Landing Page
- ✅ Docs powered by Markdown
- ✅ Filesystem-driven Sidebar
- ✅ Customizable Theming
- ✅ MIT License

## Output 📦

```sh
├── .github
│   ├── ISSUE_TEMPLATE
│   │   └── ...
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── dependabot.yml
│   └── workflows
│       └── main.yaml
├── .gitignore
├── LICENSE
├── README.md
├── analysis_options.yaml
├── content
│   ├── _data
│   │   └── site.yaml
│   ├── docs
│   │   ├── guides
│   │   │   ├── installation.md
│   │   │   └── usage.md
│   │   └── overview.md
│   └── index.md
├── grammars
│   ├── bash.json
│   └── yaml.json
├── lib
│   ├── components
│   │   ├── edit_page_button.dart
│   │   ├── github_icon_link.dart
│   │   ├── site_footer.dart
│   │   └── site_header.dart
│   ├── layouts
│   │   ├── app_docs_layout.dart
│   │   ├── home_layout.dart
│   │   └── site_chrome.dart
│   ├── main.client.dart
│   ├── main.client.options.dart
│   ├── main.server.dart
│   ├── main.server.options.dart
│   └── src
│       ├── auto_sidebar.dart
│       ├── colors.dart
│       └── speculation_rules.dart
├── pubspec.yaml
└── web
    ├── favicon.ico
    └── images
        └── ...
```

## How It Differs From Docusaurus 🔍

| Concern | Docusaurus template | This template |
| --- | --- | --- |
| Toolchain | Node.js, npm | Dart only |
| Config | `docusaurus.config.js` | `content/_data/site.yaml` + `lib/main.server.dart` |
| Sidebar | `sidebars.js` | Generated from the filesystem |
| Landing page | `src/pages/index.tsx` | `lib/layouts/home_layout.dart` |
| Theming | Infima CSS variables | `ColorToken`s in `lib/src/colors.dart` |
| Navigation | Client-side router | Real browser navigation, accelerated by Speculation Rules |

Use the [`-o` flag][mason_output_dir] to generate the site into a specific
directory:

```sh
mason make very_good_docs_site_jaspr -o ./output_folder
```

[mason_output_dir]: https://docs.brickhub.dev/mason-make#-custom-output-directory
[docs_site_link]: https://github.com/VeryGoodOpenSource/very_good_templates/tree/main/very_good_docs_site
[jaspr_link]: https://jaspr.site
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only

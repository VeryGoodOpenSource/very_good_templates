# Very Good Docs Site

[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

[![License: MIT][license_badge]][license_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A Very Good documentation site template powered by [Docusaurus][docusaurus_link] created by Very Good Ventures 🦄.

## What's Included ✨

- ✅ GitHub Workflow
- ✅ Pull Request Template
- ✅ Issue Templates
- ✅ Dependabot Integration
- ✅ Light/Dark Mode
- ✅ Landing Page
- ✅ Docs powered by Markdown
- ✅ Customizable Theming
- ✅ MIT License

## Output 📦

```sh
├── .eslintrc.js
├── .github
│   ├── ISSUE_TEMPLATE
│   │   ├── bug_report.md
│   │   ├── build.md
│   │   ├── chore.md
│   │   ├── ci.md
│   │   ├── config.yml
│   │   ├── documentation.md
│   │   ├── feature_request.md
│   │   ├── performance.md
│   │   ├── refactor.md
│   │   ├── revert.md
│   │   ├── style.md
│   │   └── test.md
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── dependabot.yml
│   └── workflows
│       └── main.yaml
├── .gitignore
├── .prettierignore
├── .prettierrc
├── README.md
├── babel.config.js
├── docs
│   └── overview.md
├── docusaurus.config.js
├── package.json
├── sidebars.js
├── src
│   ├── css
│   │   └── custom.css
│   └── pages
│       ├── index.module.css
│       └── index.tsx
├── static
│   ├── .nojekyll
│   └── img
│       ├── hero.svg
│       ├── hero_dark.svg
│       ├── logo.svg
│       ├── pillar1.svg
│       ├── pillar2.svg
│       └── pillar3.svg
├── tsconfig.json
└── yarn.lock
```

By default `mason make` will generate the output in the current working directory but a custom output directory can be specified via the [-o option][mason_output_dir]:

```sh
mason make very_good_docs_site -o ./output_folder
```

[mason_output_dir]: https://docs.brickhub.dev/mason-make#-custom-output-directory
[docusaurus_link]: https://docusaurus.io
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_ventures_link]: https://verygood.ventures

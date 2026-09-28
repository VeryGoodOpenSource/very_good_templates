# 📚 {{project_name.titleCase()}}

This website is built with [Jaspr][jaspr_link], a web framework for Dart, using
[`jaspr_content`][jaspr_content_link] for its Markdown-driven content pipeline.

### ⚙️ Installation

```sh
dart pub get
```

The Jaspr CLI is a dev dependency, so its version always matches the
framework's. Run it with `dart run jaspr_cli:jaspr`.

### 🧑‍💻 Local Development

```sh
dart run jaspr_cli:jaspr serve
```

This starts a development server on [localhost:8080](http://localhost:8080)
with hot reload.

### 📦 Build

```sh
dart run jaspr_cli:jaspr build
```

This generates static content into the `build/jaspr` directory, which can be
served by any static host. To emit a `sitemap.xml` alongside the pages, pass
your domain:

```sh
dart run jaspr_cli:jaspr build --sitemap-domain=https://example.com
```

The build also regenerates `lib/main.client.options.dart` and
`lib/main.server.options.dart` from the components the site uses. Commit them
whenever they change.

### 🧪 Running Tests

```sh
dart test
```

To collect coverage and view the report, use [Very Good CLI][very_good_cli_link]
and `lcov`:

```sh
very_good test --coverage
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```

### ✍️ Adding Documentation

Add a Markdown file under `content/docs/`. The sidebar is generated from the
filesystem, so no navigation file needs editing:

- Files directly in `content/docs/` form the first, untitled group.
- Each subdirectory becomes a titled group named after the directory.
- `sidebar_position` in the frontmatter orders entries within a group.
- The entry label comes from `title`, falling back to the first `#` heading,
  then to the file name.

```markdown
---
title: My Page
sidebar_position: 2
---

Page content goes here.
```

### 🎨 Customizing

| What | Where |
| --- | --- |
| Site name, tagline, favicon | `content/_data/site.yaml` |
| Colors (light and dark) | `lib/src/colors.dart` |
| Navbar and footer links | `lib/main.server.dart` |
| Landing page hero and pillars | Frontmatter of `content/index.md` |
| Syntax highlighting languages | `grammars/` plus `CodeBlock` in `lib/main.server.dart` |

`grammars/bash.json` is converted from
[atom/language-shellscript][language_shellscript_link] and distributed under
the MIT license in `grammars/LICENSE.md`.

[jaspr_link]: https://jaspr.site
[jaspr_content_link]: https://pub.dev/packages/jaspr_content
[language_shellscript_link]: https://github.com/atom/language-shellscript
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli

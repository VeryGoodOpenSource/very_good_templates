# 📚 {{project_name.titleCase()}}

This website is built with [Jaspr][jaspr_link], a web framework for Dart, using
[`jaspr_content`][jaspr_content_link] for its Markdown-driven content pipeline.

### ⚙️ Installation

```sh
dart pub get
dart pub global activate jaspr_cli
```

### 🧑‍💻 Local Development

```sh
jaspr serve
```

This starts a development server on [localhost:8080](http://localhost:8080)
with hot reload.

### 📦 Build

```sh
jaspr build
```

This generates static content into the `build/jaspr` directory, which can be
served by any static host. To emit a `sitemap.xml` alongside the pages, pass
your domain:

```sh
jaspr build --sitemap-domain=https://example.com
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
| Landing page hero and pillars | `lib/layouts/home_layout.dart` |
| Syntax highlighting languages | `grammars/` plus `CodeBlock` in `lib/main.server.dart` |

[jaspr_link]: https://jaspr.site
[jaspr_content_link]: https://pub.dev/packages/jaspr_content

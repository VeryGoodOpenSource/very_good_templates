---
name: mason
description: >-
  Working with Mason bricks: installing the CLI, creating and consuming bricks,
  understanding brick structure, Mustache template syntax, hooks, and
  discovering bricks on BrickHub.
when_to_use: >-
  Use when creating, modifying, generating, or debugging Mason bricks and
  templates. Also use when asked about brick.yaml, __brick__ templates,
  Mustache syntax, hooks, mason.yaml, or publishing to BrickHub.
allowed-tools: Read Glob Grep Bash
---

# Mason

[Mason](https://github.com/felangel/mason) is a collection of tools that
allow developers to create and consume reusable templates called **bricks**.
[BrickHub](https://brickhub.dev) is the registry where bricks are published
and discovered.

---

## Core Standards

- **All template logic belongs in hooks** — `__brick__/` files use only
  Mustache tags; no conditional logic lives in template files
- **Every brick variable must appear in both `brick.yaml` and `config.json`**
  — a missing key in `config.json` breaks CI generation
- **Never edit `version.txt`, `brick.yaml` version, or `CHANGELOG.md`
  manually** — these are owned by release-please
- **Hook packages require 100% test coverage** — CI enforces this via
  `report_on: "pre_gen.dart"` in each `*_hooks.yaml` workflow
- **Use `{{{variable}}}` (triple braces) when the value must not be
  HTML-escaped** — double braces escape special characters by default

---

## CLI Installation

```bash
# Activate from pub.dev (recommended)
dart pub global activate mason_cli

# Or via Homebrew
brew tap felangel/mason
brew install mason
```

Verify the installation:

```bash
mason --version
```

---

## Workspace Setup

Initialize Mason in a directory to create a `mason.yaml` that tracks
installed bricks:

```bash
mason init
```

Install all bricks listed in `mason.yaml`:

```bash
mason get
```

---

## Consuming Bricks

### Add a brick

```bash
# From BrickHub
mason add very_good_core

# From a local path
mason add my_brick --path ./path/to/brick

# From a Git repository
mason add my_brick --git-url https://github.com/org/repo --git-path bricks/my_brick
```

### Generate code from a brick

```bash
# Interactive prompts for each variable
mason make very_good_core

# Pass variables inline (used in CI via config.json)
mason make very_good_core -c very_good_core/config.json \
  --on-conflict overwrite -o very_good_core_output
```

### List installed bricks

```bash
mason list
```

---

## Brick Structure

```
<brick>/
  __brick__/      # Mustache template files — the generated output
  hooks/          # pre_gen.dart / post_gen.dart + pubspec.yaml + test/
  brick.yaml      # Metadata and variable definitions
  CHANGELOG.md    # Auto-generated — never edit by hand
  LICENSE
  README.md
```

### `brick.yaml`

Defines the brick name, version, and all input variables:

```yaml
name: my_brick
description: A sample brick.
version: 0.1.0+1
environment:
  mason: ">=0.1.0 <0.1.0"
vars:
  project_name:
    type: string
    description: The name of the project.
    default: my_project
    prompt: What is the project name?
  use_flutter:
    type: boolean
    description: Whether to include Flutter dependencies.
    default: true
    prompt: Include Flutter?
```

### Variable Types

| Type      | Description                        | Example                          |
| --------- | ---------------------------------- | -------------------------------- |
| `string`  | A primitive string                 | `"my_project"`                   |
| `number`  | A primitive number                 | `42`                             |
| `boolean` | A primitive boolean                | `true` / `false`                 |
| `enum`    | Single choice from a fixed list    | `["red", "green"]` → `"red"`     |
| `array`   | Multiple choices from a fixed list | `["ios", "android"]` → `["ios"]` |
| `list`    | Open-ended list of strings         | `["dart", "python"]`             |

---

## Mustache Template Syntax

Templates live in `__brick__/` and use
[Mustache](https://mustache.github.io/) syntax.

### Variable interpolation

```
# Hello {{name}}!
```

Use triple braces to skip HTML escaping:

```
{{{raw_html_content}}}
```

### Conditionals

```
{{#use_flutter}}
  flutter:
    sdk: flutter
{{/use_flutter}}

{{^use_flutter}}
# Pure Dart project
{{/use_flutter}}
```

Conditionals also work on file paths — wrap the filename in the brick
variable to generate the file only when the variable is `true`:

```
__brick__/
  {{#create_changelog}}CHANGELOG.md{{/create_changelog}}
```

### Loops

```
{{#platforms}}
- {{.}}
{{/platforms}}
```

### Built-in Lambdas

Apply case transformations directly in templates or file names:

| Lambda          | Example output  | Shorthand syntax                  |
| --------------- | --------------- | --------------------------------- |
| `camelCase`     | `helloWorld`    | `{{name.camelCase()}}`            |
| `pascalCase`    | `HelloWorld`    | `{{name.pascalCase()}}`           |
| `snakeCase`     | `hello_world`   | `{{name.snakeCase()}}`            |
| `paramCase`     | `hello-world`   | `{{name.paramCase()}}`            |
| `constantCase`  | `HELLO_WORLD`   | `{{name.constantCase()}}`         |
| `dotCase`       | `hello.world`   | `{{name.dotCase()}}`              |
| `pathCase`      | `hello/world`   | `{{name.pathCase()}}`             |
| `sentenceCase`  | `Hello world`   | `{{name.sentenceCase()}}`         |
| `titleCase`     | `Hello World`   | `{{name.titleCase()}}`            |
| `lowerCase`     | `hello world`   | `{{name.lowerCase()}}`            |
| `upperCase`     | `HELLO WORLD`   | `{{name.upperCase()}}`            |

Lambdas apply to file names too:

```
__brick__/
  {{name.snakeCase()}}.dart
```

### Partials

Reuse template fragments across files using partials. Partial files are
prefixed with `{{~ }}` and included with `{{> }}`:

```
__brick__/
  HELLO.md
  {{~ header.md }}
  {{~ footer.md }}
```

In `HELLO.md`:

```
{{> header.md }}
Hello {{name}}!
{{> footer.md }}
```

---

## Hooks

Hooks run Dart code before (`pre_gen`) or after (`post_gen`) generation.
All conditional logic and derived variable computation belongs here — never
in `__brick__/` files.

```
hooks/
  pre_gen.dart
  post_gen.dart
  pubspec.yaml
  lib/
  test/
```

### `pre_gen.dart`

```dart
import 'package:mason/mason.dart';

void run(HookContext context) {
  // Read a variable
  final name = context.vars['project_name'] as String;

  // Compute and inject a derived variable
  context.vars['project_name_pascal'] = name.pascalCase;

  // Log to the user
  context.logger.info('Generating $name...');
}
```

### `post_gen.dart`

```dart
import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');
  await Process.run('flutter', ['pub', 'get']);
  progress.complete();
}
```

Disable hooks during generation with `--no-hooks`:

```bash
mason make my_brick --no-hooks
```

---

## Creating a New Brick

```bash
# Scaffold a new brick in the current directory
mason new my_brick

# With a custom description
mason new my_brick --desc "Generates a feature module"

# With hooks scaffolded
mason new my_brick --hooks

# In a specific output directory
mason new my_brick -o ./bricks
```

---

## Discovering Bricks on BrickHub

Search for community bricks at
[brickhub.dev/search](https://brickhub.dev/search) or via the CLI:

```bash
mason search <query>
```

---

## Publishing a Brick

```bash
# Log in to BrickHub
mason login

# Publish the brick in the current directory
mason publish
```

---

## Anti-Patterns

| Anti-Pattern | Problem | Correct Approach |
| --- | --- | --- |
| Putting conditional logic in `__brick__/` files | Mustache is logic-less; complex conditions become unreadable | Move all logic to `pre_gen.dart` and inject derived variables |
| Adding a variable to `brick.yaml` but not `config.json` | CI generation fails with a missing key error | Always keep both files in sync |
| Editing `version.txt` or `CHANGELOG.md` by hand | Breaks the automated release-please workflow | Let release-please manage versioning |
| Using `{{variable}}` for raw HTML or code with `<`, `>`, `&` | Output gets HTML-escaped | Use `{{{variable}}}` for unescaped output |
| Skipping hook tests | CI enforces 100% coverage on hook code | Write tests for every hook code path |

---

## References

- [BrickHub Documentation](https://docs.brickhub.dev)
- [Mason GitHub Repository](https://github.com/felangel/mason)
- [BrickHub Search](https://brickhub.dev/search)
- [Mustache Manual](https://mustache.github.io/mustache.5.html)

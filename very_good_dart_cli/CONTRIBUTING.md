# 🦄 Contributing to Very Good Dart CLI

This CONTRIBUTING file is for a developer that wants to modify or contribute to the Very Good Dart CLI template. If you are interested in solely generating a project using Very Good Dart CLI, please refer to the [README](README.md) file.

## Opening an issue

We highly recommend [creating an issue][bug_report_link] if you have found a bug, want to suggest a feature, or recommend a change. Please do not immediately open a pull request. Opening an issue first allows us to reach an agreement on a fix before you put significant effort into a pull request.

When reporting a bug, please use the built-in [Bug Report][bug_report_link] template and provide as much information as possible, including detailed reproduction steps. Once one of the package maintainers has reviewed the issue and we reach an agreement on the fix, open a pull request.

[bug_report_link]: https://github.com/VeryGoodOpenSource/very_good_templates/labels/product%3A%20very_good_dart_cli

## Developing for Very Good Dart CLI

To develop for Very Good Dart CLI you will need to become familiar with Very Good Ventures processes and conventions:

### Setting up your local development environment

1. Install a valid [Dart SDK](https://dart.dev/get-dart) in your local environment. If you have Flutter installed you'll have the Dart SDK. Compatible Flutter SDK versions with Very Good Dart CLI can be found within the [Flutter release archive](https://docs.flutter.dev/release/archive), ensure it has a Dart version compatible with [Very Good Dart CLI's Dart version constraint](<__brick__/{{project_name.snakeCase()}}/pubspec.yaml>).

2. Install [Mason](https://github.com/felangel/mason/tree/master/packages/mason_cli#installation) in your local environment:

```sh
# 🎯 Activate Mason from https://pub.dev
dart pub global activate mason_cli
```

💡 **Note**: If you're not familiar with Mason, read its [documentation](https://docs.brickhub.dev/) or watch our [Mason Demonstration](https://www.youtube.com/watch?v=G4PTjA6tpTU).

3. Get all bricks in Very Good Dart CLI's `mason.yaml`:

```sh
# 📂 Get all bricks in Very Good Dart CLI (from project root):
mason get
```

4. Generate the template locally:

```sh
# 🧱 Generate a project using the local Very Good Dart CLI version
mason make very_good_dart_cli --config-path very_good_dart_cli/config.json --watch
```

This will generate a project using Very Good Dart CLI under [`very_good_dart_cli_output`](very_good_dart_cli_output) with the variables specified by the [configuration](config.json) file. When any file under [`__brick__`](__brick__/) is changed the project will be regenerated.

### Creating a Pull Request

Before creating a Pull Request please:

1. [Fork](https://docs.github.com/en/get-started/quickstart/contributing-to-projects) the [GitHub repository](https://github.com/VeryGoodOpenSource/very_good_templates) and create your branch from `main`:

```sh
# 🪵 Branch from `main`
git branch <branch-name>
git checkout <branch-name>
```

Where `<branch-name>` is an appropriate name describing your change.

2. Get all bricks in Very Good Dart CLI's `mason.yaml`:

```sh
# 📂 Get all bricks in Very Good Dart CLI (from project root):
mason get
```

3. Generate the template locally:

```sh
# 🧱 Generate a project using the local Very Good Dart CLI brick (from project root)
mason make very_good_dart_cli --config-path very_good_dart_cli/config.json
```

4. Add tests! Pull Requests without 100% test coverage will **not** be merged. If you're unsure on how to do so watch our [Testing Fundamentals Course](https://www.youtube.com/watch?v=M_eZg-X789w&list=PLprI2satkVdFwpxo_bjFkCxXz5RluG8FY).

```sh
# 📊 Generate coverage report (from very_good_dart_cli_output)
dart test -j 4 --coverage=coverage --platform="vm"
dart pub global run coverage:format_coverage --lcov --check-ignore --in=coverage --out=coverage/lcov.info --package="." --report-on="lib"

# 🕸️ Generate a readable HTML website (from very_good_dart_cli_output)
genhtml -o coverage/html coverage/lcov.info

# 👀 Open the coverage report HTML website (from very_good_dart_cli_output)
open coverage/html/index.html
```

5. Ensure the generated project is well formatted:

```sh
# 🧼 Run Dart's formatter (from very_good_dart_cli_output)
dart format lib test --set-exit-if-changed
```

6. Ensure the generated project has no analysis issues:

```sh
# 🔍 Run Dart's analyzer (from very_good_dart_cli_output)
dart analyze --fatal-infos --fatal-warnings .
```

💡 **Note**: Our repositories use [Very Good Analysis](https://github.com/VeryGoodOpenSource/very_good_analysis).

7. Ensure you have a meaningful [semantic](https://www.conventionalcommits.org/en/v1.0.0) commit message.

8. Create the Pull Request with a meaningful description, linking to the original issue where possible.

9. Verify that all [status checks](https://github.com/VeryGoodOpenSource/very_good_templates/actions/workflows/very_good_dart_cli.yaml) are passing for your Pull Request once they have been approved to run by a maintainer.

💡 **Note**: While the prerequisites above must be satisfied prior to having your pull request reviewed, the reviewer(s) may ask you to complete additional work, tests, or other changes before your pull request can be accepted.

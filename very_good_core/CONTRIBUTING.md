# 🦄 Contributing to Very Good Core

This CONTRIBUTING file is for a developer that wants to modify or contribute to the Very Good Core template. If you are interested in solely generating a project using Very Good Core, please refer to the [README](README.md) file.

## Opening an issue

We highly recommend [creating an issue][bug_report_link] if you have found a bug, want to suggest a feature, or recommend a change. Please do not immediately open a pull request. Opening an issue first allows us to reach an agreement on a fix before you put significant effort into a pull request.

When reporting a bug, please use the built-in [Bug Report][bug_report_link] template and provide as much information as possible including detailed reproduction steps. Once one of the package maintainers has reviewed the issue and we reach an agreement on the fix, open a pull request.

[bug_report_link]: https://github.com/VeryGoodOpenSource/very_good_core/issues

## Developing for Very Good Core

To develop for Very Good Core you will need to become familiar with Very Good Ventures processes and conventions:

### Setting up your local development environment

1. Install a valid [Flutter SDK](https://docs.flutter.dev/get-started/install) in your local environment. Compatible Flutter SDK versions with Very Good Core can be found within the [Flutter release archive](https://docs.flutter.dev/release/archive), ensure it has a Dart version compatible with [Very Good Core's Dart version constraint](<brick/__brick__/{{project_name.snakeCase()}}/pubspec.yaml>).

2. Install [Very Good CLI](https://cli.vgv.dev/docs/overview#installing) in your local environment:

```sh
# 🎯 Activate Very Good CLI from https://pub.dev
dart pub global activate very_good_cli
```

3. Install [Mason](https://github.com/felangel/mason/tree/master/packages/mason_cli#installation) in your local environment:

```sh
# 🎯 Activate Mason from https://pub.dev
dart pub global activate mason_cli
```

💡 **Note**: If you're not familiar with Mason, read its [documentation](https://docs.brickhub.dev/) or watch our [Mason Demonstration](https://www.youtube.com/watch?v=G4PTjA6tpTU).

3. Get all bricks in Very Good Core's `mason.yaml`:

```sh
# 📂 Get all bricks in Very Good Core (from project root):
mason get
```

4. Generate the template locally:

```sh
# 🧱 Generate a project using the local Very Good Core version
mason make very_good_core --config-path brick/config.json --output-dir output --watch
```

This will generate a project using Very Good Core under [`output`](output) with the variables specified by the [configuration](brick/config.json) file. When any file under [`__brick__`](brick/__brick__/) is changed.

### Creating a Pull Request

Before creating a Pull Request please:

1. [Fork](https://docs.github.com/en/get-started/quickstart/contributing-to-projects) the [GitHub repository](https://github.com/VeryGoodOpenSource/very_good_core) and create your branch from `main`:

```sh
# 🪵 Branch from `main`
git branch <branch-name>
git checkout <branch-name>
```

Where `<branch-name>` is an appropriate name describing your change.

2. Get all bricks in Very Good Core's `mason.yaml`:

```sh
# 📂 Get all bricks in Very Good Core (from project root):
mason get
```

3. Generate the template locally:

```sh
# 🧱 Generate a project using the local Very Good Core brick (from project root)
mason make very_good_core --config-path brick/config.json --output-dir output
```

4. Add tests! Pull Requests without 100% test coverage will **not** be merged. If you're unsure on how to do so watch our [Testing Fundamentals Course](https://www.youtube.com/watch?v=M_eZg-X789w&list=PLprI2satkVdFwpxo_bjFkCxXz5RluG8FY).

```sh
# 📊 Check code coverage (from output/test_app)
very_good test -x pull-request-only --min-coverage 100
```

Optionally, you can generate a detailed coverage report:

```sh
# 📊 Generate coverage report (from output/test_app)
very_good test -x pull-request-only --coverage

# 🕸️ Generate a readable HTML website (from output/test_app)
genhtml -o coverage/html coverage/lcov.info

# 👀 Open the coverage report HTML website (from output/test_app)
open coverage/html/index.html
```

5. Ensure the generated project is well formatted:

```sh
# 🧼 Run Dart's formatter (from output/test_app)
dart format lib test --set-exit-if-changed
```

6. Analyze the generated project:

```sh
# 🔍 Run Dart's analyzer (from output/test_app)
dart analyze --fatal-infos --fatal-warnings .
```

💡 **Note**: Our repositories use [Very Good Analysis](https://github.com/VeryGoodOpenSource/very_good_analysis).

7. Ensure you have a meaningful [semantic](https://www.conventionalcommits.org/en/v1.0.0) commit message.

8. Create the Pull Request with a meaningful description, linking to the original issue where possible.

9. Verify that all [status checks](https://github.com/VeryGoodOpenSource/very_good_core/actions/) are passing for your Pull Request once they have been approved to run by a maintainer.

💡 **Note**: While the prerequisites above must be satisfied prior to having your pull request reviewed, the reviewer(s) may ask you to complete additional work, tests, or other changes before your pull request can be accepted.


## Releasing a new version

1. Ensure your local `main` branch is up to date with the remote `main` branch:

```sh
git checkout main
git pull origin main
git status
```

2. Ensure the current pipeline is passing on the `main` branch, [here](https://github.com/VeryGoodOpenSource/very_good_core/actions/workflows/very_good_core.yaml?query=branch%3Amain).

3. From the repository, run the script to release a new version:

```sh
./tool/release_ready.sh <new-version>

git commit -m "chore: v<new-version>"
```

This script will:
- Create a new branch named `chore/v<new-version>`
- Update the version info on `brick/brick.yaml`
- Update the version info on `brick/CHANGELOG.md`
- Then commit those changes with the message `chore: v<new-version>`

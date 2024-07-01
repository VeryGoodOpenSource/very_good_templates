# 🪢 Dependency tightener

Script that ensures all the packages in the directory have tight dependencies.

Tightening dependencies refers to process of assigning version constraints such that the constraints are as high as possible.

For example if a package has a dependency on `my_package: ^2.1.0` and the latest version of `my_package` is `2.3.0`, the dependency will be updated to `my_package: ^2.3.0`.

To use the tool, run:

```sh
dart bin/dependency_tightener.dart --directory path/to/directory
```

The `--directory` flag is optional and defaults to the current directory. If provided the tool will only update the dependencies in the provided directory.

## When should I use this tool?

The use-case of this script is to update the dependencies in a `pubspec.yaml` file that has a broken syntax due to templated [Mustache variables](https://mustache.github.io/mustache.5.html). Such YAML files are not considered to be a valid `pubspec.yaml`s by popular toolings like the [Dart dev tooling](https://github.com/dart-lang/sdk/tree/main/pkg/dartdev) or [Dependabot](https://github.com/dependabot).

Although the tool works for non-templated `pubspec.yaml` files, if you want to tighten those dependencies, consider using `dart pub update --tighten`, which is a command provided by the [Dart dev tooling](https://github.com/dart-lang/sdk/tree/main/pkg/dartdev) (available in [Dart SDK](https://github.com/dart-lang/sdk)). Such command is most likely to be more in sync with the latest Dart ecosystem.

Alternatively, if you would like to update dependencies within your GitHub CI on non-templated `pubspec.yaml` files consider using [Dependabot](https://github.com/dependabot). The Dependabot ecosystem provides a more robust solution for updating dependencies in a CI environment, with
the bot being able to not only create pull requests for you, but also rebase upon request, report the CHANGELOGS of the updated packages, and more.

💡 **Note**: The dependency tightener tooling is bespoke to the Very Good Templates repository and is a first iteration to helping automate tightening dependencies in an `pubspec.yaml` with invalid syntax due to templated [Mustache variables](https://mustache.github.io/mustache.5.html).

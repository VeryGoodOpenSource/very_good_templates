# 🪢 Dependency tightener

Script that ensures all the packages in the directory have tight dependencies.

Tightening dependencies refers to process of assigning version constraints such that the constraints are as high as possible.

## When should I use this tool?

The use-case of this script is to update the dependencies in a `pubspec.yaml` file that has a broken syntax due to templated [Mustache variables](https://mustache.github.io/mustache.5.html). Such YAML files are not considered to be a valid `pubspec.yaml`s by popular toolings like the [Dart dev tooling](https://github.com/dart-lang/sdk/tree/main/pkg/dartdev) or [Dependabot](https://github.com/dependabot).

Although the tool works for non-templated `pubspec.yaml` files, if you want to tighten those dependencies, consider using `dart pub update --tighten`, which is a command provided by the [Dart dev tooling](https://github.com/dart-lang/sdk/tree/main/pkg/dartdev) (available in [Dart SDK](https://github.com/dart-lang/sdk)). Such command is most likely to be more in sync with the latest Dart ecosystem.

Alternatively, if you would like to update dependencies within your GitHub CI on non-templated `pubspec.yaml` files consider using [Dependabot](https://github.com/dependabot). The Dependabot ecosystem provides a more robust solution for updating dependencies in a CI environment, with
the bot being able to not only create pull requests for you, but also rebase upon request, report the CHANGELOGS of the updated packages, and more.

💡 **Note**: The dependency tightener tooling is bespoke to the Very Good Templates repository and is a first iteration to helping automate tightening dependencies in an `pubspec.yaml` with invalid syntax due to templated [Mustache variables](https://mustache.github.io/mustache.5.html).

## Usage 🚀

```sh
dart bin/dependency_tightener.dart --directory path/to/directory
```

**Arguments:**
The `--directory` flag is optional and defaults to the current directory. If provided the tool will only update the dependencies in the provided directory.

### Output

The script will overwrite the `pubspec.yaml` files in the directory with tightened dependencies.

For example if `path/to/directory` contains a `pubspec.yaml` file with the following dependencies:

```none
dependencies:
{{#my_variable}  my_package: ^2.1.0{{/my_variable}}
  another_package: 1.0.0
```

If a newer version (`2.3.0`) of `my_package` is available and a newer version (`2.0.0`) of `another_package` is available, the script will update the `pubspec.yaml` file to:

```yaml
dependencies:
  {{#my_variable}  my_package: ^2.3.0{{/my_variable}}
  another_package: ^2.0.0
```

💡 **Note**: The script will replace the previous versions with a version constraint range that is tightened to the latest version. It will always use the [caret syntax](https://dart.dev/tools/pub/dependencies#caret-syntax), even if the previous version was pinned.

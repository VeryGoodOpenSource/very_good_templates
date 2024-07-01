import 'package:dependency_tightener/src/pubspec_parse.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:test/test.dart';

import '../fixtures/pubspec_fixtures/pubspec_fixtures.dart';

void main() {
  test('parses templated pubspec', () async {
    final dependencies = parseDirectDependencies(pubspec1);

    expect(dependencies, hasLength(2));

    expect(
      dependencies,
      containsAll({
        HostedDependency(
          version: VersionConstraint.parse('^2.1.0'),
          hosted: HostedDetails('plugin_platform_interface', null),
        ),
        HostedDependency(
          version: VersionConstraint.parse('^5.1.0'),
          hosted: HostedDetails('very_good_analysis', null),
        ),
      }),
    );
  });
}

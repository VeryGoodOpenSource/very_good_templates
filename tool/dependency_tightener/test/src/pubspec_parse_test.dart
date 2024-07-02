import 'package:dependency_tightener/src/graceful_pubspec_parse.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:test/test.dart';

import '../fixtures/fixtures.dart';

void main() {
  test('parses templated pubspec', () async {
    final dependencies = parseDirectHostedDependencies(pubspec1);

    expect(
      dependencies,
      containsAll({
        HostedDependency(
          version: VersionConstraint.parse('^2.1.0'),
          hosted: HostedDetails('plugin_platform_interface', null),
        ),
        HostedDependency(
          version: VersionConstraint.parse('0.3.0'),
          hosted: HostedDetails('pub_updater', null),
        ),
        HostedDependency(
          version: VersionConstraint.parse('^1.0.3'),
          hosted: HostedDetails('mocktail', null),
        ),
        HostedDependency(
          version: VersionConstraint.parse('^5.1.0'),
          hosted: HostedDetails('very_good_analysis', null),
        ),
      }),
    );
  });
}

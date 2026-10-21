import 'dart:io';

import 'package:jaspr_content/components/sidebar.dart';
import 'package:test/test.dart';
import 'package:{{project_name.snakeCase()}}/src/auto_sidebar.dart';

void main() {
  group('buildSidebarGroups', () {
    late Directory docs;

    setUp(() {
      docs = Directory.systemTemp.createTempSync('auto_sidebar_test');
      addTearDown(() => docs.deleteSync(recursive: true));
    });

    void writePage(String path, String content) {
      File('${docs.path}/$path')
        ..createSync(recursive: true)
        ..writeAsStringSync(content);
    }

    List<SidebarGroup> build() => buildSidebarGroups(directory: docs.path);

    List<(String, String)> linksOf(SidebarGroup group) => [
      for (final link in group.links) (link.text, link.href),
    ];

    test('returns no groups when the directory does not exist', () {
      expect(buildSidebarGroups(directory: '${docs.path}/missing'), isEmpty);
    });

    test('returns no groups when the directory has no markdown', () {
      writePage('notes.txt', 'Not a page.');
      writePage('guides/notes.txt', 'Not a page either.');

      expect(build(), isEmpty);
    });

    test('puts top-level pages in a first, untitled group', () {
      writePage('overview.md', '---\ntitle: Overview\n---\n');
      writePage('guides/setup.md', '---\ntitle: Setup\n---\n');

      final groups = build();

      expect(groups, hasLength(2));
      expect(groups.first.title, isNull);
      expect(linksOf(groups.first), equals([('Overview', '/docs/overview')]));
    });

    test('turns each subdirectory into a group with a title-cased name', () {
      writePage('getting-started/setup.md', '---\ntitle: Setup\n---\n');
      writePage('api_reference/client.md', '---\ntitle: Client\n---\n');

      expect(build().map((group) => group.title), [
        'Api Reference',
        'Getting Started',
      ]);
    });

    test('flattens nested pages into their top-level group', () {
      writePage('guides/advanced/tuning.md', '---\ntitle: Tuning\n---\n');

      final guides = build().single;

      expect(
        linksOf(guides),
        equals([('Tuning', '/docs/guides/advanced/tuning')]),
      );
    });

    test('skips directories starting with an underscore or a dot', () {
      writePage('_drafts/wip.md', '---\ntitle: WIP\n---\n');
      writePage('.hidden/secret.md', '---\ntitle: Secret\n---\n');

      expect(build(), isEmpty);
    });

    test('includes mdx pages', () {
      writePage('interactive.mdx', '---\ntitle: Interactive\n---\n');

      expect(
        linksOf(build().single),
        equals([('Interactive', '/docs/interactive')]),
      );
    });

    test('links index pages to their directory', () {
      writePage('index.md', '---\ntitle: Home\n---\n');
      writePage('guides/index.md', '---\ntitle: Guides\n---\n');

      final groups = build();

      expect(linksOf(groups.first), equals([('Home', '/docs')]));
      expect(linksOf(groups.last), equals([('Guides', '/docs/guides')]));
    });

    group('orders entries', () {
      test('by sidebar_position', () {
        writePage('b.md', '---\ntitle: B\nsidebar_position: 1\n---\n');
        writePage('a.md', '---\ntitle: A\nsidebar_position: 2\n---\n');

        expect(build().single.links.map((link) => link.text), ['B', 'A']);
      });

      test('with entries lacking a position after positioned ones', () {
        writePage('a.md', '---\ntitle: A\n---\n');
        writePage('z.md', '---\ntitle: Z\nsidebar_position: 1\n---\n');
        writePage('m.md', '---\ntitle: M\n---\n');

        expect(build().single.links.map((link) => link.text), ['Z', 'A', 'M']);
      });

      test('alphabetically by title when positions tie', () {
        writePage('one.md', '---\ntitle: Beta\nsidebar_position: 1\n---\n');
        writePage('two.md', '---\ntitle: Alpha\nsidebar_position: 1\n---\n');

        expect(build().single.links.map((link) => link.text), [
          'Alpha',
          'Beta',
        ]);
      });

      test('ignoring a non-integer sidebar_position', () {
        writePage('a.md', '---\ntitle: A\nsidebar_position: first\n---\n');
        writePage('b.md', '---\ntitle: B\nsidebar_position: 1\n---\n');

        expect(build().single.links.map((link) => link.text), ['B', 'A']);
      });
    });

    group('labels entries', () {
      test('with the frontmatter title', () {
        writePage('page.md', '---\ntitle: "Quoted: Title" # comment\n---\n');

        expect(build().single.links.single.text, equals('Quoted: Title'));
      });

      test('with a non-string frontmatter title as text', () {
        writePage('page.md', '---\ntitle: 2026\n---\n');

        expect(build().single.links.single.text, equals('2026'));
      });

      test('with the first heading when there is no title', () {
        writePage('page.md', '---\nsidebar_position: 1\n---\n# From Heading\n');

        expect(build().single.links.single.text, equals('From Heading'));
      });

      test('with the first heading when there is no frontmatter', () {
        writePage('page.md', 'Intro.\n\n# First\n\n# Second\n');

        expect(build().single.links.single.text, equals('First'));
      });

      test('with the title-cased file name as a last resort', () {
        writePage('getting-started_guide.md', 'No heading here.\n');

        expect(
          build().single.links.single.text,
          equals('Getting Started Guide'),
        );
      });

      test('ignoring an unterminated frontmatter block', () {
        writePage('page.md', '---\ntitle: Never Closed\n# Heading\n');

        expect(build().single.links.single.text, equals('Heading'));
      });

      test('ignoring frontmatter that is not a map', () {
        writePage('page.md', '---\n- a\n- b\n---\n# Heading\n');

        expect(build().single.links.single.text, equals('Heading'));
      });
    });
  });
}

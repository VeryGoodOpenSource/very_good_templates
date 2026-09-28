/// Builds [SidebarGroup]s automatically from the markdown files on disk, so
/// adding a page never requires editing a navigation file.
///
/// This only runs on the server during pre-rendering (static mode), so
/// `dart:io` is safe to use here. It must never be imported from
/// `main.client.dart` or any `@client` component.
library;

import 'dart:io';

import 'package:jaspr_content/components/sidebar.dart';
import 'package:yaml/yaml.dart';

/// Scans [directory] for markdown files and builds sidebar groups.
///
/// - Files directly inside [directory] form the first (untitled) group.
/// - Each immediate subdirectory becomes a titled group (title-cased name),
///   containing all markdown files below it (flattened — jaspr_content's
///   sidebar supports a single level of nesting).
/// - Entries are ordered by the `sidebar_position` frontmatter key when
///   present, then alphabetically by title.
/// - Entry text comes from the `title` frontmatter key, falling back to the
///   first `# ` heading, then to the title-cased file name.
List<SidebarGroup> buildSidebarGroups({
  String directory = 'content/docs',
  String urlPrefix = '/docs',
}) {
  final root = Directory(directory);
  if (!root.existsSync()) return [];

  final rootEntries = <_SidebarEntry>[];
  final groups = <SidebarGroup>[];

  final children = root.listSync()..sort((a, b) => a.path.compareTo(b.path));

  for (final child in children) {
    if (child is File && _isMarkdown(child.path)) {
      rootEntries.add(_entryFor(child, root, urlPrefix));
    }
  }

  if (rootEntries.isNotEmpty) {
    groups.add(SidebarGroup(links: _sortedLinks(rootEntries)));
  }

  for (final child in children) {
    if (child is! Directory) continue;
    final dirName = child.uri.pathSegments.lastWhere((s) => s.isNotEmpty);
    if (dirName.startsWith('_') || dirName.startsWith('.')) continue;

    final entries = child
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => _isMarkdown(f.path))
        .map((f) => _entryFor(f, root, urlPrefix))
        .toList();

    if (entries.isNotEmpty) {
      groups.add(
        SidebarGroup(title: _titleCase(dirName), links: _sortedLinks(entries)),
      );
    }
  }

  return groups;
}

class _SidebarEntry {
  const _SidebarEntry({
    required this.title,
    required this.href,
    required this.position,
  });

  final String title;
  final String href;

  /// The `sidebar_position` frontmatter value, or `null` when unset.
  final int? position;
}

final _markdownExtension = RegExp(r'\.mdx?$');
final _firstHeadingPattern = RegExp(r'^# (.+)$', multiLine: true);
final _wordSeparator = RegExp('[_-]');

bool _isMarkdown(String path) => _markdownExtension.hasMatch(path);

List<SidebarLink> _sortedLinks(List<_SidebarEntry> entries) {
  entries.sort((a, b) {
    final byPosition = switch ((a.position, b.position)) {
      (final int a, final int b) => a.compareTo(b),
      // Entries with no `sidebar_position` sort after positioned ones.
      (int(), null) => -1,
      (null, int()) => 1,
      (null, null) => 0,
    };
    return byPosition != 0 ? byPosition : a.title.compareTo(b.title);
  });
  return [
    for (final entry in entries)
      SidebarLink(text: entry.title, href: entry.href),
  ];
}

_SidebarEntry _entryFor(File file, Directory root, String urlPrefix) {
  final (:frontmatter, :body) = _splitFrontmatter(file.readAsStringSync());

  var relative = file.path
      .substring(root.path.length)
      .replaceAll(r'\', '/')
      .replaceFirst(_markdownExtension, '');
  if (relative.startsWith('/')) relative = relative.substring(1);
  if (relative == 'index' || relative.endsWith('/index')) {
    relative = relative.substring(0, relative.length - 'index'.length);
    if (relative.endsWith('/')) {
      relative = relative.substring(0, relative.length - 1);
    }
  }

  final fileName = relative.split('/').last;
  final title = switch (frontmatter['title']) {
    final Object title => '$title',
    null => _firstHeading(body) ?? _titleCase(fileName),
  };
  final position = switch (frontmatter['sidebar_position']) {
    final int position => position,
    _ => null,
  };

  final href = relative.isEmpty ? urlPrefix : '$urlPrefix/$relative';
  return _SidebarEntry(title: title, href: href, position: position);
}

/// Splits [content] into its parsed YAML frontmatter and the body below it.
///
/// Content with no frontmatter block, or with one that is not a YAML map,
/// yields empty frontmatter and the unchanged content as the body.
({Map<Object?, Object?> frontmatter, String body}) _splitFrontmatter(
  String content,
) {
  final lines = content.split('\n');
  final closing = lines.first.trim() == '---'
      ? lines.indexWhere((line) => line.trim() == '---', 1)
      : -1;
  if (closing == -1) return (frontmatter: const {}, body: content);

  final yaml = loadYaml(lines.getRange(1, closing).join('\n'));
  return (
    frontmatter: yaml is Map ? yaml : const {},
    body: lines.skip(closing + 1).join('\n'),
  );
}

String? _firstHeading(String content) {
  final match = _firstHeadingPattern.firstMatch(content);
  return match?.group(1)?.trim();
}

String _titleCase(String value) => value
    .split(_wordSeparator)
    .where((word) => word.isNotEmpty)
    .map((word) => word[0].toUpperCase() + word.substring(1))
    .join(' ');

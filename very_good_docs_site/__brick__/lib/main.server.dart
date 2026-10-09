import 'dart:io';

import 'package:jaspr/server.dart';
import 'package:jaspr_content/components/callout.dart';
import 'package:jaspr_content/components/code_block.dart';
import 'package:jaspr_content/components/image.dart';
import 'package:jaspr_content/components/sidebar.dart';
import 'package:jaspr_content/components/theme_toggle.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';

import 'package:{{project_name.snakeCase()}}/components/edit_page_button.dart';
import 'package:{{project_name.snakeCase()}}/components/github_icon_link.dart';
import 'package:{{project_name.snakeCase()}}/components/site_footer.dart';
import 'package:{{project_name.snakeCase()}}/components/site_header.dart';
import 'package:{{project_name.snakeCase()}}/layouts/app_docs_layout.dart';
import 'package:{{project_name.snakeCase()}}/layouts/home_layout.dart';
import 'package:{{project_name.snakeCase()}}/main.server.options.dart';
import 'package:{{project_name.snakeCase()}}/src/auto_sidebar.dart';
import 'package:{{project_name.snakeCase()}}/src/colors.dart';

/// The GitHub repository the generated site belongs to, used for the header
/// link and the per-page "Edit this page" links.
const repo = '{{{org_name}}}/{{project_name.snakeCase()}}';

/// The route of the docs entry page, linked from the navbar, the footer, and
/// the landing page's call to action.
const docsEntryRoute = '/docs/overview';

void main() {
  Jaspr.initializeApp(options: defaultServerOptions);

  const navLinks = [(label: 'Overview', href: docsEntryRoute)];

  SiteHeader buildHeader({required bool showSidebarToggle}) => SiteHeader(
    logo: '/images/logo.svg',
    leftItems: navLinks,
    rightItems: const [
      ThemeToggle(),
      GitHubIconLink(repo: repo),
    ],
    showSidebarToggle: showSidebarToggle,
  );

  const footer = SiteFooter(
    columns: [
      (title: 'Docs', links: navLinks),
      (title: 'Resources', links: [(label: 'Blog', href: '#')]),
      (
        title: 'More',
        links: [(label: 'GitHub', href: 'https://github.com/$repo')],
      ),
    ],
  );

  runApp(
    ContentApp(
      parsers: const [MarkdownParser()],
      extensions: [HeadingAnchorsExtension(), const TableOfContentsExtension()],
      components: [
        Callout(),
        CodeBlock(
          grammars: {
            'bash': File('grammars/bash.json').readAsStringSync(),
            'yaml': File('grammars/yaml.json').readAsStringSync(),
          },
        ),
        const Image(zoom: true),
      ],
      layouts: [
        AppDocsLayout(
          header: buildHeader(showSidebarToggle: true),
          sidebar: Sidebar(groups: buildSidebarGroups()),
          footer: const EditPageButton(
            editUrlBase: 'https://github.com/$repo/edit/main/content',
          ),
          siteFooter: footer,
        ),
        HomeLayout(
          header: buildHeader(showSidebarToggle: false),
          siteFooter: footer,
          cta: (label: 'Get Started', href: docsEntryRoute),
        ),
      ],
      theme: ContentTheme(primary: AppColors.primary, colors: AppColors.tokens),
    ),
  );
}

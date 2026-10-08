import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_test/server_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRouteLoader extends Mock implements RouteLoader;

/// Builds a [Page] carrying [data], the way `ContentApp` would after loading
/// the page's frontmatter and the `content/_data` files.
Page buildPage({
  String path = 'index.md',
  Map<String, Object?> data = const {},
}) {
  return Page(
    path: path,
    url: '/',
    content: '',
    initialData: data,
    config: const PageConfig(),
    loader: _MockRouteLoader(),
  );
}

extension RenderComponent on ServerTester {
  /// Renders [component] on the server as part of [page], so it can read
  /// `context.page`, and returns the resulting document.
  Future<DocumentResponse> render(Component component, {Page? page}) {
    final contextPage = page ?? buildPage();
    pumpComponent(Page.wrap(contextPage, [contextPage], component));
    return request('/');
  }

  /// Renders [styles] the way the build writes them to the site stylesheet,
  /// and returns the resulting CSS.
  Future<String> renderCss(List<StyleRule> styles) async {
    final response = await render(Style(styles: styles));
    return response.document!.querySelector('style')!.text;
  }
}

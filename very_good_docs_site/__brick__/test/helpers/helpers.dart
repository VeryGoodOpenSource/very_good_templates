import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_test/server_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRouteLoader extends Mock implements RouteLoader;

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
  Future<DocumentResponse> render(Component component, {Page? page}) {
    final contextPage = page ?? buildPage();
    pumpComponent(Page.wrap(contextPage, [contextPage], component));
    return request('/');
  }

  Future<String> renderCss(List<StyleRule> styles) async {
    final response = await render(Style(styles: styles));
    return response.document!.querySelector('style')!.text;
  }
}

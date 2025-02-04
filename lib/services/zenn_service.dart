import 'package:http/http.dart' as http;
import 'dart:convert';

class ZennService {
  static final ZennService _instance = ZennService._internal();

  factory ZennService() {
    return _instance;
  }

  ZennService._internal();

  Future<String> fetchArticles({
    required String zennAccount,
  }) async {
    // Zennの投稿一覧を取得
    final articleList = await fetchPosts(zennAccount: zennAccount);

    // 投稿一覧から投稿を取得
    String articleText = '';
    for (final articleId in articleList) {
      final article = await fetchArticle(articleId: articleId);
      articleText += article;
    }

    return articleText;
  }

  Future<List<String>> fetchPosts({
    required String zennAccount,
  }) async {
    final apiArticlesUrl =
        'https://zenn.dev/api/articles?page=1&username=$zennAccount&count=96&order=latest';
    final response = await http.post(
        Uri.parse('https://api-ej5rtjryya-uc.a.run.app/proxy'),
        body: {'url': apiArticlesUrl});
    // final response = await http.get(Uri.parse(apiArticlesUrl));
    final responseBody = jsonDecode(response.body);
    final List<dynamic> articleList = responseBody['articles'] as List<dynamic>;

    return articleList.map((article) => article['slug'].toString()).toList();
  }

  Future<String> fetchArticle({
    required String articleId,
  }) async {
    final apiArticleUrl = 'https://zenn.dev/api/articles/$articleId';
    final response = await http.post(
        Uri.parse('https://api-ej5rtjryya-uc.a.run.app/proxy'),
        body: {'url': apiArticleUrl});
    if (response.statusCode != 200) {
      //throw Exception('記事の読み込みに失敗しました');
      return '';
    }

    final responseBody = jsonDecode(response.body);
    final article = responseBody['article'] as Map<String, dynamic>;

    // body_htmlを取得
    final String bodyHtml = article['body_html'] ?? '';
    // HTML部分を除去
    final String plainText = removeHtmlTags(bodyHtml);

    return plainText;
  }

  String removeHtmlTags(String html) {
    final RegExp exp =
        RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return html.replaceAll(exp, '');
  }
}

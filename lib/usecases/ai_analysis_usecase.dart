import 'package:http/http.dart' as http;

class AiAnalysisUseCase {
  static final AiAnalysisUseCase _instance = AiAnalysisUseCase._internal();

  factory AiAnalysisUseCase() {
    return _instance;
  }

  AiAnalysisUseCase._internal();

  final fetchUrl = '${const String.fromEnvironment('BASE_URL')}/ask-gemini';

  Future<String> generateContent({
    required String desiredLevel,
    required String futureImage,
    required String zennAccount,
  }) async {
    final response = await http.post(
      Uri.parse(fetchUrl),
      body: {
        'desiredLevel': desiredLevel,
        'futureImage': futureImage,
        'zennAccount': zennAccount,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('AIからの応答に失敗しました。ステータスコード: ${response.statusCode}');
    }

    try {
      final responseBody = response.body;
      // レスポンスから引用符を削除
      final content = responseBody.replaceAll('"', '').replaceAll(r'\n', '\n');
      return content;
    } catch (e) {
      throw Exception('AIからのレスポンスの解析に失敗しました: $e');
    }
  }
}

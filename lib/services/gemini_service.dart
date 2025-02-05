import 'package:http/http.dart' as http;

class GeminiService {
  static final GeminiService _instance = GeminiService._internal();

  factory GeminiService() {
    return _instance;
  }

  GeminiService._internal();

  final fetchUrl = '${const String.fromEnvironment('BASE_URL')}/ask-gemini';

  Future<String> generateContent({
    required String prompt,
  }) async {
    final response = await http.post(
      Uri.parse(fetchUrl),
      body: {'prompt': prompt},
    );
    final responseBody = response.body;
    // レスポンスから引用符を削除
    final content = responseBody.replaceAll('"', '').replaceAll(r'\n', '\n');
    return content;
  }
}

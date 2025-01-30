import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static final GeminiService _instance = GeminiService._internal();

  factory GeminiService() {
    return _instance;
  }

  GeminiService._internal();

  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
  );

  Future<String> generateContent({
    required String prompt,
  }) async {

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? '結果を生成できませんでした。';
  }
}

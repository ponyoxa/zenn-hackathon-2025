import '../services/zenn_service.dart';
import '../services/prompt_service.dart';
import '../services/gemini_service.dart';

class AiAnalysisUseCase {
  static final AiAnalysisUseCase _instance = AiAnalysisUseCase._internal();

  factory AiAnalysisUseCase() {
    return _instance;
  }

  AiAnalysisUseCase._internal();

  final zennService = ZennService();
  final promptService = PromptService();
  final geminiService = GeminiService();

  Future<String> generateContent({
    required String desiredLevel,
    required String futureImage,
    required String zennAccount,
  }) async {
    // Zennの投稿を取得
    final zennArticles =
        await zennService.fetchArticles(zennAccount: zennAccount);

    // プロンプトを生成
    final prompt = promptService.generatePrompt(
      desiredLevel: desiredLevel,
      futureImage: futureImage,
      zennArticles: zennArticles,
    );

    // プロンプトをGeminiに送信
    final response = await geminiService.generateContent(prompt: prompt);

    return response;
  }
}

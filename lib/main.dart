import 'package:flutter/material.dart';
import 'package:zenn_hackthon_2025/inputData.dart';
import 'package:zenn_hackthon_2025/widgets/three_rotating_dots.dart';

// グローバルなローディング状態
final loadingNotifier = ValueNotifier<bool>(false);

void main() {
  runApp(const IndividualityAiAgentApp());
}

class IndividualityAiAgentApp extends StatelessWidget {
  const IndividualityAiAgentApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Individuality AI Agent 😊',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 168, 154, 190)),
        useMaterial3: true,
      ),
      home: Stack(
        children: [
          const InputData(title: 'Individuality AI Agent'),
          // ローディングオーバーレイ
          ValueListenableBuilder<bool>(
            valueListenable: loadingNotifier,
            builder: (context, isLoading, child) {
              return isLoading
                  ? Container(
                      color: Colors.white.withAlpha(128),
                      child: Center(
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48.0,
                              vertical: 32.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ThreeRotatingDots(
                                  color1:
                                      const Color.fromARGB(255, 135, 216, 239),
                                  color2:
                                      const Color.fromARGB(255, 166, 237, 193),
                                  color3:
                                      const Color.fromARGB(255, 227, 131, 221),
                                  size: 80,
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  '分析中...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

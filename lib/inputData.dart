import 'package:flutter/material.dart';
import 'result.dart';
import 'services/gemini_service.dart';

class InputData extends StatefulWidget {
  const InputData({super.key, required this.title});

  final String title;

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _zennController = TextEditingController();
  final _geminiService = GeminiService();
  bool _isAgreed = false; // 同意状態を管理する変数
  int _selectedLevel = 1; // 初期選択レベルを1に設定

  final List<Map<String, dynamic>> _levels = [
    {'value': 1, 'label': 'レベル1: 指導下で作業ができる'},
    {'value': 2, 'label': 'レベル2: 指導下で一部独力でできる'},
    {'value': 3, 'label': 'レベル3: 要求の作業を独力でできる'},
    {'value': 4, 'label': 'レベル4: 専門スキルがある'},
    {'value': 5, 'label': 'レベル5: 社内でリードできる'},
    {'value': 6, 'label': 'レベル6: 国内のハイエンドプレーヤ'},
    {'value': 7, 'label': 'レベル7: 世界で通用するプレーヤ'},
  ];

  Future<void> _generateResult() async {
    try {
      // final result = await _geminiService.generateContent(
      //   imageText: _imageController.text,
      //   zennAccount: _zennController.text,
      // );

      // if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Result(
            title: '結果',
            // resultText: result,
            resultText: 'test',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラーが発生しました: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg.jpeg'), // 背景画像のパス
          fit: BoxFit.cover, // 画面全体を覆う
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Scaffoldの背景色を透明に設定
        appBar: AppBar(
          //title: Text(widget.title),
          backgroundColor: Colors.transparent, // AppBarも透明に設定
          elevation: 0, // AppBarの影をなくす
        ),
        body: Stack(
          children: [
            // 背景画像と透明なScaffold
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bg.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // タイトルを中央寄せ
                        Center(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // 目指すレベルのセレクトボックス
                        const Text(
                          '目指すレベル',
                        ),

                        Card(
                          color: Color.fromARGB(255, 223, 223, 223),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: DropdownButton<int>(
                              value: _selectedLevel,
                              items: _levels.map((level) {
                                return DropdownMenuItem<int>(
                                  value: level['value'],
                                  child: Text(level['label']),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedLevel = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('なりたいイメージ'),
                        Card(
                          color: Color.fromARGB(255, 223, 223, 223),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _imageController,
                              maxLines: 5,
                              decoration: InputDecoration.collapsed(
                                hintText: "なりたいイメージを入力してください",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('zenn アカウントID'),
                        Card(
                          color: Color.fromARGB(255, 223, 223, 223),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _zennController,
                              maxLines: 1,
                              decoration: InputDecoration.collapsed(
                                hintText: "@の後ろのユーザ名を入力してください",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(), // コンテンツとフッターの間にスペースを挿入
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: _isAgreed,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isAgreed = value ?? false;
                                });
                              },
                            ),
                            const Text(
                              'アウトプットをAIが読み込むことに同意する',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _isAgreed ? _generateResult : null,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                          ),
                          child: const Text(
                            'AIに他己分析してもらう',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _imageController.dispose();
    _zennController.dispose();
    super.dispose();
  }
}

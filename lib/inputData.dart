import 'package:flutter/material.dart';
import 'result.dart';
import 'usecases/ai_analysis_usecase.dart';

class InputData extends StatefulWidget {
  const InputData({super.key, required this.title});

  final String title;

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  final TextEditingController _futureImageController = TextEditingController();
  final TextEditingController _zennAccountController = TextEditingController();
  final String _desiredLevel = '1';
  String _futureImage = '';
  String _zennAccount = '';
  final _aiAnalysis = AiAnalysisUseCase();

  @override
  void initState() {
    super.initState();
    _futureImageController.addListener(() {
      setState(() => _futureImage = _futureImageController.text);
    });
    _zennAccountController.addListener(() {
      setState(() => _zennAccount = _zennAccountController.text);
    });
  }

  Future<void> _generateResult() async {
    try {
      final result = await _aiAnalysis.generateContent(
        desiredLevel: _desiredLevel,
        futureImage: _futureImage,
        zennAccount: _zennAccount,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Result(
            title: '結果',
            resultText: result,
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('なりたいイメージ'),
              Card(
                color: Color.fromARGB(255, 223, 223, 223),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _futureImageController,
                    maxLines: 5,
                    decoration: InputDecoration.collapsed(
                      hintText: "なりたいイメージを入力してください",
                    ),
                  ),
                ),
              ),
              Text('zenn アカウント'),
              Card(
                color: Color.fromARGB(255, 223, 223, 223),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _zennAccountController,
                    maxLines: 1,
                    decoration: InputDecoration.collapsed(
                      hintText: "Zennのアカウント名を入力してください",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateResult,
        tooltip: '生成',
        child: const Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    _futureImageController.dispose();
    _zennAccountController.dispose();
    super.dispose();
  }
}

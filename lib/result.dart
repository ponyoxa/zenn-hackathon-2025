import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Result extends StatelessWidget {
  const Result({
    super.key,
    required this.title,
    required this.resultText,
  });

  final String title;
  final String resultText;

  @override
  Widget build(BuildContext context) {
    // TODO AIからの出力結果が得られたら差し替える
    // レーダーチャートのモックデータ
    final radarData = {
      "テックスキル": 80,
      "継続性": 70,
      "課題解決": 75,
      "コミュニケーション": 90,
      "独自性": 60,
    };

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.jpeg'), // 背景画像のパス
          fit: BoxFit.cover, // 画面全体を覆う
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Scaffoldの背景色を透明に設定
        appBar: AppBar(
          title: Text('他己分析結果'),
          backgroundColor: Colors.transparent, // AppBarも透明に設定
          elevation: 0, // AppBarの影をなくす
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '※あくまでアウトプットからAIが分析した結果です',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    height: 300,
                    child: RadarChart(
                      RadarChartData(
                        radarShape: RadarShape.circle,
                        dataSets: [
                          RadarDataSet(
                            dataEntries: radarData.values
                                .map((value) =>
                                    RadarEntry(value: value.toDouble()))
                                .toList(),
                            fillColor: Colors.blue.withOpacity(0.3),
                            borderColor: Colors.blue,
                            borderWidth: 2,
                          ),
                        ],
                        radarBackgroundColor: Colors.transparent,
                        borderData: FlBorderData(show: false),
                        radarBorderData:
                            const BorderSide(color: Colors.transparent),
                        titleTextStyle:
                            TextStyle(color: Colors.black, fontSize: 18.0),
                        titlePositionPercentageOffset: 0.2,
                        getTitle: (index, angle) {
                          final keys = radarData.keys.toList();
                          return RadarChartTitle(text: keys[index]);
                        },
                        tickCount: 4,
                        ticksTextStyle:
                            TextStyle(color: Colors.grey, fontSize: 12),
                        gridBorderData: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    color: Colors.white,
                    child: InkWell(
                      child: SizedBox(
                        width: 400,
                        height: 400,
                        child: Column(
                          children: const [
                            // TODO 分析結果のテキストが得られるようになったら差し替える
                            Text(
                                '分析結果 分析結果 分析結果 分析結果 分析結果 分析結果 分析結果 分析結果 分析結果 分析結果 分析結果 分析結果 分析結果 分析結果 分析結果 分析結果 分析結果'),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

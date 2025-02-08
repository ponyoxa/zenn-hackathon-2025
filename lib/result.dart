import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Result extends StatelessWidget {
  const Result({
    super.key,
    required this.title,
    required this.resultJson,
  });

  final String title;
  final Map<String, dynamic> resultJson;

  @override
  Widget build(BuildContext context) {
    // レーダーチャートのモックデータ
    final radarData = {
      "テックスキル": resultJson['scores']['tech_skill']['score'],
      "継続性": resultJson['scores']['continuation']['score'],
      "課題解決": resultJson['scores']['problem_solving']['score'],
      "コミュニケーション": resultJson['scores']['communication']['score'],
      "独自性": resultJson['scores']['individuality']['score'],
    };

    String markdownText = '''
# 技術レベル
${resultJson['level']}

${resultJson['level_description']}

## レベルの根拠
${resultJson['level_reason']}


# スコアの根拠

## テックスキル
${resultJson['scores']['tech_skill']['reason']}

## 継続性
${resultJson['scores']['continuation']['reason']}

## 課題解決
${resultJson['scores']['problem_solving']['reason']}

## コミュニケーション
${resultJson['scores']['communication']['reason']}

## 独自性
${resultJson['scores']['individuality']['reason']}

## その他のスキル
''';

    for (var metric in resultJson['level_metrics']) {
      markdownText += '''
- ${metric['label']}: ${metric['level']}  
根拠:${metric['reason']}
''';
    }

    markdownText += '''
# 長所・強みなどに基づいたアドバイス
${resultJson['advice']}

# コメント
## [AI] 両親からのコメント
${resultJson['comments']['author_parent']}

## [AI] 親友からのコメント
${resultJson['comments']['author_friend']}

## [AI] 指導の専門家からのコメント
${resultJson['comments']['author_mentor']}

## [AI] ITのエキスパートからのコメント
${resultJson['comments']['professional_expert']}

## [AI] 1レベル上の先輩からのコメント
${resultJson['comments']['senior_engineer']}

# 次のステップへのアドバイス
${resultJson['next_step']}
''';

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
                Center(
                  child: Text(
                    '※あくまでアウトプットからAIが分析した結果です',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
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
                        radarBorderData: const BorderSide(color: Colors.black),
                        titleTextStyle:
                            TextStyle(color: Colors.black, fontSize: 18.0),
                        titlePositionPercentageOffset: 0.2,
                        getTitle: (index, angle) {
                          final keys = radarData.keys.toList();
                          return RadarChartTitle(text: keys[index]);
                        },
                        tickCount: 4,
                        ticksTextStyle:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                        gridBorderData: const BorderSide(color: Colors.grey),
                        tickBorderData: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    color: Colors.white,
                    child: SizedBox(
                      width: 400,
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Markdown(
                            data: markdownText,
                            shrinkWrap: true,
                            styleSheet: MarkdownStyleSheet(
                              p: const TextStyle(
                                fontSize: 16.0,
                                height: 1.5,
                              ),
                            ),
                          ),
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

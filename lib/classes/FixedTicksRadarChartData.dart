import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FixedTicksRadarChartData extends RadarChartData {
  FixedTicksRadarChartData({
    required List<RadarDataSet> dataSets,
    required List<String> titles,
  }) : super(
          radarShape: RadarShape.circle,
          dataSets: dataSets,
          radarBackgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          radarBorderData: const BorderSide(color: Colors.black),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 14.0),
          titlePositionPercentageOffset: 0.2,
          getTitle: (index, angle) {
            return RadarChartTitle(text: titles[index]);
          },
          tickCount: 9, // 目盛りの数（0, 25, 50, 75, 100 の5個）
          ticksTextStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          gridBorderData: BorderSide(color: Colors.grey),
          tickBorderData: BorderSide(color: Colors.grey),
          isMinValueAtCenter: false,
        );

  @override
  RadarEntry get minEntry {
    return RadarEntry(value: 10);
  }

  @override
  RadarEntry get maxEntry {
    return RadarEntry(value: 100);
  }
}

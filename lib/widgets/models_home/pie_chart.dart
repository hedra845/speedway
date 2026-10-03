import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

int touchedIndex = -1;
Widget pie_chart(
  double value1,
  double value2,
  double value3,
  double value4,
  String date,
  Color color_1,
  Color color_2,
  Color color_3,
  Color color_4,
  String function,
) {
  return PieChart(
    PieChartData(
      pieTouchData: PieTouchData(
        touchCallback: (event, response) {},
      ),
      sections: [
        PieChartSectionData(
          titlePositionPercentageOffset: BorderSide.strokeAlignCenter,
          showTitle: false,
          radius: 15,
          color: color_1,
          value: value1,
        ),
        PieChartSectionData(
          showTitle: false,
          radius: 15,
          color: color_2,
          value: value2,
        ),
        PieChartSectionData(
          showTitle: false,
          radius: 15,
          color: color_3,
          value: value3,
        ),
        PieChartSectionData(
          showTitle: false,
          radius: 15,
          color: color_4,
          value: value4,
        ),
      ],
    ),
  );
}

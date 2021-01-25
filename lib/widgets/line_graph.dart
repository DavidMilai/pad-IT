import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatelessWidget {
  final List<FlSpot> mySpot;
  LineChartSample2({this.mySpot});
  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 0.0;
    const yearTextStyle = TextStyle(fontSize: 16, color: Colors.black);
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: true),
        lineBarsData: [
          LineChartBarData(
            spots: mySpot,
            isCurved: true,
            barWidth: 1,
            colors: [
              Colors.red,
            ],
            belowBarData: BarAreaData(
              show: true,
              colors: [Colors.red.withOpacity(0.3)],
              cutOffY: cutOffYValue,
              applyCutOffY: true,
            ),
            aboveBarData: BarAreaData(
              show: false,
              colors: [Colors.red.withOpacity(0.6)],
              cutOffY: cutOffYValue,
              applyCutOffY: true,
            ),
            dotData: FlDotData(
              show: false,
            ),
          ),
        ],
        minY: 60,
        titlesData: FlTitlesData(
            bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: -2,
                getTextStyles: (value) =>
                    const TextStyle(color: Colors.black, fontSize: 16),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Oct';
                    case 1:
                      return 'Nov';
                    case 2:
                      return 'Dec';
                    case 3:
                      return 'Jan';
                    case 4:
                      return '5';
                    case 5:
                      return '6';
                    case 6:
                      return '7';
                    default:
                      return '';
                  }
                }),
            leftTitles: SideTitles(
              showTitles: true,
              interval: 10,
            )),
        axisTitleData: FlAxisTitleData(
          leftTitle: AxisTitle(
              showTitle: true,
              textStyle: yearTextStyle,
              titleText: 'Number of pads'),
        ),
        gridData: FlGridData(show: false),
      ),
    );
  }
}

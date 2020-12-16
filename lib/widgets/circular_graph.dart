import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CircularGraph extends StatefulWidget {
  final int items;
  final Color one, two, three;
  final double itemOne, itemTwo, itemThree;
  CircularGraph(
      {this.items,
      this.one,
      this.two,
      this.three,
      this.itemOne,
      this.itemTwo,
      this.itemThree});
  @override
  State<StatefulWidget> createState() =>
      PieChartState(items, one, two, three, itemOne, itemTwo, itemThree);
}

class PieChartState extends State {
  final int itemCount;
  Color one, two, three;
  final itemOne, itemTwo, itemThree;
  PieChartState(this.itemCount, this.one, this.two, this.three, this.itemOne,
      this.itemTwo, this.itemThree);
  int touchedIndex;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
            setState(() {
              if (pieTouchResponse.touchInput is FlLongPressEnd ||
                  pieTouchResponse.touchInput is FlPanEnd) {
                touchedIndex = -1;
              } else {
                touchedIndex = pieTouchResponse.touchedSectionIndex;
              }
            });
          }),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: MediaQuery.of(context).size.height * 0.03,
          sections: showingSections()),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(itemCount, (i) {
      final isTouched = i == touchedIndex;
      final double radius = isTouched ? 15 : 10;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: one == null ? Colors.blue : one,
            value: itemOne == null ? 0 : itemOne,
            showTitle: false,
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: two == null ? Colors.grey : two,
            value: itemTwo == null ? 0 : itemTwo,
            showTitle: false,
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: three == null ? Colors.grey : three,
            value: itemThree == null ? 0 : itemThree,
            showTitle: false,
            radius: radius,
          );
        default:
          return null;
      }
    });
  }
}

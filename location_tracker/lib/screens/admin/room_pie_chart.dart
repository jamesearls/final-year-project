import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RoomPieChart extends StatelessWidget {
  const RoomPieChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        centerSpaceRadius: 0,
        borderData: FlBorderData(show: true),
        sections: [
          PieChartSectionData(value: 10, color: Colors.purple, radius: 100),
          PieChartSectionData(value: 20, color: Colors.amber, radius: 100),
          PieChartSectionData(value: 30, color: Colors.green, radius: 100),
        ],
      ),
    );
  }
}

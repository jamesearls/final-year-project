import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/services/firestore.dart';

class BuildingPieChart extends StatefulWidget {
  BuildingPieChart({Key? key, required int choice}) : super(key: key);

  @override
  State<BuildingPieChart> createState() => _BuildingPieChartState();
}

class _BuildingPieChartState extends State<BuildingPieChart> {
  // 0 = Today, 2 = Last Month, 3 = All TIme
  int choice = 0;
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

Future<List<Log>> getLogs(int choice) async {
  List<Log> logs = [];
  switch (choice) {
    case 0:
      logs = await FirestoreService().getTodaysLogs();
      break;
    case 1:
      logs = await FirestoreService().getLastMonthsLogs();
      break;
    case 2:
      logs = await FirestoreService().getAllTimeLogs();
      break;
    default:
      logs = await FirestoreService().getAllTimeLogs();
      break;
  }
  return logs;
}

Future<void> buildPieChart(int choice) async {
  List<String> checkedIds = [];
  List<Log> logs = [];
  var chartData = new Map<String, int>();
  logs = await getLogs(choice);
  int len = logs.length;
  for (int i = 0; i < len; i++) {
    if (!checkedIds.contains(logs[i].buildingId)) {
      checkedIds.add(logs[i].buildingId);
      int count = 0;
      for (int j = 0; j < len; j++) {
        if (logs[i].buildingId == logs[j].buildingId) {
          count++;
        }
        chartData[logs[i].buildingId] = count;
      }
    }
  }
}

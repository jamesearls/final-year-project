
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/services/firestore.dart';
import 'package:location_tracker/shared/loading.dart';

class BuildingPieChart extends StatefulWidget {
  final int choice;
  const BuildingPieChart({
    Key? key,
    required this.choice,
  }) : super(key: key);

  @override
  State<BuildingPieChart> createState() => BuildingPieChartState();
}

class BuildingPieChartState extends State<BuildingPieChart> {
  // 0 = Today, 2 = Last Month, 3 = All TIme

  @override
  Widget build(BuildContext context) {
    int choice = widget.choice;

    return FutureBuilder(
        future: buildPieChart(choice),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<PieChartSectionData> piChartData = snapshot.data;
            return Column(
              children: [
                const Text('Activities Logged per building:'),
                Expanded(
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 0,
                      sections: List.generate(piChartData.length, (i) {
                        return piChartData[i];
                      }),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: LoadingScreen(),
            );
          }
        });
  }
}

Future<List<PieChartSectionData>> buildPieChart(int choice) async {
  List<String> checkedIds = [];
  List<Log> logs = [];
  var chartData = <String, int>{};
  logs = await getLogs(choice);
  int len = logs.length;
  for (int i = 0; i < len; i++) {
    if (!checkedIds.contains(logs[i].buildingId) && logs[i].buildingId != "") {
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
  List<PieChartSectionData> chartDataList = [];
  int count = 0;
  chartData.forEach((key, value) {
    chartDataList.add(PieChartSectionData(
        title: "$key: $value",
        value: value.toDouble(),
        color: getColour(count),
        showTitle: true,
        radius: 100));
    count++;
  });
  return chartDataList;
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

Color getColour(int i) {
  int colour = i;
  List<Color> colours = [
    Colors.red,
    Colors.purple,
    Colors.green,
    Colors.blue,
    Colors.orange
  ];
  return colours[colour];
}

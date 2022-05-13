import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/services/firestore.dart';
import 'package:location_tracker/shared/loading.dart';

class _BarChart extends StatelessWidget {
  final int choice;
  const _BarChart({Key? key, required this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int choice = this.choice;
    return FutureBuilder(
      future: buildBarChart(choice),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, int> barChartData = snapshot.data;
          return Column(
            children: [
              const Center(child: Text('Total Room activity per day:')),
              Expanded(
                child: BarChart(
                  BarChartData(
                      barTouchData: barTouchData,
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: getTitles,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: barChartData['Mn']!.toDouble(),
                              gradient: _barsGradient,
                            )
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: barChartData['Tu']!.toDouble(),
                              gradient: _barsGradient,
                            )
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: barChartData['Wd']!.toDouble(),
                              gradient: _barsGradient,
                            )
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: barChartData['Th']!.toDouble(),
                              gradient: _barsGradient,
                            )
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: barChartData['Fr']!.toDouble(),
                              gradient: _barsGradient,
                            )
                          ],
                        ),
                        BarChartGroupData(
                          x: 5,
                          barRods: [
                            BarChartRodData(
                              toY: barChartData['St']!.toDouble(),
                              gradient: _barsGradient,
                            )
                          ],
                        ),
                        BarChartGroupData(
                          x: 6,
                          barRods: [
                            BarChartRodData(
                              toY: barChartData['Sn']!.toDouble(),
                              gradient: _barsGradient,
                            )
                          ],
                        ),
                      ]),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: LoadingScreen(),
          );
        }
      },
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Th';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return Center(child: Text(text, style: style));
  }

  final _barsGradient = const LinearGradient(
    colors: [
      Colors.lightBlueAccent,
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}

class RoomBarChart extends StatefulWidget {
  final int choice;

  const RoomBarChart({Key? key, required this.choice}) : super(key: key);
  @override
  State<StatefulWidget> createState() => RoomBarChartState();
}

class RoomBarChartState extends State<RoomBarChart> {
  @override
  Widget build(BuildContext context) {
    int choice = widget.choice;
    return AspectRatio(
      aspectRatio: 2,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        // color: const Color(0xff2c4260),
        child: _BarChart(choice: choice),
      ),
    );
  }
}

Future<Map> buildBarChart(int choice) async {
  List<Log> logs = [];
  if (choice == 0) {
    logs = await FirestoreService().getTodaysLogs();
  } else if (choice == 1) {
    logs = await FirestoreService().getLastMonthsLogs();
  } else if (choice == 2) {
    logs = await FirestoreService().getAllTimeLogs();
  }
  var chartData = <String, int>{
    'Mn': 0,
    'Tu': 0,
    'Wd': 0,
    'Th': 0,
    'Fr': 0,
    'St': 0,
    'Sn': 0,
  };
  for (Log log in logs) {
    DateTime datetime = log.timestamp.toDate();
    if (log.roomId != "" || log.roomId != null && log.buildingId == "") {
      if (datetime.weekday == 1) {
        chartData.update('Mn', (value) => ++value);
      } else if (datetime.weekday == 2) {
        chartData.update('Tu', (value) => ++value);
      } else if (datetime.weekday == 3) {
        chartData.update('Wd', (value) => ++value);
      } else if (datetime.weekday == 4) {
        chartData.update('Th', (value) => ++value);
      } else if (datetime.weekday == 5) {
        chartData.update('Fr', (value) => ++value);
      } else if (datetime.weekday == 6) {
        chartData.update('St', (value) => ++value);
      } else if (datetime.weekday == 7) {
        chartData.update('Sn', (value) => ++value);
      }
    }
  }
  return chartData;
}

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff7589a2),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  if (value == 0) {
    text = '1';
  } else if (value == 5) {
    text = '5';
  } else if (value == 10) {
    text = '10';
  } else {
    return Container();
  }
  return Text(text, style: style);
}

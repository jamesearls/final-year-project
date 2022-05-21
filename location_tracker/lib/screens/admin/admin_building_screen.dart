import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/screens/admin/building_bar_chart.dart';
import 'package:location_tracker/screens/admin/building_pie_chart.dart';
import 'package:location_tracker/screens/admin/log_list.dart';
import 'package:location_tracker/services/firestore.dart';
import 'package:provider/provider.dart';

class AdminBuildingScreen extends StatefulWidget {
  const AdminBuildingScreen({Key? key}) : super(key: key);

  @override
  State<AdminBuildingScreen> createState() => _AdminBuildingScreenState();
}

class _AdminBuildingScreenState extends State<AdminBuildingScreen> {
  List logs = [];
  int choice = 0;

  @override
  Widget build(BuildContext context) {
    List<Log>? logStream = Provider.of<List<Log>?>(context);
    final isSelected = <bool>[false, false, false];
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Logs '),
                    Text(
                      '${logs.length} logs loaded',
                      style: const TextStyle(fontSize: 9, color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ToggleButtons(
                          color: Colors.white,
                          selectedColor: Colors.black,
                          selectedBorderColor: const Color(0xFF6200EE),
                          fillColor: const Color(0xFF6200EE).withOpacity(0.08),
                          splashColor:
                              const Color(0xFF6200EE).withOpacity(0.12),
                          hoverColor: const Color(0xFF6200EE).withOpacity(0.04),
                          borderRadius: BorderRadius.circular(4.0),
                          constraints: const BoxConstraints(minHeight: 36.0),
                          isSelected: isSelected,
                          onPressed: (int index) async {
                            switch (index) {
                              case 0:
                                List newlogs =
                                    await FirestoreService().getTodaysLogs();
                                setState(() {
                                  isSelected[0] = !isSelected[0];
                                  logs = newlogs;
                                });
                                break;
                              case 1:
                                List newlogs = await FirestoreService()
                                    .getLastMonthsLogs();
                                setState(() {
                                  isSelected[1] = !isSelected[1];
                                  logs = newlogs;
                                });
                                break;
                              case 2:
                                logs = logStream ?? [];
                                // sort logs by timestamp
                                logs.sort((a, b) =>
                                    b.timestamp.compareTo(a.timestamp));
                                setState(() {
                                  isSelected[2] = !isSelected[2];
                                });
                                break;
                            }
                          },
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.0),
                              child: Text('Today'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.0),
                              child: Text('Last Month'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.0),
                              child: Text('All Time'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            for (Log log in logs) LogList(log: log),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToggleButtons(
                color: Colors.white,
                selectedColor: Colors.black,
                selectedBorderColor: const Color(0xFF6200EE),
                fillColor: const Color(0xFF6200EE).withOpacity(0.08),
                splashColor: const Color(0xFF6200EE).withOpacity(0.12),
                hoverColor: const Color(0xFF6200EE).withOpacity(0.04),
                borderRadius: BorderRadius.circular(4.0),
                constraints: const BoxConstraints(minHeight: 36.0),
                isSelected: isSelected,
                onPressed: (int index) async {
                  switch (index) {
                    case 0:
                      setState(() {
                        choice = 0;
                      });
                      break;
                    case 1:
                      setState(() {
                        choice = 1;
                      });
                      break;

                    case 2:
                      setState(() {
                        choice = 2;
                      });
                      break;

                    default:
                      setState(() {
                        choice = 0;
                      });
                  }
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text('Today'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text('Last Month'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text('All Time'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: BuildingPieChart(choice: choice),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            child: BuildingBarChart(choice: choice),
          ),
        ],
      ),
    );
  }
}

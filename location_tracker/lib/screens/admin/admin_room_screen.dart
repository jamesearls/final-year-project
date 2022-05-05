import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/screens/admin/room_bar_chart.dart';
import 'package:location_tracker/screens/admin/room_pie_chart.dart';
import 'package:location_tracker/screens/admin/log_list.dart';
import 'package:location_tracker/services/firestore.dart';
import 'package:provider/provider.dart';

class AdminRoomScreen extends StatefulWidget {
  const AdminRoomScreen({Key? key}) : super(key: key);

  @override
  State<AdminRoomScreen> createState() => _AdminRoomScreenState();
}

class _AdminRoomScreenState extends State<AdminRoomScreen> {
  List logs = [];
  int choice = 0;

  @override
  Widget build(BuildContext context) {
    List<Log>? logStream = Provider.of<List<Log>?>(context);
    final isSelected = <bool>[false, false, false];
    return Scaffold(
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
            child: RoomPieChart(choice: choice),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            child: RoomBarChart(choice: choice),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/screens/admin/log_list.dart';
import 'package:provider/provider.dart';

class AdminBuildingScreen extends StatefulWidget {
  const AdminBuildingScreen({Key? key}) : super(key: key);

  @override
  State<AdminBuildingScreen> createState() => _AdminBuildingScreenState();
}

class _AdminBuildingScreenState extends State<AdminBuildingScreen> {
  @override
  Widget build(BuildContext context) {
    List logs = Provider.of<List<Log>>(context);
    // sort logs by timestamp
    logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    final isSelected = <bool>[false, false, false];
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Logs'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ToggleButtons(
                          color: Colors.white,
                          selectedColor: Colors.white,
                          selectedBorderColor: Color(0xFF6200EE),
                          fillColor: Color(0xFF6200EE).withOpacity(0.08),
                          splashColor: Color(0xFF6200EE).withOpacity(0.12),
                          hoverColor: Color(0xFF6200EE).withOpacity(0.04),
                          borderRadius: BorderRadius.circular(4.0),
                          constraints: BoxConstraints(minHeight: 36.0),
                          isSelected: isSelected,
                          onPressed: (index) {
                            // Respond to button selection
                            setState(() {
                              isSelected[index] = !isSelected[index];
                            });
                          },
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.0),
                              child: Text('Today'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.0),
                              child: Text('This Month'),
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
      body: const Center(
        child: Text('Building'),
      ),
    );
  }
}

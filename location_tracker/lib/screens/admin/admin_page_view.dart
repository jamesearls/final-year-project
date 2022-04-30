import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_tracker/screens/admin/admin_building_screen.dart';
import 'package:location_tracker/screens/admin/admin_room_screen.dart';

class AdminPageView extends StatelessWidget {
  AdminPageView({Key? key}) : super(key: key);

  final List<Tab> myTabs = <Tab>[
    // ignore: prefer_const_constructors
    const Tab(
      text: 'Buildings',
      icon: Icon(
        FontAwesomeIcons.building,
        size: 20,
      ),
    ),
    const Tab(
      text: 'Rooms',
      icon: Icon(
        FontAwesomeIcons.restroom,
        size: 20,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin View'),
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            AdminBuildingScreen(),
            AdminRoomScreen(),
          ],
        ),
      ),
    );
  }
}

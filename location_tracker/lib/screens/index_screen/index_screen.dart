import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/screens/buildings/buildings.dart';
import 'package:location_tracker/services/firestore.dart';
import 'package:location_tracker/services/nfcService.dart';
import 'package:location_tracker/shared/bottom_nav.dart';
import 'package:location_tracker/shared/error.dart';
import 'package:location_tracker/shared/loading.dart';
import 'package:location_tracker/shared/locationText.dart';
import 'package:provider/provider.dart';

import '../../services/geofencing_service.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  NfcService nfcService = NfcService();

  //provider

  @override
  void initState() {
    super.initState();
    GeofencingService().geofenceCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Building>>(
      future: FirestoreService().getAllBuildings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          ErrorMessage(message: snapshot.error.toString());
        } else if (snapshot.hasData) {
          var buildings = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                  'Queens University Belfast'), // change to ORG from db
            ),
            body: Column(
              children: <Widget>[
                Flexible(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20.0),
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: buildings
                        .map((building) => BuildingView(building: building))
                        .toList(),
                  ),
                ),
                const LocationText(),
                FloatingActionButton(
                  onPressed: () {
                    // Add your onPressed code here!
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Ready to Scan!'),
                        content: const Text(
                            'Please move into a room in your and scan the NFC tag.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Dismiss'),
                          ),
                        ],
                      ),
                    );
                    nfcService.getPayload();
                  },
                  backgroundColor: Colors.deepPurple,
                  child: const Icon(FontAwesomeIcons.nfcSymbol),
                ),
                FloatingActionButton(onPressed: () {
                  // print(usersInBuildings);
                })
              ],
            ),
            bottomNavigationBar: BottomNavBar(),
          );
        } else {}
        return const Text('No buildings found in Firestore. Check DB');
      },
    );
  }
}

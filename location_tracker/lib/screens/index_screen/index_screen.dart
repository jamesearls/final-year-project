import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/screens/buildings/buildings.dart';
import 'package:location_tracker/services/firestore.dart';
import 'package:location_tracker/services/nfc_service.dart';
import 'package:location_tracker/shared/admin_button.dart';
import 'package:location_tracker/shared/bottom_nav.dart';
import 'package:location_tracker/shared/error.dart';
import 'package:location_tracker/shared/loading.dart';
import 'package:location_tracker/shared/location_text.dart';
import 'package:location_tracker/shared/nfc_button.dart';
import 'package:provider/provider.dart';

import '../../services/geofencing_service.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  NfcService nfcService = NfcService();

  @override
  void initState() {
    super.initState();
    GeofencingService().geofenceCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    User userModel = Provider.of<User>(context);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    userModel.isAdmin ? const Spacer(flex: 20) : const Spacer(),
                    const NfcButton(),
                    const Spacer(),
                    const AdminButton(),
                  ],
                ),
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

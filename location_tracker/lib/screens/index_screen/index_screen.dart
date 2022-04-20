import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/screens/buildings/buildings.dart';
import 'package:location_tracker/services/firestore.dart';
import 'package:location_tracker/shared/bottom_nav.dart';
import 'package:location_tracker/shared/error.dart';
import 'package:location_tracker/shared/loading.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Building>>(
      future: FirestoreService().getBuildings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          child:
          ErrorMessage(message: snapshot.error.toString());
        } else if (snapshot.hasData) {
          var buildings = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Index'),
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: buildings
                  .map((building) => BuildingView(building: building))
                  .toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {}
        return const Text('No buildings found in Firestore. Check DB');
      },
    );
  }
}

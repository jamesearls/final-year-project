import 'package:flutter/material.dart';
import 'package:location_tracker/models/geofence_model.dart';
import 'package:location_tracker/models/user_location.dart';
import 'package:location_tracker/routes.dart';
import 'package:location_tracker/services/firestore.dart';
import 'package:location_tracker/services/geofencing_service.dart';
import 'package:location_tracker/theme.dart';
import 'package:provider/provider.dart';

import 'models/models.dart';
import 'services/location_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserLocation?>(
            initialData: null,
            create: (context) => LocationService().locationStream),
        StreamProvider<GeofenceModel?>(
            initialData: null,
            create: (context) => GeofencingService().geofenceStream),
        StreamProvider<List<UserInBuilding>?>(
            initialData: null,
            create: (_) => FirestoreService().streamUsersInBuildings()),
        StreamProvider<List<UserInRoom>?>(
            initialData: null,
            create: (_) => FirestoreService().streamUsersInRooms()),
        StreamProvider<User?>(
            initialData: User(),
            create: (_) => FirestoreService().streamUser()),
      ],
      child: MaterialApp(
        routes: appRoutes,
        title: 'James Location Tracker',
        theme: appTheme,
      ),
    );
  }
}

// @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         StreamProvider<UserLocation?>(
//           create: (context) => LocationService().locationStream,
//           initialData: null,
//         ),
//       ],
//       child: MaterialApp(
//         routes: appRoutes,
//         title: 'James Location Tracker',
//         theme: appTheme,
//       ),
//     );
//   }

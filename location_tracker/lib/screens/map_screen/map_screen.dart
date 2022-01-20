// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location_tracker/screens/home_screen/home_screen.dart';
// import 'package:location_tracker/utils/local_utils.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   final _initialCameraPosition = CameraPosition(
//     target: LatLng(LocalUtils.getLat(), LocalUtils.getLong()),
//     zoom: 11.5,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GoogleMap(
//       initialCameraPosition: _initialCameraPosition,
//     ));
//   }
// }

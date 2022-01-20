// // ignore_for_file: prefer_typing_uninitialized_variables

// import 'dart:html';

// import 'package:geolocator/geolocator.dart';

// class LocalUtils {
//   static var _latitude;
//   static var _longitude;

//   static double getLat() {
//     getLocation();
//     return _latitude;
//   }

//   static double getLong() {
//     getLocation();
//     return _longitude;
//   }

//   static void getLocation() async {
//     Position position = await Geolocator.getCurrentPosition();
//     _latitude = position.latitude;
//     _longitude = position.longitude;
//   }
// }

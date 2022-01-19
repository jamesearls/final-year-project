import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var locationMessage = '';
  String latitude = '';
  String longitude = '';

  void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    latitude = "$lat";
    longitude = "$long";

    setState(() {
      locationMessage = "Latitude $lat and Longitude $long";
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomeScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          "Location Tracker Home",
          style: TextStyle(color: (Colors.white)),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("LAT: $latitude, LNG: $longitude"),
            FlatButton(
              child: const Text("Get location"),
              onPressed: () {
                getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }
}

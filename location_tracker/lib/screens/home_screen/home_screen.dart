// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:location_tracker/screens/map_screen/map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'James is using google maps in flutter',
                style: TextStyle(fontSize: 42),
              ),
              SizedBox(height: 20),
              Text(
                'The google_maps_flutter package is still in the Developers Preview status, so make sure you monitor changes closely when using it. There will likely be breaking changes in the near future.',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.map),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MapScreen())),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:location_tracker/models/user_location.dart';
import 'package:location_tracker/screens/home_screen/home_screen.dart';
import 'package:location_tracker/screens/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

import 'services/location_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation?>(
      initialData: null,
      create: (context) => LocationService().locationStream,
      child: MaterialApp(
        title: 'James Location Tracker',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepPurple,
        ),
        home: LoginScreen(),
      ),
    );
  }
}

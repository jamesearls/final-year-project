import 'package:flutter/material.dart';
import 'package:location_tracker/models/user_location.dart';
import 'package:location_tracker/routes.dart';
import 'package:location_tracker/screens/login_screen/login_screen.dart';
import 'package:location_tracker/theme.dart';
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
        routes: appRoutes,
        title: 'James Location Tracker',
        theme: appTheme,
      ),
    );
  }
}

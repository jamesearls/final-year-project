import 'package:flutter/material.dart';
import 'package:location_tracker/screens/index_screen/index_screen.dart';
import 'package:location_tracker/screens/login_screen/login_screen.dart';
import 'package:location_tracker/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return const IndexScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

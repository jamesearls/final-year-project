import 'package:flutter/material.dart';
import 'package:location_tracker/screens/index_screen/index_screen.dart';
import 'package:location_tracker/screens/login_screen/login_screen.dart';
import 'package:location_tracker/services/auth.dart';
import 'package:location_tracker/services/firestore.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final FirestoreService firestoreService = FirestoreService();

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
          firestoreService.userSetup();
          return const IndexScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

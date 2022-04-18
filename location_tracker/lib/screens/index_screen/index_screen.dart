import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location_tracker/screens/login_screen/login_screen.dart';
import 'package:location_tracker/screens/profile_screen/profile_screen.dart';
import 'package:location_tracker/services/auth.dart';
import 'package:location_tracker/shared/bottom_nav.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);
  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
          // title: Text(
          //   'Welcome ${_currentUser.displayName}',
          //   style: const TextStyle(color: (Colors.white)),
          // ),
          ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                  "ORG: QUB\nBuilding 1: CSB\nBuilding 2: The Lanyon Building\nBuilding 3: Ashby Building"),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(builder: (context) => ProfileScreen()),
              //     );
              //   },
              //   child: const Text(
              //     'My Profile',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
              ElevatedButton(
                  onPressed: () async {
                    await AuthService().signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  child: const Text('Sign out'))
              // and, signing out the user
            ],
          ),
        ),
      ),
    );
  }
}

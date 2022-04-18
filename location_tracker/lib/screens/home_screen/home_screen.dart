// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location_tracker/screens/login_screen/login_screen.dart';
import 'package:location_tracker/screens/map_screen/map_screen.dart';
import 'package:location_tracker/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({required this.user});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    String displayName = widget.user.displayName.toString();
    super.initState();
  }

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
        title: Text(
          'Welcome ${_currentUser.displayName}',
          style: TextStyle(color: (Colors.white)),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  "ORG: QUB\nBuilding 1: CSB\nBuilding 2: The Lanyon Building\nBuilding 3: Ashby Building"),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(user: _currentUser)),
                  );
                },
                child: Text(
                  'My Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text('Sign out'))
              // and, signing out the user
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

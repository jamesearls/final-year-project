import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location_tracker/utils/fire_auth.dart';
import '../../services/auth.dart';
import '../login_screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NAME: ${AuthService().getUserName()}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16.0),
            Text(
              'EMAIL: ${AuthService().getUserEmail()}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16.0),
            AuthService().getUserVerified()
                ? Text(
                    'Email verified',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.green),
                  )
                : Text(
                    'Email not verified',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.red),
                  ),
            // Add widgets for verifying email
            // ElevatedButton(
            //   onPressed: () async {
            //     await _currentUser.sendEmailVerification();
            //   },
            //   child: const Text('Verify email'),
            // ),
            // IconButton(
            //   icon: const Icon(Icons.refresh),
            //   onPressed: () async {
            //     User? user = await FireAuth.refreshUser(_currentUser);
            //     if (user != null) {
            //       setState(() {
            //         _currentUser = user;
            //       });
            //     }
            //   },
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
    );
  }
}
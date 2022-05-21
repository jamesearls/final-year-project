import 'package:flutter/material.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/services/auth.dart';
import 'package:location_tracker/services/geofencing_service.dart';
import 'package:location_tracker/shared/loading.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = AuthService().user;
    User userModel = Provider.of<User>(context);

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(user.displayName ?? 'Guest'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.photoURL ??
                        'https://www.gravatar.com/avatar/placeholder'),
                  ),
                ),
              ),
              Text(user.email ?? '',
                  style: Theme.of(context).textTheme.headline6),
              Text(user.displayName ?? '',
                  style: Theme.of(context).textTheme.headline6),
              Text(userModel.isAdmin ? 'Admin User' : 'Standard User',
                  style: Theme.of(context).textTheme.headline6),
              const Spacer(),
              ElevatedButton(
                child: const Text('logout'),
                onPressed: () async {
                  GeofencingService gc = GeofencingService();
                  gc.dispose();
                  await AuthService().signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    } else {
      return const Loader();
    }
  }
}

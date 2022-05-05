import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_tracker/models/models.dart';
import 'package:provider/provider.dart';

class AdminButton extends StatelessWidget {
  const AdminButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User userModel = Provider.of<User>(context);

    if (userModel.isAdmin) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.deepPurple,
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
            icon: const Icon(
              FontAwesomeIcons.userShield,
              color: Colors.white,
            ),
            label: const Text(
              'Admin',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
    return Container();
  }
}

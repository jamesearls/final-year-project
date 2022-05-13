import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/screens/buildings/buildings.dart';
import 'package:location_tracker/services/firestore.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.user,
            size: 20,
            color: Colors.grey,
          ),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.building,
            size: 20,
          ),
          label: 'Building',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.locationDot,
            size: 20,
          ),
          label: 'Map',
        ),
      ],
      fixedColor: Colors.grey[100],
      onTap: (int idx) async {
        switch (idx) {
          case 0:
            Navigator.pushNamed(context, '/profile');
            break;
          case 1:
            Building currentBuilding =
                await firestoreService.getCurrentBuilding();

            // If in building, show that screen, if not popup to say not in building
            if (currentBuilding.id == "") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Not in a building'),
                  content: const Text(
                      'Please move into a building in your org to access this screen.\nView the map to find buildings in your org.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Dismiss'),
                    ),
                  ],
                ),
              );
              break;
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      BuildingScreen(building: currentBuilding)));
              break;
            }
          case 2:
            Navigator.pushNamed(context, '/map');
            break;
        }
      },
    );
  }
}

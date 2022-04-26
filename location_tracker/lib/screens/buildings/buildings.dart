import 'package:flutter/material.dart';
import 'package:location_tracker/services/firestore.dart';
import 'package:location_tracker/shared/occupantCount.dart';
import 'package:location_tracker/shared/error.dart';
import 'package:location_tracker/shared/loading.dart';
import 'package:location_tracker/shared/progress_bar.dart';

import '../../models/models.dart';
import '../Rooms/rooms.dart';

class BuildingView extends StatelessWidget {
  final Building building;
  const BuildingView({Key? key, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: building.img,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    BuildingScreen(building: building),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: Image.asset(
                    'assets/images/${building.img}',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    building.name,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
              Flexible(child: BuildingCapacity(building: building)),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildingScreen extends StatelessWidget {
  final Building building;
  const BuildingScreen({Key? key, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Room>>(
      future: FirestoreService().getRooms(building.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          ErrorMessage(message: snapshot.error.toString());
        } else if (snapshot.hasData) {
          var rooms = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(building.name),
            ),
            body: Column(
              children: <Widget>[
                Flexible(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20.0),
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    children:
                        rooms.map((room) => RoomView(room: room)).toList(),
                  ),
                ),
                BuildingCount(buildingId: building.id),
              ],
            ),
          );
        } else {}
        return const Text('No rooms found in Firestore. Check DB');
      },
    );
  }
}

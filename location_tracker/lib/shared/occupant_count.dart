import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:provider/provider.dart';

class BuildingCount extends StatelessWidget {
  final String buildingId;

  const BuildingCount({Key? key, required this.buildingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = buildingId;
    int buildingCount = 0;
    List<UserInBuilding>? uib = Provider.of<List<UserInBuilding>?>(context);

    if (uib != null) {
      for (UserInBuilding u in uib) {
        if (u.buildingId == id) {
          buildingCount++;
        }
      }
    }

    return Text(
      'Number of users: $buildingCount',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class RoomCount extends StatelessWidget {
  final String roomId;
  const RoomCount({Key? key, required this.roomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = roomId;
    int roomCount = 0;
    List<UserInRoom>? uir = Provider.of<List<UserInRoom>?>(context);

    if (uir != null) {
      for (UserInRoom u in uir) {
        if (u.roomId == id) {
          roomCount++;
        }
      }
    }

    return Text(
      'Number of users: $roomCount',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

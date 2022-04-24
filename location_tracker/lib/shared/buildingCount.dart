import 'package:cloud_firestore/cloud_firestore.dart';
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
    final usersInBuildings = Provider.of<QuerySnapshot>(context);

    for (var doc in usersInBuildings.docs) {
      if (usersInBuildings.docs.contains(id)) {
        buildingCount++;
      }
    }

    return Container(
      child: Text(
        'Number of users: $buildingCount',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

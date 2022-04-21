import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:location_tracker/models/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Methods to return number of buildings and rooms

  // Reads all documents from the buildings collection as list
  Future<List<Building>> getAllBuildings() async {
    var ref = _db.collection('buildings');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var buildings = data.map((d) => Building.fromJson(d));
    return buildings.toList();
  }

  // Reads all documents from the rooms collection as list
  Future<List<Room>> getAllRooms() async {
    var ref = _db.collection('rooms');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var rooms = data.map((d) => Room.fromJson(d));
    return rooms.toList();
  }

  // Reads documents from rooms collection equal to buildingid as list
  Future<List<Room>> getRooms(String buildingId) async {
    var ref =
        _db.collection('rooms').where('buildingId', isEqualTo: buildingId);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var rooms = data.map((d) => Room.fromJson(d));
    return rooms.toList();
  }

  // Method to return number of documents UsersinBuilding with buildingId
  Future<String> getUsersInBuildings(String buildingId) async {
    var ref = _db
        .collection('usersInBuildings')
        .where('buildingId', isEqualTo: buildingId);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    int length = data.length;
    return 'Number of drillas: $length';
  }

  // Method to return number of documents UsersinRoom with roomId
  Future<String> getUsersInRooms(String roomId) async {
    var ref = _db.collection('usersInRooms').where('roomId', isEqualTo: roomId);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    int length = data.length;
    return 'Number of drillas: $length';
  }

  // Method to add document to UsersinBuilding

  // Method to add document to UsersinRoom

}

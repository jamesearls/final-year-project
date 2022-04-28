import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:location_tracker/services/auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:location_tracker/models/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  ///Methods to return number of buildings and rooms

  // get current building

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

  Future<List> getAllUsersInBuildings() async {
    var ref = _db.collection('usersInBuildings');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var usersInBuildings = data.map((d) => UserInBuilding.fromJson(d));
    return usersInBuildings.toList();
  }

  Future<List> getAllUsersInRooms() async {
    var ref = _db.collection('usersInRooms');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var usersInRooms = data.map((d) => UserInRoom.fromJson(d));
    return usersInRooms.toList();
  }

  Future<List<UserInBuilding>> getAllUsersInBuildings2() async {
    var ref = _db.collection('usersInBuildings');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var usersInBuildings = data.map((d) => UserInBuilding.fromJson(d));
    return usersInBuildings.toList();
    ;
  }

  // Method to return number of documents UsersinBuilding with buildingId
  Future<int> getUsersInBuildings(String buildingId) async {
    var ref = _db
        .collection('usersInBuildings')
        .where('buildingId', isEqualTo: buildingId);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    int length = data.length;
    return length;
  }

  // Method to return number of documents UsersinRoom with roomId
  Future<String> getUsersInRooms(String roomId) async {
    var ref = _db.collection('usersInRooms').where('roomId', isEqualTo: roomId);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    int length = data.length;
    return 'Number of Occupants: $length';
  }

  // Listens to number of docs in usersInBuildings collection

  // Listens to number of docs in usersInRooms collection

  //user Setup
  Future<void> userSetup() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid.toString() ?? "not working";
    users.doc(uid).set({
      'uid': uid,
      'email': auth.currentUser?.email ?? "not working",
      'displayName': auth.currentUser?.displayName ?? "not working",
      'photoUrl': auth.currentUser?.photoURL ?? "default.png",
      'lastSeen': DateTime.now(),
      'isAdmin': false,
    });
    return;
  }

  // Get current building
  Future<Building> getCurrentBuilding() async {
    Building building = Building();
    String buildingId = '';
    List uib = await getAllUsersInBuildings();
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid.toString() ?? "not working";
    for (var i = 0; i < uib.length; i++) {
      if (uib[i].userId == uid) {
        buildingId = uib[i].buildingId;
      }
    }

    List allBuildings = await getAllBuildings();
    for (var i = 0; i < allBuildings.length; i++) {
      if (allBuildings[i].id == buildingId) {
        building = allBuildings[i];
      }
    }

    return building;
  }

  //Get current buildingId
  Future<String> getCurrentBuildingId() async {
    String buildingId = '';
    List uib = await getAllUsersInBuildings();
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid.toString() ?? "not working";
    for (var i = 0; i < uib.length; i++) {
      if (uib[i].userId == uid) {
        buildingId = uib[i].buildingId;
      }
    }
    return buildingId;
  }

  //Method to add document to UsersInBuildings collection
  Future<void> addUserInBuildings(String buildingId) async {
    CollectionReference usersInBuildings =
        FirebaseFirestore.instance.collection('usersInBuildings');
    FirebaseAuth auth = FirebaseAuth.instance;

    List uib = await getAllUsersInBuildings();

    String? uid = auth.currentUser?.uid.toString() ?? "not working";
    bool recordExists = false;

    for (var i = 0; i < uib.length; i++) {
      if (uib[i].userId == uid) {
        recordExists = true;
      }
    }
    if (recordExists == false) {
      usersInBuildings.add({
        'userId': uid,
        'buildingId': buildingId,
      });
    }
  }

  //Method to remove document from UsersInBuildings collection
  Future<void> removeUserInBuildings(String buildingId) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var collection = FirebaseFirestore.instance
        .collection('usersInBuildings')
        .where('userId', isEqualTo: auth.currentUser?.uid.toString());
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> addOrRemoveUserInRooms(String roomId) async {
    CollectionReference usersInRooms =
        FirebaseFirestore.instance.collection('usersInRooms');
    FirebaseAuth auth = FirebaseAuth.instance;

    List uib = await getAllUsersInRooms();

    String? uid = auth.currentUser?.uid.toString() ?? "not working";
    bool recordExists = false;

    for (var i = 0; i < uib.length; i++) {
      if (uib[i].userId == uid) {
        recordExists = true;
      }
    }
    if (recordExists == false) {
      usersInRooms.add({
        'userId': uid,
        'roomId': roomId,
      });
    } else {
      var collection = FirebaseFirestore.instance
          .collection('usersInRooms')
          .where('userId', isEqualTo: auth.currentUser?.uid.toString());
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    }
  }

  // Method to add document to UsersInRooms collection

// Listen to usersInBuildings collection

  Stream<List<UserInBuilding>> streamUsersInBuildings() {
    return _db.collection('usersInBuildings').snapshots().map((snapShot) =>
        snapShot.docs
            .map((doc) => UserInBuilding.fromJson(doc.data()))
            .toList());
  }

// Listen to usersInRooms collection
  Stream<List<UserInRoom>> streamUsersInRooms() {
    return _db.collection('usersInRooms').snapshots().map((snapShot) =>
        snapShot.docs.map((doc) => UserInRoom.fromJson(doc.data())).toList());
  }

// Listen to users collection
  Stream<User> streamUser() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('users').doc(user.uid);
        return ref.snapshots().map((doc) => User.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([User()]);
      }
    });
  }
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:location_tracker/services/auth.dart';
import 'package:location_tracker/models/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Reads all documents from the buildings collection
  Future<List<Building>> getBuildings() async {
    var ref = _db.collection('buildings');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var buildings = data.map((d) => Building.fromJson(d));
    return buildings.toList();
  }
}

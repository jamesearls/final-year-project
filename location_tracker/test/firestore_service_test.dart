import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/services/firestore.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
//test firestore service

class MockFirestoreService extends Mock implements FirestoreService {}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirestoreService firestoreService = FirestoreService();
  setUp(() async {});
  tearDown(() {});

// TC 1.1 test getAllBuildings doesn't return empty list
  test('getAllBuildings should not return empty list', () async {
    final List<Building> buildings = await firestoreService.getAllBuildings();
    expect(buildings.isNotEmpty, true);
  });

//TC 1.2 test getAllRooms doesn't return empty list
  test('getAllRooms should not return empty list', () async {
    final List<Room> rooms = await firestoreService.getAllRooms();
    expect(rooms.isNotEmpty, true);
  });

//TC 1.3 test getAllDesks doesn't return empty list
  test('getAllDesks should not return empty list', () async {
    final List<Desk> desks = await firestoreService.getAllDesks();
    expect(desks.isNotEmpty, true);
  });

//TC 1.4 test getAllUsersInBuildings doesn't return empty list
  test('getAllUsersInBuildings should not return empty list', () async {
    final List uib = await firestoreService.getAllUsersInBuildings();
    expect(uib.isNotEmpty, true);
  });

//TC 1.5 test getAllUsersInRooms doesn't return empty list
  test('getAllUsersInRooms should not return empty list', () async {
    final List uir = await firestoreService.getAllUsersInRooms();
    expect(uir.isNotEmpty, true);
  });

  //TC 1.6 test getAllUsers doesn't return empty list
  test('getAllUsers should not return empty list', () async {
    final List<User> users = await firestoreService.getAllUsers();
    expect(users.isNotEmpty, true);
  });

  //TC 1.7 test  getTodaysLogs doesn't return empty list
  test('getTodaysLogs should not return empty list', () async {
    final List<Log> logs = await firestoreService.getTodaysLogs();
    expect(logs.isNotEmpty, true);
  });

  //TC 1.8 test getLastMonthsLogs doesn't return empty list
  test('getLastMonthLogs should not return empty list', () async {
    final List<Log> logs = await firestoreService.getLastMonthsLogs();
    expect(logs.isNotEmpty, true);
  });

  //TC 1.9 test getAllTimeLogs doesn't return empty list
  test('getAllTimeLogs should not return empty list', () async {
    final List<Log> logs = await firestoreService.getAllTimeLogs();
    expect(logs.isNotEmpty, true);
  });
}

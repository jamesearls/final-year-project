import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:location_tracker/models/geofence_model.dart';
import 'package:location_tracker/services/firestore.dart';

class GeofencingService {
  late GeofenceModel _geofenceModel;
  static String currentGeofenceStatus = '';
  static String currentGeofenceId = '';
  FirestoreService firestoreService = FirestoreService();

  // Create a [GeofenceService] instance and set options.
  final _geofenceService = GeofenceService.instance.setup(
      interval: 5000,
      accuracy: 100,
      loiteringDelayMs: 60000,
      statusChangeDelayMs: 10000,
      useActivityRecognition: false,
      allowMockLocations: false,
      printDevLog: false,
      geofenceRadiusSortType: GeofenceRadiusSortType.DESC);

  // Create a [Geofence] list.  to be made dynamic with db later
  final _geofenceList = <Geofence>[
    Geofence(
      id: 'csb',
      data: 'The CSB',
      latitude: 54.5817,
      longitude: -5.9377,
      radius: [
        GeofenceRadius(id: 'radius_50m', length: 50),
      ],
    ),
    Geofence(
      id: 'lan',
      data: 'The Lanyon Building',
      latitude: 54.5845,
      longitude: -5.9350,
      radius: [
        GeofenceRadius(id: 'radius_50m', length: 50),
      ],
    ),
    Geofence(
      id: 'ash',
      data: 'The Ashby Building',
      latitude: 54.5800,
      longitude: -5.9354,
      radius: [
        GeofenceRadius(id: 'radius_50m', length: 50),
      ],
    ),
  ];

  // Geofencing initstate
  void geofenceCallbacks() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _geofenceService
          .addGeofenceStatusChangeListener(_onGeofenceStatusChanged);
      _geofenceService.addLocationServicesStatusChangeListener(
          _onLocationServicesStatusChanged);
      _geofenceService.addStreamErrorListener(_onError);
      _geofenceService.start(_geofenceList).catchError(_onError);
      _geofenceController.add(
        GeofenceModel(
          geofenceStatus: currentGeofenceStatus,
          geofenceId: currentGeofenceId,
        ),
      );
    });
  }

  // This function is to be called when a location services status change occurs
  // since the service was started.
  void _onLocationServicesStatusChanged(bool status) {
    if (kDebugMode) {
      print('isLocationServicesEnabled: $status');
    }
  }

  // This function is used to handle errors that occur in the service.
  //possibly not necessary
  void _onError(error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      if (kDebugMode) {
        print('Undefined error: $error');
      }
      return;
    }
    if (kDebugMode) {
      print('ErrorCode: $errorCode');
    }
  }

  //Geofence status change method
  Future<void> _onGeofenceStatusChanged(
      Geofence geofence,
      GeofenceRadius geofenceRadius,
      GeofenceStatus geofenceStatus,
      Location location) async {
    if (kDebugMode) {
      print('geofenceStatus: $geofenceStatus');
    }
    currentGeofenceStatus = geofenceStatus.toString();

    if (geofenceStatus.toString() == "GeofenceStatus.ENTER") {
      if (kDebugMode) {
        print("You are in ${geofence.data}");
      }
      currentGeofenceId = geofence.data.toString();
      firestoreService.addUserInBuildings(geofence.id.toString());
      firestoreService.addLog(geofence.id, true);
    }
    if (geofenceStatus.toString() == "GeofenceStatus.EXIT") {
      if (kDebugMode) {
        print("You are not within range of your organisation, that's an L");
      }
      firestoreService.removeUserInBuildings(geofence.id.toString());
      firestoreService.addLog(geofence.id, false);
    }
    getGeofenceModel(geofenceStatus.toString(), geofence.data.toString());
  }

  final StreamController<GeofenceModel> _geofenceController =
      StreamController<GeofenceModel>.broadcast();

  Stream<GeofenceModel> get geofenceStream => _geofenceController.stream;

  Future<GeofenceModel> getGeofenceModel(
      String geofenceStatus, String geofenceId) async {
    _geofenceModel = GeofenceModel(
      geofenceStatus: geofenceStatus,
      geofenceId: geofenceId,
    );
    return _geofenceModel;
  }

  static String getCurrentGeofenceId() {
    return currentGeofenceId;
  }

  static String getCurrentGeofenceStatus() {
    return currentGeofenceStatus;
  }

  void dispose() {
    _geofenceService.stop();
  }
}

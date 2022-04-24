import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:location_tracker/models/user_location.dart';

class LocationService {
  // Keep track of current Location
  late UserLocation _currentLocation;
  Location location = Location();
  // Continuously emit location updates
  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          _locationController.add(UserLocation(
            lat: locationData.latitude!,
            lng: locationData.longitude!,
          ));
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        lat: userLocation.latitude!,
        lng: userLocation.longitude!,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Could not get the location: $e');
      }
    }

    return _currentLocation;
  }
}

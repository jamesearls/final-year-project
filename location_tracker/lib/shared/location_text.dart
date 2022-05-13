import 'package:flutter/material.dart';
import 'package:location_tracker/services/geofencing_service.dart';

class LocationText extends StatefulWidget {
  const LocationText({Key? key}) : super(key: key);

  @override
  State<LocationText> createState() => _LocationTextState();
}

class _LocationTextState extends State<LocationText> {
  @override
  Widget build(BuildContext context) {
    String message = "";
    if (GeofencingService.currentGeofenceStatus == "GeofenceStatus.ENTER" ||
        GeofencingService.currentGeofenceStatus == "GeofenceStatus.DWELL") {
      message = GeofencingService.getCurrentGeofenceId();
    } else {
      message = "not in your org";
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text('Your current location is: $message'),
      ),
    );
  }
}

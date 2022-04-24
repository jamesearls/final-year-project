import 'package:flutter/material.dart';
import 'package:location_tracker/models/geofence_model.dart';
import 'package:location_tracker/models/user_location.dart';
import 'package:location_tracker/services/geofencing_service.dart';
import 'package:provider/provider.dart';

class LocationText extends StatefulWidget {
  const LocationText({Key? key}) : super(key: key);

  @override
  State<LocationText> createState() => _LocationTextState();
}

class _LocationTextState extends State<LocationText> {
  @override
  Widget build(BuildContext context) {
    // var geofenceModel = Provider.of<GeofenceModel?>(context);
    // String geofenceStatus = geofenceModel?.geofenceStatus ?? 'Unknown';
    // String geofenceId = geofenceModel?.geofenceId ?? 'Unknown';
    String message = "";

    var userLocation = Provider.of<UserLocation?>(context);
    // double lat = userLocation?.lat ?? 0.0;
    // double lng = userLocation?.lng ?? 0.0;

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

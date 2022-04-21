import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_location.dart';

class LocationText extends StatelessWidget {
  const LocationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation?>(context);
    double lat = userLocation?.lat ?? 0.0;
    double lng = userLocation?.lng ?? 0.0;

    return Center(
      child: Text('Your Current Location is $lat, $lng'),
    );
  }
}

import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/models/user_location.dart';
import 'package:provider/provider.dart';

import '../../services/geofencing_service.dart';

double lat = 0.0;
double lng = 0.0;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    GeofencingService().geofenceCallbacks();
    _setMarkerIcon();
    _setCircles();
  }

  final Set<Marker> _markers = HashSet<Marker>();
  final Set<Circle> _circles = HashSet<Circle>();

  late BitmapDescriptor _markerIcon;

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/icons/uni_icon.png');
  }

  void _setCircles() {
    _circles.add(
      const Circle(
          circleId: CircleId("0"),
          center: LatLng(54.581693492339554, -5.937653084607269),
          radius: 50,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(102, 51, 153, .5)),
    );

    _circles.add(
      const Circle(
          circleId: CircleId("1"),
          center: LatLng(54.58450877946409, -5.9351481555057),
          radius: 50,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(102, 51, 153, .5)),
    );

    _circles.add(
      const Circle(
          circleId: CircleId("2"),
          center: LatLng(54.58007604272878, -5.935428955236295),
          radius: 50,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(102, 51, 153, .5)),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId("0"),
        position: const LatLng(54.581693492339554, -5.937653084607269),
        infoWindow: const InfoWindow(
            title: "Computer Science Building", snippet: "The hub of EEECS"),
        icon: _markerIcon,
      ));
      _markers.add(Marker(
        markerId: const MarkerId("1"),
        position: const LatLng(54.58450877946409, -5.9351481555057),
        infoWindow: const InfoWindow(
            title: "Lanyon Building",
            snippet: "The first building you think of when someone says QUB!"),
        icon: _markerIcon,
      ));
      _markers.add(Marker(
        markerId: const MarkerId("2"),
        position: const LatLng(54.58007604272878, -5.935428955236295),
        infoWindow: const InfoWindow(
            title: "Ashby Building",
            snippet: "Where all the other Engineers come from..."),
        icon: _markerIcon,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation?>(context);
    lat = userLocation?.lat ?? 0.0;
    lng = userLocation?.lng ?? 0.0;

    String _currentLocationMessage = "You are in the ";
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(lat, lng), zoom: 16),
              markers: _markers,
              circles: _circles,
              zoomGesturesEnabled: false,
              buildingsEnabled: false,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              scrollGesturesEnabled: false,
              onMapCreated: _onMapCreated,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: Text(
                GeofencingService.getCurrentGeofenceId(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ));
  }

  Future<void> centerScreen(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 16.0)));
  }
}

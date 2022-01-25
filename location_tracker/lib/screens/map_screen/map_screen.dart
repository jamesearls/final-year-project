import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/models/user_location.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = HashSet<Marker>();
  final Set<Circle> _circles = HashSet<Circle>();

  late BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setCircles();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/uni_icon.png');
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                  target:
                      LatLng(userLocation!.latitude, userLocation.longitude),
                  zoom: 16),
              markers: _markers,
              circles: _circles,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: const Text("Coding with James"),
            )
          ],
        ));
  }
}

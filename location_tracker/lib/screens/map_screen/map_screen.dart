import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:location_tracker/models/user_location.dart';
import 'package:provider/provider.dart';

double lat = 0.0;
double lng = 0.0;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setCircles();

    //Geofencing initstate
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _geofenceService
          .addGeofenceStatusChangeListener(_onGeofenceStatusChanged);
      // _geofenceService.addLocationChangeListener(_onLocationChanged);
      _geofenceService.addLocationServicesStatusChangeListener(
          _onLocationServicesStatusChanged);
      _geofenceService.addStreamErrorListener(_onError);
      _geofenceService.start(_geofenceList).catchError(_onError);
    });
  }

  // Geofensing service
  final _geofenceStreamController = StreamController<Geofence>();

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

  // Create a [Geofence] list.
  final _geofenceList = <Geofence>[
    Geofence(
      id: 'The CSB',
      latitude: 54.5817,
      longitude: -5.9377,
      radius: [
        GeofenceRadius(id: 'radius_50m', length: 50),
      ],
    ),
    Geofence(
      id: 'The Lanyon Building',
      latitude: 54.5845,
      longitude: -5.9350,
      radius: [
        GeofenceRadius(id: 'radius_50m', length: 50),
      ],
    ),
    Geofence(
      id: 'The Ashby Building',
      latitude: 54.5800,
      longitude: -5.9354,
      radius: [
        GeofenceRadius(id: 'radius_50m', length: 50),
      ],
    ),
  ];

  final Set<Marker> _markers = HashSet<Marker>();
  final Set<Circle> _circles = HashSet<Circle>();

  late BitmapDescriptor _markerIcon;

  String _currentLocationMessage =
      "Geofencing service not started, please walk into range of your organisation";

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

  // This function is to be called when a location services status change occurs
  // since the service was started.
  void _onLocationServicesStatusChanged(bool status) {
    print('isLocationServicesEnabled: $status');
  }

  // This function is used to handle errors that occur in the service.
  //possibly not necessary
  void _onError(error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }
    print('ErrorCode: $errorCode');
  }

  //Geofence status change method
  Future<void> _onGeofenceStatusChanged(
      Geofence geofence,
      GeofenceRadius geofenceRadius,
      GeofenceStatus geofenceStatus,
      Location location) async {
    print('geofenceStatus: ${geofenceStatus.toString()}');
    if (geofenceStatus.toString() == "GeofenceStatus.ENTER") {
      setState(() {
        _currentLocationMessage = geofence.id.toString();
      });

      print("Yer in ${geofence.id} now bai");
    }
    if (geofenceStatus.toString() == "GeofenceStatus.EXIT") {
      setState(() {
        _currentLocationMessage =
            "No longer in within range of a building in your Org";
      });

      print("Yer not in within range of your organisation, that's an L");
    }

    _geofenceStreamController.sink.add(geofence);
  }

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation?>(context);
    lat = userLocation?.lat ?? 0.0;
    lng = userLocation?.lng ?? 0.0;

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
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              scrollGesturesEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: Text(
                _currentLocationMessage,
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

  @override
  void dispose() {
    _geofenceStreamController.close();
    super.dispose();
  }
}

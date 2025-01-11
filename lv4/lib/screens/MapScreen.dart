import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_flutter_project/models/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  final Location location;

  const MapScreen({required this.location});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  final Map<PolylineId, Polyline> _polylinesMap = {};

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    Position? position = await _getCurrentLocation();
    if (position != null) {
      List<LatLng> polylinePoints = await _getPolylinePoints(position);
      _generatePolyLineFromPoints(polylinePoints);
    }
  }

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _addMarker(42, 21);
      _addMarker(widget.location.latitude, widget.location.longitude);
    });

    return position;
  }

  Future<List<LatLng>> _getPolylinePoints(Position position) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: '<API-KEY-HERE>',
      request: PolylineRequest(
        origin: PointLatLng(42, 21),
        destination:
            PointLatLng(widget.location.latitude, widget.location.longitude),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void _addMarker(double latitude, double longitude) {
    _markers.add(Marker(
      markerId: MarkerId('$latitude,$longitude'),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: 'Location'),
    ));
  }

  void _generatePolyLineFromPoints(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blueAccent,
        points: polylineCoordinates,
        width: 6);
    setState(() {
      _polylinesMap[id] = polyline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.name),
        backgroundColor: Colors.black,
      ),
      body: (_currentPosition != null)
          ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(widget.location.latitude, widget.location.longitude),
                zoom: 14,
              ),
              markers: _markers,
              polylines: Set<Polyline>.of(_polylinesMap.values),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

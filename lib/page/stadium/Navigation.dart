// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'dart:math' as math;
import 'dart:async'; // import this for StreamSubscription

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigateStadium createState() => _NavigateStadium();
}

class _NavigateStadium extends State<Navigation> {
  Position? _currentPosition;
  final LatLng _destination =
      const LatLng(-27.466618, 153.009418); // updated destination
  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> requestPermission() async {
    final permission = await LocationPermissions().requestPermissions();
    if (permission == PermissionStatus.granted) {
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      _positionStreamSubscription = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.high,
        distanceFilter: 10, // Trigger updates every 10 meters
      ).listen((Position position) {
        setState(() {
          _currentPosition = position;
        });
      });
    // ignore: empty_catches
    } catch (e) {
    }
  }

  void onMapCreated(GoogleMapController controller) {
    // Add print statement
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context)),
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Transform.rotate(
                    angle: calculateBearing(_currentPosition!,
                        _destination), // Calculate the bearing to the destination
                    child: const Icon(Icons.arrow_upward,
                        size: 100.0), // Show a large arrow icon
                  ),
                  Text(
                    '${calculateDistance(_currentPosition!, _destination)} km', // Calculate the distance to the destination
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ),
    );
  }

  double calculateBearing(Position currentPosition, LatLng destination) {
    final start = latlng.LatLng(currentPosition.latitude, currentPosition.longitude);
    final end = latlng.LatLng(destination.latitude, destination.longitude);

    double deltaLong = (end.longitude - start.longitude) * (math.pi / 180);
    double startLat = start.latitude * (math.pi / 180);
    double endLat = end.latitude * (math.pi / 180);

    double y = math.sin(deltaLong) * math.cos(endLat);
    double x = math.cos(startLat) * math.sin(endLat) - math.sin(startLat) * math.cos(endLat) * math.cos(deltaLong);
    double bearing = math.atan2(y, x);

    // Convert from radians to degrees and normalize the bearing to positive degrees
    bearing = (bearing * (180 / math.pi) + 360) % 360;

    // Convert degrees to radians for the return value
    return bearing * (math.pi / 180);
  }

  double calculateDistance(Position currentPosition, LatLng destination) {
    final start =
        latlng.LatLng(currentPosition.latitude, currentPosition.longitude);
    final end = latlng.LatLng(destination.latitude, destination.longitude);

    final distance = const latlng.Distance().distance(start, end);

    // Convert meters to kilometers
    return distance / 1000;
  }
}
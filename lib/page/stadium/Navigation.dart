// ignore_for_file: unused_field, file_names, library_private_types_in_public_api, empty_catches

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter_compass/flutter_compass.dart'; // import the flutter_compass package

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  _NavigateStadium createState() => _NavigateStadium();
}

class _NavigateStadium extends State<Navigation> {
  Position? _currentPosition;
  final LatLng _destination = const LatLng(-27.466618, 153.009418);
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
        distanceFilter: 10,
      ).listen((Position position) {
        setState(() {
          _currentPosition = position;
        });
      });
    } catch (e) {}
  }

  double calculateBearing(LatLng start, LatLng destination) {
    double startLatitude = start.latitude;
    double startLongitude = start.longitude;
    double endLatitude = destination.latitude;
    double endLongitude = destination.longitude;

    double longitudeDifference = endLongitude - startLongitude;
    double y = math.sin(longitudeDifference) * math.cos(endLatitude);
    double x = math.cos(startLatitude) * math.sin(endLatitude) - math.sin(startLatitude) * math.cos(endLatitude) * math.cos(longitudeDifference);
    double resultDegree = (math.atan2(y, x) * 180.0 / math.pi + 360.0) % 360.0;
    return resultDegree;
  }

  void onMapCreated(GoogleMapController controller) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFECECEC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<Position>(
        stream: Geolocator.getPositionStream(
          desiredAccuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder<CompassEvent>(
                    stream: FlutterCompass.events,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        double? direction = snapshot.data?.heading;
                        if (direction == null) {
                          return const Center(
                              child: Text(
                                  'Device does not have sensors to capture compass reading.'));
                        }

                        if (_currentPosition != null) {
                          final bearing = calculateBearing(
                            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                            _destination,
                          );
                          direction = bearing - direction;
                        }

                        return Transform.rotate(
                          angle: ((direction) * (math.pi / 180) * -1),
                          child: const Icon(
                            Icons.arrow_upward,
                            size: 150.0,
                            color: Colors.orange,
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  Text(
                    calculateDistance(snapshot.data!, _destination),
                    style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  String calculateDistance(Position currentPosition, LatLng destination) {
    final start =
        latlng.LatLng(currentPosition.latitude, currentPosition.longitude);
    final end = latlng.LatLng(destination.latitude, destination.longitude);

    final distance = const latlng.Distance().distance(start, end);

    if (distance < 1000) {
      return '${distance.toStringAsFixed(2)} m';
    } else {
      return '${(distance / 1000).toStringAsFixed(2)} km';
    }
  }
}

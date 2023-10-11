// ignore_for_file: file_names, library_private_types_in_public_api, empty_catches, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter_compass/flutter_compass.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigateStadium createState() => _NavigateStadium();
}

class _NavigateStadium extends State<Navigation> {
  Position? _currentPosition;
  final LatLng _destination = const LatLng(-27.466618, 153.009418);
  StreamSubscription<Position>? _positionStreamSubscription;
  double _compassHeading = 0;
  StreamSubscription<CompassEvent>? _compassStreamSubscription;

  @override
  void initState() {
    super.initState();
    requestPermission();

    if (FlutterCompass.events != null) {
      _compassStreamSubscription =
          FlutterCompass.events!.listen((CompassEvent event) {
        setState(() {
          _compassHeading = event.heading ?? _compassHeading;
        });
      });
    }
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _compassStreamSubscription?.cancel();
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
    double x = math.cos(startLatitude) * math.sin(endLatitude) -
        math.sin(startLatitude) *
            math.cos(endLatitude) *
            math.cos(longitudeDifference);
    double resultDegree = (math.atan2(y, x) * 180.0 / math.pi + 360.0) % 360.0;
    return resultDegree;
  }

  @override
  Widget build(BuildContext context) {
    double? bearing;
    if (_currentPosition != null) {
      bearing = calculateBearing(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        _destination,
      );
    }

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
            _currentPosition =
                snapshot.data; // update the current position here

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (_currentPosition != null) ...[
                    Transform.rotate(
                      angle: ((_compassHeading - bearing!) / 180) * math.pi,
                      child: const Icon(
                        Icons.arrow_upward,
                        size: 150.0,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      calculateDistance(_currentPosition!, _destination),
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ] else ...[
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
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
    final distance = latlng.Distance().distance(start, end);
    return "Distance: ${(distance / 1000).toStringAsFixed(2)} km";
  }
}

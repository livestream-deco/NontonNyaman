// ignore_for_file: file_names, library_private_types_in_public_api, empty_catches, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math';

class NavigationArrow extends StatefulWidget {
  const NavigationArrow({super.key});

  @override
  _NavigationArrowState createState() => _NavigationArrowState();
}

class _NavigationArrowState extends State<NavigationArrow> {
  double? _arrowRotation;
  Position? _currentPosition;
  
  final double destinationLatitude = -27.472596928988683; // Put your destination coordinates here
  final double destinationLongitude = 153.02713258868744;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    FlutterCompass.events!.listen((CompassEvent event) {
      setState(() {
        _arrowRotation = _calculateArrowRotation(event.heading);
      });
    });
  }

  void _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
        setState(() {
          _currentPosition = position;
        });
      }).catchError((e) {
        print(e);
      });
  }

  double _calculateArrowRotation(double? heading) {
    if (_currentPosition == null || heading == null) {
      return 0;
    }

    double bearingToDestination = _calculateBearing(_currentPosition!.latitude, _currentPosition!.longitude, destinationLatitude, destinationLongitude);
    double rotation = bearingToDestination - heading;
  
    // Ensure rotation is within -180 to +180 degrees
    if (rotation > 180) {
      rotation -= 360;
    } else if (rotation < -180) {
      rotation += 360;
    }

    return rotation;
  }

  double _calculateBearing(double lat1, double lon1, double lat2, double lon2) {
    lat1 = _degreesToRadians(lat1);
    lon1 = _degreesToRadians(lon1);
    lat2 = _degreesToRadians(lat2);
    lon2 = _degreesToRadians(lon2);

    double dLon = (lon2 - lon1);

    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

    double bearing = (atan2(y, x));

    // Convert from radians to degrees
    bearing = _radiansToDegrees(bearing);

    // Normalize to 0-360
    bearing = (bearing + 360) % 360;

    return bearing;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  double _radiansToDegrees(double radians) {
    return radians * 180 / pi;
  }

  // Calculate the distance between the current location and the destination
  String _calculateDistance() {
    if (_currentPosition == null) {
      return 'Calculating...';
    }

    double distanceInMeters = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      destinationLatitude, 
      destinationLongitude
    );

    if (distanceInMeters < 1000) {
      return '${distanceInMeters.toStringAsFixed(0)} m';
    } else {
      return '${(distanceInMeters / 1000).toStringAsFixed(2)} km';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: ((_arrowRotation ?? 0) * pi) / 180,
              child: Icon(Icons.arrow_upward, size: 100),
            ),
            Text(
              _calculateDistance(),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
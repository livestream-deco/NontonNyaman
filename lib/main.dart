import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigationArrow(),
    );
  }
}

class NavigationArrow extends StatefulWidget {
  @override
  _NavigationArrowState createState() => _NavigationArrowState();
}

class _NavigationArrowState extends State<NavigationArrow> {
  double? _arrowRotation;
  Position? _currentPosition;

  final double destinationLatitude =
      -27.466618; // Put your destination coordinates here
  final double destinationLongitude = 153.009418;

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

    double bearingToDestination = _calculateBearing(_currentPosition!.latitude,
        _currentPosition!.longitude, destinationLatitude, destinationLongitude);
    return bearingToDestination - heading;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.rotate(
          angle: _arrowRotation ?? 0,
          child: Icon(Icons.arrow_upward, size: 100),
        ),
      ),
    );
  }
}

// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:my_app/welcomePage.dart';

void main() {
  runApp(MyApp());
}

// this is the main app which return the application and we already set into always welcoming page
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

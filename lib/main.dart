import 'package:flutter/material.dart';
import 'package:my_app/page/authentication/LoginPage.dart';
import 'package:my_app/page/navbar.dart';



void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      
    );
  }
}
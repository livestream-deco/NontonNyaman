import 'package:flutter/material.dart';
import 'package:my_app/page/HomePage.dart';
import 'package:my_app/page/profile/profile.dart';
import 'package:my_app/page/requestAssistance/RequestHomePage.dart';
import 'package:my_app/page/stadium/StadiumFeature.dart';
import 'package:my_app/page/emergency/emergency.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarPage createState() => _NavbarPage();
}

class _NavbarPage extends State<Navbar> {
  int currentIndex = 0;

  final screen = [HomeView(), Stadium(),Emergency(), Request(), Profile()];
  
  @override
  Widget build(BuildContext context) => Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xffFF7D05),
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: InkResponse(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
              padding: const EdgeInsets.only(),
              child: const Icon(Icons.house_outlined),
            ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(),
              child: const Icon(Icons.map),
            ),
            label: 'Navigation',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFF7D05),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 45,
                color: Colors.white,
              ),
            ),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(),
              child: const Icon(Icons.call),
            ),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(),
              child: const Icon(Icons.account_box_outlined),
            ),
            label: 'Profile',
          ),
        ],
      )
    );
}
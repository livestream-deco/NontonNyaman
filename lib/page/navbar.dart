import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/page/HomePage.dart';
import 'package:my_app/page/profile/profile.dart';
import 'package:my_app/page/emergency/emergency.dart';
import 'package:my_app/page/requestAssistance/chooseStadium.dart';
import 'package:my_app/page/stadium/searchingPage.dart';

// ignore: must_be_immutable
class Navbar extends StatefulWidget {
  final User user;
  const Navbar(this.user, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavbarPage createState() => _NavbarPage();
}

class _NavbarPage extends State<Navbar> {
  int currentIndex = 0;
  //there are 5 screen that need will be in the navigation bar
  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeView(widget.user),
      const SearchPage(),
      Emergency(widget.user),
      ChoosePage(widget.user),
      Profile(widget.user)
    ];

    return Scaffold(
      //the screen will show the first screen since the current index is set into 0
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xffFF7D09),
        unselectedItemColor: const Color(0xffFF7D05),
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          // first screen = news
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(),
              child: const Icon(Icons.newspaper_outlined),
            ),
            label: 'News',
          ),
          // second screen stadium
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(),
              child: const Icon(Icons.map),
            ),
            label: 'Stadium',
          ),
          // third screen = emergency
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(),
              decoration: const BoxDecoration(
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
          //fourth screen = assistance
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(),
              child: const Icon(Icons.call),
            ),
            label: 'Assistance',
          ),
          //fifth screen = profile
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(),
              child: const Icon(Icons.account_box_outlined),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
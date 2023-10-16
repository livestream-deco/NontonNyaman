// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/page/staff/HomeStaff.dart';
import 'package:my_app/page/staff/profileStaff.dart';

// ignore: must_be_immutable
class NavbarStaff extends StatefulWidget {
  final User user;
  const NavbarStaff(this.user, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavbarPageStaff createState() => _NavbarPageStaff();
}

class _NavbarPageStaff extends State<NavbarStaff> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      Home(widget.user),
      ProfileStaff(widget.user)
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xffFF7D09),
        unselectedItemColor: const Color(0xffFF7D05),
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(),
              child: const Icon(Icons.house_outlined),
            ),
            label: 'Home',
          ),
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
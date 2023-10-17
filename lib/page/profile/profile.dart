// ignore_for_file: avoid_

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/models/user.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/page/profile/editProfile.dart';

Future<Map<String, dynamic>> fetchUser(User user) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/user_info/?session_id=${user.sessionId}';

  try {
    final response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> userData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {"isSuccessful": true, "data": userData, "error": null};
    } else {
      return {
        "isSuccessful": false,
        "data": userData,
        "error": "An error has occurred"
      };
    }
  } catch (error) {
    return {
      "isSuccessful": false,
      "data": {},
      "error": "Our web service is down."
    };
  }
}

class Profile extends StatefulWidget {
  final User user;
  const Profile(this.user, {super.key});

  @override
  ProfilePage createState() => ProfilePage();
}

class ProfilePage extends State<Profile> {
  Map<String, dynamic> response = {};
  Map<String, dynamic> user = {};
  Future<void> _intializeData() async {
    response = await fetchUser(widget.user);
    if (response["isSuccessful"]) {
      user = response["data"];
      (user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFECECEC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFECECEC)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black, // Specify the color here.
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
              size: 25.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFECECEC),
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: _intializeData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Data fetched successfully
                  final data = snapshot.data;
                  // Render the news carousel using the data
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Stack(
                        children: <Widget>[
                          // The image
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                      jsonDecode(user['user_picture']),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // The edit button
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile(widget
                                          .user)), // Change NewPage to your target page
                                );
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(
                                      0XFFFF5C00), // Change this to the color you want for the background of the circle.
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons
                                      .edit, // Change this to the icon you want.
                                  color: Colors
                                      .black, // Change this to the color you want for the icon.
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                        height: 500,
                        width: 500,
                        decoration: const BoxDecoration(
                            color: Color(0XFFFF5C00),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Fullname',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                    height: 48,
                                    width: 500,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      border: Border.all(
                                        color: Colors
                                            .white, // Specify the border color here.
                                        width:
                                            2, // Specify the border width here.
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        user['name'],
                                        style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  height: 48,
                                  width: 500,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    border: Border.all(
                                      color: Colors
                                          .white, // Specify the border color here.
                                      width:
                                          2, // Specify the border width here.
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      user['email'],
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  height: 48,
                                  width: 500,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    border: Border.all(
                                      color: Colors
                                          .white, // Specify the border color here.
                                      width:
                                          2, // Specify the border width here.
                                    ),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        user['disability'],
                                        style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  );
                }
              })),
    );
  }
}

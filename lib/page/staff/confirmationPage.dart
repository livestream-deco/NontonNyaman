// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_import, avoid_

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/page/authentication/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/page/navbar.dart';
import 'package:my_app/page/navbarStaff.dart';
import 'package:my_app/page/profile/profile.dart';
import 'package:my_app/page/stadium/StadiumFeature.dart';
import 'package:my_app/page/stadium/StadiumInfo.dart';

// fetch the user using their email
Future<Map<String, dynamic>> fetchUser(String email) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/user-info-detail/?email=$email';

  try {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    Map<String, dynamic> userData = jsonDecode(response.body);

    // await Future.delayed(Duration(seconds: 10));
    if (response.statusCode == 200) {
      return {"isSuccessful": true, "data": userData, "error": null};
    } else {
      return {
        "isSuccessful": false,
        "data": [],
        "error": "An error has occurred"
      };
    }
  } catch (error) {
    return {
      "isSuccessful": false,
      "data": [],
      "error": "Our web service is down."
    };
  }
}


// fetch the user if confirm the user
Future<Map<String, dynamic>> pickStaff(User user, String email) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/confirm-user/?session_id=${user.sessionId}&email=$email';
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  Map<String, dynamic> body = {'session_id': user.sessionId, 'email': email};

  final response = await http.put(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    return {"isSuccessful": true, "error": null};
  } else {
    return {"isSuccessful": false, "error": "An error has occurred"};
  }
}

// the fetch for decline the user
Future<Map<String, dynamic>> declineUser(User user, String email) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/decline-user/?session_id=${user.sessionId}&email=$email';

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Map<String, dynamic> body = {'session_id': user.sessionId, 'email': email};

  final response = await http.delete(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    return {"isSuccessful": true, "error": null};
  } else {
    return {"isSuccessful": false, "error": "An error has occurred"};
  }
}

class UserDetail extends StatefulWidget {
  final User user;
  final String email;
  const UserDetail(this.user, this.email, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserDetailPage createState() => _UserDetailPage();
}

class _UserDetailPage extends State<UserDetail> {
  Map<String, dynamic> allStaff = {};
  Map<String, dynamic> userData = {};
  Map<String, dynamic> response = {};
  Map<String, dynamic> response2 = {};

  Future<void> _intializeData() async {
    response = await fetchUser(widget.email);
    if (response["isSuccessful"]) {
      allStaff = response["data"];
    }
  }

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
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Assistant Detail",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: FutureBuilder(
                                      future: _intializeData(),
                                      builder: (context, snapshot) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Container(
                                                width: 500,
                                                height: 500,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    // ignore: duplicate_ignore, duplicate_ignore
                                                    children: [
                                                      // ignore: sized_box_for_whitespace
                                                      Row(children: [
                                                        Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                // ignore: prefer_interpolation_to_compose_strings
                                                                'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                                                    jsonDecode(
                                                                        allStaff[
                                                                            'user_picture']),
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 25,
                                                        ),
                                                        Text(
                                                          allStaff['name'],
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ]),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        allStaff["email"],
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 100,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors
                                                              .white, // Change this to the color you want for the background of the circle.
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Icon(
                                                          Icons
                                                              .check, // Change this to the icon you want.
                                                          color: Colors
                                                              .green, // Change this to the color you want for the icon.
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        pickStaff(widget.user,
                                                            widget.email);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      NavbarStaff(
                                                                        widget
                                                                            .user,
                                                                      )),
                                                        );
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    IconButton(
                                                      icon: Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors
                                                              .white, // Change this to the color you want for the background of the circle.
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Icon(
                                                          Icons
                                                              .cancel, // Change this to the icon you want.
                                                          color: Colors
                                                              .red, // Change this to the color you want for the icon.
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        declineUser(widget.user,
                                                            widget.email);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      NavbarStaff(
                                                                        widget
                                                                            .user,
                                                                      )),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        );
                                      }))
                            ])))
              ]),
        ));
  }
}

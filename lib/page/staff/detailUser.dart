// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_import

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

Future<Map<String, dynamic>> fetchStadium(String email) async {
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

class UserInfoPage extends StatefulWidget {
  final User user;
  final String email;
  const UserInfoPage(this.user, this.email, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserDetailPage createState() => _UserDetailPage();
}

class _UserDetailPage extends State<UserInfoPage> {
  Map<String, dynamic> allStaff = {};
  Map<String, dynamic> userData = {};
  Map<String, dynamic> response = {};
  Map<String, dynamic> response2 = {};

  Future<void> _intializeData() async {
    response = await fetchStadium(widget.email);
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
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavbarStaff(widget.user)),
                  )),
          title: const Text(
            'Back to the Home Page',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black, // Specify the color here.
            ),
          ),
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
                                                              const BoxDecoration(
                                                            color: Colors.black,
                                                            shape:
                                                                BoxShape.circle,
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
                                            Container(
                                              key: const Key("loginAccount"),
                                              alignment: Alignment.center,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            48),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        const Color(0XFFFF5C00),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    )),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NavbarStaff(
                                                                widget.user)),
                                                  );
                                                },
                                                child: const Text(
                                                  'End Task',
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }))
                            ])))
              ]),
        ));
  }
}

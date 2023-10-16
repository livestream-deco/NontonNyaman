// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_import, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/page/authentication/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/page/navbarStaff.dart';
import 'package:my_app/page/profile/profile.dart';
import 'package:my_app/page/requestAssistance/assistancePage.dart';
import 'package:my_app/page/stadium/StadiumInfo.dart';
import 'package:my_app/page/staff/confirmationPage.dart';

Future<Map<String, dynamic>> fetchStadium(User user) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/stadium/list-request/?session_id=${user.sessionId}';

  try {
    final response = await http.get(
      Uri.parse(url),
    );

    List<dynamic> extractedData = jsonDecode(response.body);

    // await Future.delayed(Duration(seconds: 10));
    if (response.statusCode == 200) {
      return {"isSuccessful": true, "data": extractedData, "error": null};
    } else {
      return {
        "isSuccessful": false,
        "data": extractedData,
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

Future<Map<String, dynamic>> fetchStaff(User user) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/info-staff/?session_id=${user.sessionId}';

  try {
    final response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> extractedData = jsonDecode(response.body);
    print(extractedData);
    // await Future.delayed(Duration(seconds: 10));
    if (response.statusCode == 200) {
      return {"isSuccessful": true, "data": extractedData, "error": null};
    } else {
      return {
        "isSuccessful": false,
        "data": extractedData,
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

Future<Map<String, dynamic>> endTask(User user) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/end-task/?session_id=${user.sessionId}';

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await http.put(
    Uri.parse(url),
    headers: headers,
  );

  // await Future.delayed(Duration(seconds: 10));
  if (response.statusCode == 200) {
    return {"isSuccessful": true, "error": null};
  } else {
    return {"isSuccessful": false, "error": "An error has occurred"};
  }
}

class Home extends StatefulWidget {
  final User user;
  const Home(this.user, {super.key});

  @override
  HomeStaff createState() => HomeStaff();
}

class HomeStaff extends State<Home> {
  List<dynamic> allStaff = [];
  Map<String, dynamic> response = {};
  Map<String, dynamic> response2 = {};
  Map<String, dynamic> userData = {};

  Future<void> _intializeData() async {
    response = await fetchStadium(widget.user);
    if (response["isSuccessful"]) {
      allStaff = response["data"];
    }
    response2 = await fetchStaff(widget.user);
    if (response2["isSuccessful"]) {
      userData = response2["data"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _intializeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!userData["confirmed"]) {
              return Scaffold(
                  backgroundColor: const Color(0xFFECECEC),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            "Customer Assistance Request",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          SingleChildScrollView(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          'Please Choose one of the User below',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: FutureBuilder(
                                                future: _intializeData(),
                                                builder: (context, snapshot) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      for (int i = 0;
                                                          i < allStaff.length;
                                                          i++)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10),
                                                          child: SizedBox(
                                                            width: 500,
                                                            height: 105,
                                                            child:
                                                                ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      minimumSize:
                                                                          const Size
                                                                              .fromHeight(
                                                                              48),
                                                                      elevation:
                                                                          0,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(24),
                                                                      )),
                                                              onPressed:
                                                                  () async {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => UserDetail(
                                                                            widget.user,
                                                                            allStaff[i]['email'])));
                                                              },
                                                              child: Row(
                                                                // ignore: duplicate_ignore, duplicate_ignore
                                                                children: [
                                                                  // ignore: sized_box_for_whitespace
                                                                  Container(
                                                                    width: 80.0,
                                                                    height:
                                                                        80.0,
                                                                    decoration: const BoxDecoration(
                                                                        color: Color(
                                                                            0xffFF7D05),
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(12))),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 25,
                                                                  ),
                                                                  Text(
                                                                    allStaff[i][
                                                                        'name'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  const Icon(
                                                                    Icons
                                                                        .arrow_forward, // This is the arrow
                                                                    color: Color(
                                                                        0xffFF7D05),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                    ],
                                                  );
                                                }))
                                      ])))
                        ]),
                  ));
            } else {
              return Scaffold(
                  backgroundColor: const Color(0xFFECECEC),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'User Detail Page',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 22),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: 500,
                              height: 500,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: duplicate_ignore, duplicate_ignore
                                  children: [
                                    // ignore: sized_box_for_whitespace
                                    Row(children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                                  jsonDecode(
                                                      userData['user_picture']),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        userData["email"],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                    ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      userData["disability"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      userData["name"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Container(
                            key: const Key("loginAccount"),
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(48),
                                  elevation: 0,
                                  backgroundColor: const Color(0XFFFF5C00),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  )),
                              onPressed: () {
                                endTask(widget.user);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NavbarStaff(widget.user)),
                                );
                              },
                              child: const Text(
                                'End Task',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        ]),
                  ));
            }
          } else {
            // This will show while waiting for the future to complete
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}

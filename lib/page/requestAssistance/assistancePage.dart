// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_import, avoid_

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/page/authentication/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/page/navbar.dart';
import 'package:my_app/page/profile/profile.dart';
import 'package:my_app/page/stadium/StadiumFeature.dart';
import 'package:my_app/page/stadium/StadiumInfo.dart';

// fetch the staff detail using their id
Future<Map<String, dynamic>> fetchStaff(int id) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/staff-detail/?input_id=$id';

  try {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Map<String, dynamic> body = {'input_id': id};

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    (jsonDecode(response.body));
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

// this fetch will help for the button for booking the staff
Future<Map<String, dynamic>> pickStaff(User user, String id) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/stadium/pick-staff/?session_id=${user.sessionId}&input_id=$id';
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  Map<String, dynamic> body = {'session_id': user.sessionId, 'input_id': id};

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

class Assistance extends StatefulWidget {
  final User user;
  final int id;
  const Assistance(this.user, this.id, {super.key});

  @override
  AssistanceDetail createState() => AssistanceDetail();
}

class AssistanceDetail extends State<Assistance> {
  // all the list that will be used
  List<dynamic> allStaff = [];
  Map<String, dynamic> userData = {};
  Map<String, dynamic> response = {};
  Map<String, dynamic> response2 = {};


  // set initialize data for fetch staff and put the data into the list
  Future<void> _intializeData() async {
    response = await fetchStaff(widget.id);
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
                                      // future builder for called the initialize data
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
                                                                        allStaff[0]
                                                                            [
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
                                                          allStaff[0]['user'],
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
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        allStaff[0]
                                                            ['phone_number'],
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
                                            Container(
                                              alignment: Alignment.center,
                                              child: ElevatedButton(
                                                key: const Key("addAccount"),
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
                                                  // if the button press, it will automatically fetch the pickStaff and also navigate back to the homepage
                                                onPressed: () {
                                                  pickStaff(widget.user,
                                                      allStaff[0]['staff_id']);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Navbar(
                                                                widget.user)),
                                                  );
                                                },
                                                child: const Text(
                                                  'Book',
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

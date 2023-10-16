// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/page/authentication/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/page/profile/profile.dart';
import 'package:my_app/page/requestAssistance/assistancePage.dart';
import 'package:my_app/page/stadium/StadiumInfo.dart';

Future<Map<String, dynamic>> fetchStaff(User user) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/user_info/?session_id=${user.sessionId}';

  try {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Map<String, dynamic> body = {'session_id': user.sessionId};

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
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

class Pending extends StatefulWidget {
  final User user;
  final int id;
  const Pending(this.user, this.id, {super.key});

  @override
  PendingPage createState() => PendingPage();
}

class PendingPage extends State<Pending> {
  List<dynamic> allStaff = [];
  List<dynamic> userData = [];
  Map<String, dynamic> response = {};
  Map<String, dynamic> response2 = {};

  Future<void> _intializeData() async {
    response = await fetchStaff(widget.user);
    if (response["isSuccessful"]) {
      allStaff = response["data"];
    }
  }

  @override
  Widget build(BuildContext context) {
    FutureBuilder(
        future: _intializeData(),
        builder: (context, snapshot) {
          return allStaff[0]['name'];
        });
    if (allStaff[0]["has_chose"]) {
      return const Scaffold(
        backgroundColor: Color(0xffFF7D05),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Please tap the alert button to call the assistance! berhaisl',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        )),
      );
    }
    return const Scaffold(
      backgroundColor: Color(0xffFF7D05),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please tap the alert button to call the assistance! berhasiljuga',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      )),
    );
  }
}

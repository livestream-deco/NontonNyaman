// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:url_launcher/link.dart';
import 'package:http/http.dart' as http;

// future for fetch the staff with the parameter of the user

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
    Map<String, dynamic> userData = jsonDecode(response.body);

    // await Future.delayed(Duration(seconds: 10));
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
      "data": [],
      "error": "Our web service is down."
    };
  }
}

class Emergency extends StatefulWidget {
  final User user;
  const Emergency(this.user, {Key? key}) : super(key: key);

  @override
  EmergencyPage createState() => EmergencyPage();
}

class EmergencyPage extends State<Emergency> {
  Map<String, dynamic> response = {};
  Map<String, dynamic> allStaff = {};

  // create a future void for intializeData that take the staff data
  Future<void> _intializeData() async {
    response = await fetchStaff(widget.user);
    if (response["isSuccessful"]) {
      allStaff = response["data"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFF7D05),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 250,
            ),
            // using future builder for take the data from the fetch 
            FutureBuilder(
                future: _intializeData(),
                builder: (context, snapshot) {
                  return Link(
                    // make the alert image can direct to the call app and directly call the staff
                    uri: Uri.parse('tel:' + '${allStaff['staff_number']}'),
                    builder: (context, followLink) {
                      return GestureDetector(
                        onTap: followLink,
                        child: Image.asset(
                          'assets/images/alert.png',
                          width: 150,
                          height: 150,
                        ),
                      );
                    },
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Please tap the alert button to call the assistance!',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      )),
    );
  }
}

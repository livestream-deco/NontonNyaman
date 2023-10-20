// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_import, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/page/authentication/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/page/profile/profile.dart';
import 'package:my_app/page/requestAssistance/assistancePage.dart';
import 'package:my_app/page/stadium/StadiumInfo.dart';

// fetch staff using the staff id
Future<Map<String, dynamic>> fetchStaff(int id) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/list_staff/?input_id=$id';

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

class Request extends StatefulWidget {
  final User user;
  final int id;
  const Request(this.user, this.id, {super.key});

  @override
  RequestHome createState() => RequestHome();
}

class RequestHome extends State<Request> {
  // list that will be used in this page
  List<dynamic> allStaff = [];
  List<dynamic> userData = [];
  Map<String, dynamic> response = {};
  Map<String, dynamic> response2 = {};

  // initialize data for put the data in the list 
  Future<void> _intializeData() async {
    response = await fetchStaff(widget.id);
    if (response["isSuccessful"]) {
      allStaff = response["data"];
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
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop()),
        ),
        backgroundColor: const Color(0xFFECECEC),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Request Assistance",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'Available Assistance',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xff16AC25),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                      // using the for loop after taking the initializeData for showing all the list of staff that exist in that stadium
                                  child: FutureBuilder(
                                      future: _intializeData(),
                                      builder: (context, snapshot) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int i = 0;
                                                i < allStaff.length;
                                                i++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Container(
                                                  width: 500,
                                                  height: 105,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            minimumSize:
                                                                const Size
                                                                    .fromHeight(
                                                                    48),
                                                            elevation: 0,
                                                            backgroundColor:
                                                                Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                            )),
                                                    onPressed: () async {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Assistance(
                                                                      widget
                                                                          .user,
                                                                      allStaff[
                                                                              i]
                                                                          [
                                                                          'staff_id'])));
                                                    },
                                                    child: Row(
                                                      // ignore: duplicate_ignore, duplicate_ignore
                                                      children: [
                                                        // ignore: sized_box_for_whitespace
                                                        Container(
                                                          width: 80.0,
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image:
                                                                DecorationImage(
                                                                  // show the image of the staff
                                                              image:
                                                                  NetworkImage(
                                                                // ignore: prefer_interpolation_to_compose_strings
                                                                'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                                                    jsonDecode(
                                                                        allStaff[i]
                                                                            [
                                                                            'userpicture']),
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 25,
                                                        ),
                                                        Text(
                                                          allStaff[i]['user'],
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
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .arrow_forward, 
                                                          color:
                                                              Color(0xffFF7D05),
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
  }
}

// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/page/stadium/Navigation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/link.dart';

Future<Map<String, dynamic>> fetchStadium(int id) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/stadium/view-detail-stadium/?input_id=$id';

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

class Stadium extends StatefulWidget {
  final int id;
  const Stadium(this.id, {super.key});

  @override
  StadiumFeature createState() => StadiumFeature();
}

class StadiumFeature extends State<Stadium> {
  List<dynamic> allStadium = [];
  Map<String, dynamic> response = {};

  Future<void> _intializeData() async {
    response = await fetchStadium(widget.id);
    if (response["isSuccessful"]) {
      allStadium = response["data"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFECECEC),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: FutureBuilder(
                future: _intializeData(),
                builder: (context, snapshot) {
                  String stadiumName = allStadium[0]['stadium_name'];
                  String formattedStadiumName =
                      stadiumName.replaceAll(' ', '+');
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            "Stadium Features",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(allStadium[0]['stadium_name'],
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700)),
                          SingleChildScrollView(
                            child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const Text(
                                      'Quick Access',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      width: 360,
                                      height: 96,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff292929),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: Row(children: [
                                        for (int i = 0;
                                            i <allStadium[0]["features"].length;i++)
                                            Padding(padding: const EdgeInsets.all(10),
                                            child: 
                                              Container(
                                                width: 55.0,
                                                height: 70.0,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(12))),
                                                child: FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: 
                                                        allStadium[0]["features"][i]["name"] == 'Toilet'
                                                        ? Image.asset(
                                                            'assets/images/Vector.png',
                                                            width: 60,
                                                            height: 60,
                                                          )
                                                        : allStadium[0]["features"][i]["name"] == 'Bus Stop'
                                                        ? Image.asset(
                                                            'assets/images/Vector.png',
                                                            width: 60,
                                                            height: 60,
                                                          )
                                                        : allStadium[0]["features"][i]["name"] == 'Taxi stand'
                                                        ? Image.asset(
                                                            'assets/images/taxi_stand.png',
                                                            width: 60,
                                                            height: 60,
                                                          )
                                                        : allStadium[0]["features"][i]["name"] == 'Lift'
                                                        ? Image.asset(
                                                            'assets/images/lift.png',
                                                            width: 60,
                                                            height: 60,
                                                          )
                                                        : allStadium[0]["features"][i]["name"] == 'Entrance'
                                                        ? Image.asset(
                                                            'assets/images/entrance.png',
                                                            width: 60,
                                                            height: 60,
                                                          )
                                                        : Text(allStadium[0]["features"][i]["name"]),
                                                  ),
                                                ),
                                              )
                                            )
                                      ]),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Stadium Map',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Link(
                                      uri: Uri.parse(
                                          'https://www.google.com/maps/search/?api=1&query=$formattedStadiumName'),
                                      builder: (BuildContext context,
                                              FollowLink? followLink) =>
                                          GestureDetector(
                                        onTap: followLink,
                                        child: Container(
                                          width: 400.0,
                                          height: 180.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Image.network(
                                            'http://10.0.2.2:8000' +
                                                jsonDecode(allStadium[0]
                                                    ['stadium_map_picture']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Navigation',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (int i = 0;i <allStadium[0]["features"].length;i++)
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                minimumSize:
                                                    const Size.fromHeight(48),
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color(0xFFECECEC),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                )),
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NavigationArrow(
                                                            latitude: allStadium[0]["features"][i]["latitude"],
                                                            longitude: allStadium[0]["features"][i]["longitude"]
                                                  )));
                                                },
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 80.0,
                                                  height: 80.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors
                                                        .white, // set this to your body background color
                                                    border: Border.all(
                                                      color: Colors
                                                          .orange, // set border color
                                                      width:
                                                          3.0, // set border width
                                                    ),
                                                  ),
                                                  child: allStadium[0]["features"][i]["name"] == 'Toilet'
                                                        ? Image.asset(
                                                            'assets/images/Vector.png',
                                                            width: 60,
                                                            height: 60,
                                                          )
                                                        : allStadium[0]["features"][i]["name"] == 'Bus Stop'
                                                        ? Image.asset(
                                                            'assets/images/Vector.png',
                                                            width: 60,
                                                            height: 60,
                                                          )
                                                        : allStadium[0]["features"][i]["name"] == 'Taxi stand'
                                                        ? Image.asset(
                                                            'assets/images/taxi_stand.png',
                                                            width: 60,
                                                            height: 60,
                                                          )
                                                        : allStadium[0]["features"][i]["name"] == 'Lift'
                                                        ? Image.asset(
                                                            'assets/images/lift.png',
                                                            width: 60,
                                                            height: 60,
                                                          )
                                                        : allStadium[0]["features"][i]["name"] == 'Entrance'
                                                        ? Image.asset(
                                                            'assets/images/entrance.png',
                                                            width: 60,
                                                            height: 60,
                                                          )
                                                          : Text(allStadium[0]["features"][i]["name"]),
                                                ),
                                                const SizedBox(
                                                  width: 50,
                                                ),
                                                Text(
                                                  allStadium[0]["features"][i]["name"],
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                                )
                                              ],
                                            )),
                                        
                                      ],
                                    )
                                  ],
                                )),
                          )
                        ]),
                  );
                })));
  }
}

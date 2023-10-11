// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/page/stadium/StadiumFeature.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchStadium(int id) async {
  String url = 'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/stadium/view-detail-stadium/?input_id=$id';

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

class StadiumInfo extends StatefulWidget {
  final int id;
  const StadiumInfo(this.id, {super.key});

  @override
  StadiumInformation createState() => StadiumInformation();
}

class StadiumInformation extends State<StadiumInfo> {
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
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 410.0,
                            height: 410.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Image.network(
                              'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                  jsonDecode(allStadium[0]['stadium_picture']),
                              fit: BoxFit
                                  .cover, // You can use different BoxFit property as per your requirement
                            ),
                          ),
                          Positioned(
                            top: 320.0, // Adjust this as needed
                            left: 20.0, // Adjust this as needed
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allStadium[0]['stadium_name'],
                                  style: const TextStyle(
                                    color: Colors
                                        .white, // Choose a color that contrasts with your image
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  allStadium[0]['stadium_location'],
                                  style: const TextStyle(
                                    color: Colors
                                        .white, // Choose a color that contrasts with your image
                                    fontSize: 18.0, // Adjust the size as needed
                                    fontWeight: FontWeight
                                        .w700, // Adjust the weight as needed
                                  ),
                                ),
                                // Add more Text widgets as needed
                              ],
                            ),
                          ),
                          Positioned(
                            top: 30.0, // Adjust as needed
                            left: 20.0, // Adjust as needed
                            child: Container(
                              padding: const EdgeInsets.all(
                                  1), // Smaller padding for a smaller circle
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                  icon: const Icon(Icons.arrow_back,
                                      color: Colors.black),
                                  iconSize: 20.0, // Smaller icon size
                                  onPressed: () =>
                                      Navigator.pop(context, true)),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Overview',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffFFA800)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  allStadium[0]['stadium_text'],
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Location',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffFFA800)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 400.0,
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Image.network(
                                    'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                        jsonDecode(allStadium[0]['stadium_map_picture']),
                                    fit: BoxFit
                                        .cover, // You can use different BoxFit property as per your requirement
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    key: const Key("addAccount"),
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(48),
                                        elevation: 0,
                                        backgroundColor:
                                            const Color(0XFFFF5C00),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        )),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Stadium())),
                                    child: const Text(
                                      'Navigate',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            )),
                      )
                    ]);
              },
            )));
  }
}

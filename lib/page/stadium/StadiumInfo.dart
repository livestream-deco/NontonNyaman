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
            //future builder for take the information of the stadium
            child: FutureBuilder(
              future: _intializeData(),
              builder: (context, snapshot) {
                String stadiumName = allStadium[0]['stadium_name'];
                String formattedStadiumName = stadiumName.replaceAll(' ', '+');
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
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                    jsonDecode(allStadium[0]['stadium_picture']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 320.0, 
                            left: 20.0, 
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allStadium[0]['stadium_name'],
                                  style: const TextStyle(
                                    color: Colors
                                        .white, 
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  allStadium[0]['stadium_location'],
                                  style: const TextStyle(
                                    color: Colors
                                        .white, 
                                    fontSize: 18.0,
                                    fontWeight: FontWeight
                                        .w700, 
                                  ),
                                ),
                               
                              ],
                            ),
                          ),
                          Positioned(
                            top: 30.0, 
                            left: 20.0, 
                            child: Container(
                              padding: const EdgeInsets.all(
                                  1),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                  icon: const Icon(Icons.arrow_back,
                                      color: Colors.black),
                                  iconSize: 20.0, 
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
                                // all the text was used from the list that we already fetched
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
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Image.network(
                                        'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                            jsonDecode(allStadium[0]
                                                ['stadium_map_picture']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
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
                                            builder: (context) => Stadium(
                                                allStadium[0]['stadium_id']))),
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

// ignore_for_file: sized_box_for_whitespace, avoid_print, duplicate_ignore, file_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/page/profile/profile.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:my_app/page/requestAssistance/RequestHomePage.dart';
import 'package:my_app/page/stadium/StadiumInfo.dart';
import 'package:http/http.dart' as http;

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

    Map<String, dynamic> extractedData = jsonDecode(response.body);

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

Future<Map<String, dynamic>> fetchStadiums() async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/stadium/view-all-stadium/';

  try {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Map<String, dynamic> body = {};

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

class StadiumA {
  final String stadiumName;

  StadiumA({required this.stadiumName});

  static List<StadiumA> fromJsonList(List<dynamic> list) {
    return list
        .map((item) => StadiumA(stadiumName: item['stadium_name']))
        .toList();
  }
}

class ChoosePage extends StatefulWidget {
  final User user;
  const ChoosePage(this.user, {super.key});

  @override
  ChooseStadium createState() => ChooseStadium();
}

class ChooseStadium extends State<ChoosePage> {
  List<dynamic> allStadiums = [];
  Map<String, dynamic> allStaff = {};
  Map<String, dynamic> response2 = {};
  Map<String, dynamic> response = {};
  late AutoCompleteTextField<StadiumA> searchTextField;
  GlobalKey<AutoCompleteTextFieldState<StadiumA>> key = GlobalKey();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    searchTextField = AutoCompleteTextField<StadiumA>(
      key: key,
      clearOnSubmit: false,
      suggestions: StadiumA.fromJsonList(allStadiums),
      style: const TextStyle(color: Colors.black, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Search Stadium",
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: const Color(0xffD9D9D9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
      itemFilter: (item, query) {
        return item.stadiumName.toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.stadiumName.compareTo(b.stadiumName);
      },
      itemSubmitted: (item) async {
        print("Selected item: '${item.stadiumName}'");
        setState(() {
          if (searchTextField.textField != null &&
              searchTextField.textField!.controller != null) {
            searchTextField.textField!.controller!.text = item.stadiumName;
          }
        });
        if (item.stadiumName == 'Suncorp Stadium') {
          await Future.delayed(const Duration(milliseconds: 100));
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Profile(widget.user)));
        }
      },
      itemBuilder: (context, item) {
        return row(item);
      },
    );
  }

  Future<void> _intializeData() async {
    response = await fetchStadiums();
    if (response["isSuccessful"]) {
      allStadiums = response["data"];
    }
    response2 = await fetchStaff(widget.user);
    if (response2["isSuccessful"]) {
      allStaff = response2["data"];
      print(allStaff);
    }
  }

  Widget row(StadiumA item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          item.stadiumName,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(
          width: 10.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _intializeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!allStaff["has_chose"]) {
            // Your existing widget building logic here...
            return Scaffold(
                backgroundColor: const Color(0xFFECECEC),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Please Choose The Stadium Below",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  FutureBuilder(
                                    future: _intializeData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return AutoCompleteTextField<StadiumA>(
                                          key: key,
                                          clearOnSubmit: false,
                                          suggestions: StadiumA.fromJsonList(
                                              allStadiums),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0),
                                          decoration: InputDecoration(
                                            hintText: "Search Stadium",
                                            hintStyle: const TextStyle(
                                                color: Colors.black),
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          itemFilter: (item, query) {
                                            return item.stadiumName
                                                .toLowerCase()
                                                .startsWith(
                                                    query.toLowerCase());
                                          },
                                          itemSorter: (a, b) {
                                            return a.stadiumName
                                                .compareTo(b.stadiumName);
                                          },
                                          itemSubmitted: (item) async {
                                            setState(() {
                                              if (searchTextField.textField !=
                                                      null &&
                                                  searchTextField.textField!
                                                          .controller !=
                                                      null) {
                                                searchTextField
                                                    .textField!
                                                    .controller!
                                                    .text = item.stadiumName;
                                              }
                                            });

                                            // Find the stadium that matches the selected name
                                            var selectedStadium =
                                                allStadiums.firstWhere(
                                                    (stadium) =>
                                                        stadium[
                                                            'stadium_name'] ==
                                                        item.stadiumName,
                                                    orElse: () => null);

                                            // If a matching stadium is found, navigate to the StadiumInfo page
                                            if (selectedStadium != null) {
                                              await Future.delayed(
                                                  const Duration(
                                                      milliseconds: 100));
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          StadiumInfo(
                                                              selectedStadium[
                                                                  'stadium_id'])));
                                            }
                                          },
                                          itemBuilder: (context, item) {
                                            return row(item);
                                          },
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  const Text(
                                    'Recent Search',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  FutureBuilder(
                                      future: _intializeData(),
                                      builder: (context, snapshot) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int i = 0;
                                                i < allStadiums.length;
                                                i++)
                                              Padding(
                                                padding: EdgeInsets.symmetric(
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
                                                                const Color(
                                                                    0xffD9D9D9),
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
                                                                  Request(
                                                                      widget
                                                                          .user,
                                                                      allStadiums[i]
                                                                          [
                                                                          'stadium_id'])));
                                                    },
                                                    child: Row(
                                                      // ignore: duplicate_ignore, duplicate_ignore
                                                      children: [
                                                        // ignore: sized_box_for_whitespace
                                                        Container(
                                                          width: 90.0,
                                                          height: 90.0,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24),
                                                            child:
                                                                Image.network(
                                                              'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                                                  jsonDecode(
                                                                      allStadiums[
                                                                              i]
                                                                          [
                                                                          'stadium_picture']),
                                                              fit: BoxFit
                                                                  .cover, // You can use different BoxFit property as per your requirement
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 35,
                                                        ),
                                                        Text(
                                                          allStadiums[i]
                                                              ['stadium_name'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ],
                                        );
                                      })
                                ],
                              )),
                        )
                      ]),
                ));
          } else if (allStaff["staff"]) {
            return Scaffold(
              backgroundColor: const Color(0xffFF7D05),
              body: SingleChildScrollView(
                  child: FutureBuilder(
                      future: _intializeData(),
                      builder: (context, snapshot) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Stack(
                              children: <Widget>[
                                // The image
                                Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                            jsonDecode(
                                                allStaff['user_picture']),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // The edit button
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(
                                          0XFFFF5C00), // Change this to the color you want for the background of the circle.
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons
                                          .edit, // Change this to the icon you want.
                                      color: Colors
                                          .black, // Change this to the color you want for the icon.
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            Container(
                              height: 600,
                              width: 500,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFECECEC),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Fullname',
                                          style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                          height: 48,
                                          width: 500,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12)),
                                            border: Border.all(
                                              color: Colors
                                                  .black, // Specify the border color here.
                                              width:
                                                  2, // Specify the border width here.
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              allStaff['staff_name'],
                                              style: const TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Email',
                                          style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        height: 48,
                                        width: 500,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          border: Border.all(
                                            color: Colors
                                                .black, // Specify the border color here.
                                            width:
                                                2, // Specify the border width here.
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            allStaff['staff_email'],
                                            style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Phone Number',
                                          style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        height: 48,
                                        width: 500,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          border: Border.all(
                                            color: Colors
                                                .black, // Specify the border color here.
                                            width:
                                                2, // Specify the border width here.
                                          ),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              allStaff['staff_number'],
                                              style: const TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        );
                      })),
            );
          } else {
            return Scaffold(
              backgroundColor: const Color(0xffFF7D05),
              body: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    Text(
                      'Please wait until the assistant accept your booking!',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )),
            );
          }
        } else {
          // This will show while waiting for the future to complete
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

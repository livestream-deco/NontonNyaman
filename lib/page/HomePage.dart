// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_import, override_on_non_overriding_member, annotate_overrides, use_build_context_synchronously, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:my_app/models/user.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/page/profile/profile.dart';
import 'dart:async';

import 'package:my_app/page/stadium/StadiumInfo.dart';
// import the package

Future<Map<String, dynamic>> fetchNews() async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/newsletter/view-all-newsletter/';

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

Future<Map<String, dynamic>> fetchAccommodation() async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/accomodationsuggestion/view-accomodation/';

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

Future<Map<String, dynamic>> fetchStadiums() async {
  String url = 'http://10.0.2.2:8000/stadium/view-all-stadium/';

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

class HomeView extends StatefulWidget {
  final User user;
  const HomeView(this.user, {super.key});

  @override
  State<HomeView> createState() => HomePage();
}

class HomePage extends State<HomeView> {
  List<dynamic> allStadiums = [];
  List<dynamic> allpocket = [];
  List<dynamic> allAccom = [];
  Map<String, dynamic> response = {};
  late AutoCompleteTextField<StadiumA> searchTextField;
  GlobalKey<AutoCompleteTextFieldState<StadiumA>> key = GlobalKey();
  int selectedIndex = 0;

  @override
  Future<void> _intializeData2() async {
    response = await fetchStadiums();
    if (response["isSuccessful"]) {
      allStadiums = response["data"];
    }
  }

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
        fillColor: Colors.white,
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
        setState(() {
          if (searchTextField.textField != null &&
              searchTextField.textField!.controller != null) {
            searchTextField.textField!.controller!.text = item.stadiumName;
          }
        });
        if (item.stadiumName == 'Suncorp Stadium') {
          await Future.delayed(const Duration(milliseconds: 100));
          // ignore: use_build_context_synchronously
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Profile()));
        }
      },
      itemBuilder: (context, item) {
        return row(item);
      },
    );
  }

  Future<void> _intializeData() async {
    response = await fetchNews();
    if (response["isSuccessful"]) {
      allpocket = response["data"];
    }
  }

  Future<void> _intializeData1() async {
    response = await fetchAccommodation();
    if (response["isSuccessful"]) {
      allAccom = response["data"];
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
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Color(0xFF292929),
                    Color(0xFF595959),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "G'day Mate",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Where do you want to go?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: _intializeData2(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AutoCompleteTextField<StadiumA>(
                          key: key,
                          clearOnSubmit: false,
                          suggestions: StadiumA.fromJsonList(allStadiums),
                          style: const TextStyle(color: Colors.black, fontSize: 16.0),
                          decoration: InputDecoration(
                            hintText: "Search Stadium",
                            hintStyle: const TextStyle(color: Colors.black),
                            filled: true,
                            fillColor: Colors.white,
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
                            setState(() {
                              if (searchTextField.textField != null && searchTextField.textField!.controller != null) {
                                searchTextField.textField!.controller!.text = item.stadiumName;
                              }
                            });

                            // Find the stadium that matches the selected name
                            var selectedStadium = allStadiums.firstWhere((stadium) => stadium['stadium_name'] == item.stadiumName, orElse: () => null);

                            // If a matching stadium is found, navigate to the StadiumInfo page
                            if (selectedStadium != null) {
                              await Future.delayed(const Duration(milliseconds: 100));
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => StadiumInfo(selectedStadium['stadium_id'])));
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
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Live News Update ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            FutureBuilder(
                future: _intializeData(),
                builder: (context, snapshot) {
                  return CarouselSlider.builder(
                    itemCount: allpocket.length,
                    itemBuilder:
                        (BuildContext context, int itemIndex, int realIndex) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                            Container(
                              width: 500.0,
                              height: 185.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                          jsonDecode(allpocket[itemIndex]
                                              ['newsletter_picture'])),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: 
                            TextButton(
                              key: Key("title$itemIndex"),
                              child: Text(
                                allpocket[itemIndex]['newsletter_title'],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Profile()));
                              },
                            ),)
                          ])]);
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      aspectRatio: 1.0,
                      viewportFraction: 1.0,
                      height: 220,
                    ),
                  );
                }),
            const Text(
              'Accommodation Sugestion ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            FutureBuilder(
                future: _intializeData1(),
                builder: (context, snapshot) {
                  return CarouselSlider.builder(
                    itemCount: allAccom.length,
                    itemBuilder:
                        (BuildContext context, int itemIndex, int realIndex) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                            Container(
                              width: 500.0,
                              height: 185.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                          jsonDecode(allAccom[itemIndex]
                                              ['accomodation_picture'])),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child:
                            TextButton(
                              key: Key("title$itemIndex"),
                              child: Text(
                                allAccom[itemIndex]['accomodation_name'],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Profile()));
                              },
                            ),
                      )])
                      ]);
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      aspectRatio: 1.0,
                      viewportFraction: 1.0,
                      height: 220,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

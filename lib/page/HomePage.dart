
// ignore_for_file: file_names, duplicate_ignore, unused_import, override_on_non_overriding_member, annotate_overrides, use_build_context_synchronously, prefer_const_constructors, prefer_adjacent_string_concatenation, avoid_, unused_local_variable, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:my_app/models/user.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/page/accommodation/accommodation.dart';
import 'package:my_app/page/navbar.dart';
import 'package:my_app/page/newsletter/newsletter.dart';
import 'package:my_app/page/profile/profile.dart';
import 'dart:async';

import 'package:my_app/page/stadium/StadiumInfo.dart';


// fecth the data for the Newsletter
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

    // put the data into list 
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

// fetch the data for the accommodation suggestion
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
    // put the data into a list 
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

// fetch the data for the stadium
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

//fetch the user information
Future<Map<String, dynamic>> getUserInfo(User user) async {
  String url2 =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/user_info/?session_id=${user.sessionId}';

  try {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Map<String, dynamic> body = {'session_id': user.sessionId};

    final response2 = await http.post(
      Uri.parse(url2),
      headers: headers,
      body: jsonEncode(body),
    );

    Map<String, dynamic> extractedData2 = jsonDecode(response2.body);

    if (response2.statusCode == 200) {
      return {"isSuccessful": true, "data": extractedData2, "error": null};
    } else {
      return {
        "isSuccessful": false,
        "data": extractedData2,
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

// class for the item in text search field for stadium
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
  // all the list and map that being used in the HomePage
  List<dynamic> allStadiums = [];
  List<dynamic> allpocket = [];
  List<dynamic> allAccom = [];
  Map<String, dynamic> response = {};
  Map<String, dynamic> response1 = {};
  Map<String, dynamic> response2 = {};
  Map<String, dynamic> thedata = {};
  late AutoCompleteTextField<StadiumA> searchTextField;
  GlobalKey<AutoCompleteTextFieldState<StadiumA>> key = GlobalKey();
  int selectedIndex = 0;

  @override
  // set the future for fetching the stadiums into intializeData2 and put the data in allStadiums
  Future<void> _intializeData2() async {
    response = await fetchStadiums();
    if (response["isSuccessful"]) {
      allStadiums = response["data"];
    }
  }

  //initState for controlling the search text field
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
      },
      itemBuilder: (context, item) {
        return row(item);
      },
    );
  }

  // set the future for fetching the newsletter, user information, and accommodation into intializeData and put the data into different list.
  Future<void> _intializeData() async {
    ('test123');
    response = await fetchNews();
    if (response["isSuccessful"]) {
      allpocket = response["data"];
    }
    response1 = await fetchAccommodation();
    if (response1["isSuccessful"]) {
      allAccom = response1["data"];
    }
    response2 = await getUserInfo(widget.user);
    if (response2["isSuccessful"]) {
      thedata = response2["data"];
    }
  }

  //calling the class StadiumA for showing the stadium name in the search text field
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

// the page of the Home
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //setting the padding for maintain the clean of the design
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          //make sure all the things start from the left to the right
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
                  //calling the intializeData for taking the data from fetched
                  FutureBuilder(
                      future: _intializeData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // Data fetched successfully
                          final data = snapshot.data;
                          // Render the news carousel using the data
                          return Row(
                            children: [
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    //take the user picture
                                    image: NetworkImage(
                                      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                          jsonDecode(thedata['user_picture']),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              //take the user name from the user information
                              Text(
                                "G'Day " + '${thedata["name"]}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          );
                        }
                      }),
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
                  // call another intializeData in the future builder for the search text field
                  FutureBuilder(
                    future: _intializeData2(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AutoCompleteTextField<StadiumA>(
                          key: key,
                          clearOnSubmit: false,
                          suggestions: StadiumA.fromJsonList(allStadiums),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16.0),
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
                            return item.stadiumName
                                .toLowerCase()
                                .startsWith(query.toLowerCase());
                          },
                          itemSorter: (a, b) {
                            return a.stadiumName.compareTo(b.stadiumName);
                          },
                          itemSubmitted: (item) async {
                            setState(() {
                              if (searchTextField.textField != null &&
                                  searchTextField.textField!.controller !=
                                      null) {
                                searchTextField.textField!.controller!.text =
                                    item.stadiumName;
                              }
                            });

                            // find the stadium that matches the selected name
                            var selectedStadium = allStadiums.firstWhere(
                                (stadium) =>
                                    stadium['stadium_name'] == item.stadiumName,
                                orElse: () => null);

                            // if a matching stadium is found, navigate to the StadiumInfo page using stadium_id
                            if (selectedStadium != null) {
                              await Future.delayed(
                                  const Duration(milliseconds: 100));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StadiumInfo(
                                      selectedStadium['stadium_id'])));
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
            // called the future builder for intializeData the newsletter in allpocket
            FutureBuilder(
                future: _intializeData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Data fetched successfully
                    final data = snapshot.data;
                    // Render the news carousel using the data
                    return CarouselSlider.builder(
                      itemCount: allpocket.length,
                      itemBuilder:
                          (BuildContext context, int itemIndex, int realIndex) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children: [
                                Container(
                                  width: 500.0,
                                  height: 185.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    image: DecorationImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      image: NetworkImage(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          // show the image of the newsletter picture
                                          'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                              jsonDecode(allpocket[itemIndex]
                                                  ['newsletter_picture'])),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -10,
                                  left: 10,
                                  child: 
                                  Container(
                                    width: 350,
                                    height: 100,
                                  child: TextButton(
                                    key: Key("title$itemIndex"),
                                    child: Text(
                                      allpocket[itemIndex]['newsletter_title'],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                    //navigate the route for newletter details using the id
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Newsletters(
                                                  allpocket[itemIndex]
                                                      ['newsletter_id'])));
                                    },
                                  ),
                                )
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
                  }
                }),
            const Text(
              'Accommodation Suggestion ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            //call the future builder again for initialize the accommodation suggestion
            FutureBuilder(
                future: _intializeData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Data fetched successfully
                    final data = snapshot.data;
                    // Render the news carousel using the data
                    return CarouselSlider.builder(
                      itemCount: allAccom.length,
                      itemBuilder:
                          (BuildContext context, int itemIndex, int realIndex) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children: [
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
                                  //show the name of the accomodation
                                  child: TextButton(
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
                                              builder: (context) =>
                                                  Accommodation(allAccom[
                                                          itemIndex]
                                                      ['accomodation_id'])));
                                    },
                                  ),
                                )
                              ])
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
                  }
                }),
          ],
        ),
      ),
    );
  }
}

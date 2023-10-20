// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// fetch the newsletter based on the newsletter id
Future<Map<String, dynamic>> fetchNews(int id) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/newsletter/view-detail-newsletter/?input_id=$id';

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

class Newsletters extends StatefulWidget {
  final int id;
  const Newsletters(this.id, {super.key});

  @override
  NewsletterDetail createState() => NewsletterDetail();
}

class NewsletterDetail extends State<Newsletters> {
  //make the list for store the data
  List<dynamic> allNewsletter = [];
  Map<String, dynamic> response = {};

  Future<void> _intializeData() async {
    response = await fetchNews(widget.id);
    if (response["isSuccessful"]) {
      allNewsletter = response["data"];
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
            // call the future builder for called the initialize data
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
                            width: 500.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            // called the data from the list for show the picture of the news
                            child: Image.network(
                              'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                  jsonDecode(
                                      allNewsletter[0]['newsletter_picture']),
                              fit: BoxFit
                                  .cover, // You can use different BoxFit property as per your requirement
                            ),
                          )
                        ],
                      ),
                      SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                // use the list for show the title and the text of the newsletter
                                Text(
                                  allNewsletter[0]['newsletter_title'],
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  allNewsletter[0]['newsletter_text'],
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            )),
                      )
                    ]);
              },
            )));
  }
}

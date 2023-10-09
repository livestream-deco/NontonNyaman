// ignore_for_file: sized_box_for_whitespace, avoid_print, duplicate_ignore, file_names

import 'package:flutter/material.dart';
import 'package:my_app/page/stadium/Navigation.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:my_app/page/stadium/StadiumInfo.dart';


class StadiumA {
  final String stadiumName;

  StadiumA({required this.stadiumName});

  static List<StadiumA> getSuggestions() {
    // return a list of Stadium objects
    return [
      StadiumA(stadiumName: "Suncorp Stadium"),
      StadiumA(stadiumName: "The Gabba"),
      StadiumA(stadiumName: "QUT Kelvin Groove"),
    ];
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchStadium createState() => SearchStadium();
}

class SearchStadium extends State<SearchPage> {

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
      suggestions: StadiumA.getSuggestions(),
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
        return item.stadiumName
            .toLowerCase()
            .startsWith(query.toLowerCase());
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
              MaterialPageRoute(builder: (context) => const Navigation()));
        }
      },
      itemBuilder: (context, item) {
        return row(item);
      },
    );
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
        
        backgroundColor: const Color(0xFFECECEC),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children : [
                const SizedBox(height: 50,),
                const Text("Searching", style: TextStyle(fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w700),),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30,),
                        Container(
                          height: 60, // Set the height that you want
                          decoration: BoxDecoration(
                            color: const Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: searchTextField, // Your AutoCompleteTextField widget
                        ),
                        const SizedBox(height: 35,),
                        const Text(
                          'Recent Search',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 25,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [ 
                            Container(
                              width: 500,
                              height : 105,
                              child: 
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(48),
                                    elevation: 0,
                                    backgroundColor: const Color(0xffD9D9D9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    )),
                                  onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const StadiumInfo()));
                                      }, 
                                  child: Row(
                                    // ignore: duplicate_ignore, duplicate_ignore
                                    children: [
                                      // ignore: sized_box_for_whitespace
                                      Container(
                                        width: 90.0,
                                        height: 90.0,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(24),
                                          child: Image.asset(
                                            'assets/images/stadiumSuncorp.png',
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                      ),
                                      const SizedBox( width: 50,),
                                      const Text('Suncorp Stadium', style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: Colors.black),)
                                    ],
                                  )
                                ),
                              ),
                            const SizedBox(height: 20,),
                            Container(
                              width: 500,
                              height : 105,
                              child: 
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(48),
                                    elevation: 0,
                                    backgroundColor: const Color(0xffD9D9D9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    )),
                                  onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const StadiumInfo()));
                                      }, 
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90.0,
                                        height: 90.0,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(24),
                                          child: Image.asset(
                                            'assets/images/stadiumSuncorp.png',
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                      ),
                                      const SizedBox( width: 50,),
                                      const Text('The Gabba', style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: Colors.black),)
                                    ],
                                  )
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ),
                  )
                ]   
              ),
            )
        );
  }
}

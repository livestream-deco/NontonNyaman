import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import the package

class HomeView extends StatefulWidget {
  
  const HomeView( {super.key});

  @override
  State<HomeView> createState() => HomePage();
}

class HomePage extends State<HomeView> {
  late AutoCompleteTextField searchTextField; // Declare
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  List<String> suggestions = ["New York", "Los Angeles", "Chicago", "Houston", "Philadelphia"];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    searchTextField = AutoCompleteTextField(
      key: key,
      suggestions: suggestions,
      style: const TextStyle(color: Colors.black, fontSize: 16.0),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
        hintText: "Search Here",
        hintStyle: TextStyle(color: Colors.black),
      ),
      itemFilter: (item, query) {
        return item.toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.compareTo(b);
      },
      itemSubmitted: (item) {
        setState(() {
          searchTextField.textField?.controller?.text = item;
        });
      },
      itemBuilder: (context, item) {
        return row(item);
      },
    );
  }

  Widget row(String item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          item,
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
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
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
                  SizedBox(width: 10,),
                  const Text("G'day Mate", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),)
                ],
              ),
              SizedBox(height: 10,),
              const Text('Where do you want to go?', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
              searchTextField, // Add here
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          const Text(
           'Live News Update ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: const Divider(
              color: Color(0xFFDBDBDB),
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
          ),
        ],
      ),
    ),
  );
}
}

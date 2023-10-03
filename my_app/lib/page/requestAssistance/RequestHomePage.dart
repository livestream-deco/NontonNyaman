// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_import

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/page/authentication/LoginPage.dart';


class Request extends StatefulWidget {
  const Request({super.key});

  @override
  RequestHome createState() => RequestHome();
}

class RequestHome extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFECECEC),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50,),
                Text("Request Assistance", style: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w700),),
                SingleChildScrollView(
                  child : Padding(
                    padding: EdgeInsets.only(left :10, right: 10),
                    child :Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : [
                      SizedBox(height: 30,),
                      Text(
                        'Available Assistance',
                        style: TextStyle(
                            fontFamily: 'Inter', color: Color(0xff16AC25),
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5), 
                          child :Container(
                            padding: EdgeInsets.only(left : 15, right: 15),
                            width: 360,
                            height: 97,
                            decoration:  BoxDecoration(
                            color: Color(0xfff9f9f9),
                            borderRadius: BorderRadius.all(Radius.circular(12))
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration:  BoxDecoration(
                                  color: Color(0xffFF7D05),
                                  borderRadius: BorderRadius.all(Radius.circular(12))
                                  ),
                                ),
                                SizedBox(width: 15,),
                                Text('Michael James', style: TextStyle(fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w700),),
                                SizedBox(width: 100,),
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF9F9F9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward,  // This is the arrow
                                      color: Color(0xffFF7D05),
                                    ),
                                  ),
                                  ),
                              ]),
                          ),),
                          Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5), 
                          child :Container(
                            padding: EdgeInsets.only(left : 15, right: 15),
                            width: 360,
                            height: 97,
                            decoration:  BoxDecoration(
                            color: Color(0xfff9f9f9),
                            borderRadius: BorderRadius.all(Radius.circular(12))
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration:  BoxDecoration(
                                  color: Color(0xffFF7D05),
                                  borderRadius: BorderRadius.all(Radius.circular(12))
                                  ),
                                ),
                                SizedBox(width: 15,),
                                Text('Bryant tanujaya', style: TextStyle(fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w700),),
                                SizedBox(width: 100,),
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF9F9F9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward,  // This is the arrow
                                      color: Color(0xffFF7D05),
                                    ),
                                  ),
                                  ),
                              ]),
                          ),),
                  ]    
                    )
                  )
              ) ]
              ),
        ));
  }
}

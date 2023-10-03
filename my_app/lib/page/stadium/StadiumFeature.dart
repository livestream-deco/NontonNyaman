import 'package:flutter/material.dart';



class Stadium extends StatefulWidget {
  const Stadium({super.key});

  @override
  StadiumRequest createState() => StadiumRequest();
}

class StadiumRequest extends State<Stadium> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        backgroundColor: const Color(0xFFECECEC),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children : [
                SizedBox(height: 50,),
                Text("Stadium Features", style: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w700),),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Text(
                          'Quick Access',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(20),
                          width: 360,
                          height: 96,
                          decoration: BoxDecoration(
                          color: Color(0xff292929),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                          child: Row(
                            children: [
                              Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
                              child:
                                Image.asset(
                                  'assets/images/Vector.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              SizedBox(width: 25,),
                              Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
                              child:
                                Image.asset(
                                  'assets/images/Vector.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              SizedBox(width: 25,),
                              Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
                              child:
                                Image.asset(
                                  'assets/images/Vector.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              SizedBox(width: 25,),
                              Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
                              child:
                                Image.asset(
                                  'assets/images/Vector.png',
                                  width: 40,
                                  height: 40,
                                ),
                      ),
                    ]),
                ),
                SizedBox(height: 20,),
                Text('Stadium Map', style: TextStyle(fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w700),),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Container(
                    width: 330,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Color(0xffFF7D05)
                    ),
                    ),
                ),
                SizedBox(height: 20,),
                Text('Navigation', style: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w700),),
                ],
              )
            ),
          )]   
          ),
        ));
  }
}

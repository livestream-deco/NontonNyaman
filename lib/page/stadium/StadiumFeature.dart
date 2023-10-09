import 'package:flutter/material.dart';
import 'package:my_app/page/stadium/Navigation.dart';



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
                Text("Stadium Features", style: TextStyle(fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w700),),
                Text("Suncorp Stadium", style: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w700)),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,), 
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        elevation: 0,
                        backgroundColor: Color(0xFFECECEC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        )),
                      onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Navigation()));
                          }, 
                      child: Row(
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // set this to your body background color
                              border: Border.all(
                                color: Colors.orange, // set border color
                                width: 3.0, // set border width
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/Group.png',
                              width: 60,
                              height: 60,
                            ),
                          ),
                          SizedBox( width: 50,),
                          Text('Toilet', style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: Colors.black),)
                        ],
                      )
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        elevation: 0,
                        backgroundColor: Color(0xFFECECEC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        )),
                      onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Navigation()));
                          }, 
                      child: Row(
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // set this to your body background color
                              border: Border.all(
                                color: Colors.orange, // set border color
                                width: 3.0, // set border width
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/Group.png',
                              width: 60,
                              height: 60,
                            ),
                          ),
                          SizedBox( width: 50,),
                          Text('Toilet', style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: Colors.black),)
                        ],
                      )
                    ),
                  ],
                )
                ],
              )
            ),
          )]   
          ),
        ));
  }
}

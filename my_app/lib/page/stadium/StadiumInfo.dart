import 'package:flutter/material.dart';
import 'package:my_app/page/stadium/StadiumFeature.dart';
import '';



class StadiumInfo extends StatefulWidget {
    const StadiumInfo({Key? key}) : super(key: key);

  @override
  StadiumInformation createState() => StadiumInformation();
}

class StadiumInformation extends State<StadiumInfo> {
  StadiumInformation() {
    print("StadiumInformation constructor called");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFECECEC),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                SizedBox(height: 40,),
                Stack(
                  children: [
                    Container(
                      width: 410.0,
                      height: 410.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: AssetImage('assets/images/stadiumSuncorp.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 320.0, // Adjust this as needed
                      left: 20.0, // Adjust this as needed
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Suncorp Stadium',
                            style: TextStyle(
                              color: Colors.white, // Choose a color that contrasts with your image
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Milton, Queensland',
                            style: TextStyle(
                              color: Colors.white, // Choose a color that contrasts with your image
                              fontSize: 18.0, // Adjust the size as needed
                              fontWeight: FontWeight.w700, // Adjust the weight as needed
                            ),
                          ),
                          // Add more Text widgets as needed
                        ],
                      ),
                    ),
                    Positioned(
                      top: 30.0,  // Adjust as needed
                      left: 20.0, // Adjust as needed
                      child: Container(
                        padding: EdgeInsets.all(1), // Smaller padding for a smaller circle
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
                          iconSize: 20.0, // Smaller icon size
                          onPressed: () =>   Navigator.pop(context,true)
                        ),
                      ),
                    ),
                  ],
                ),
              
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Overview', style: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xffFFA800)),),
                        SizedBox(height: 10,),
                        Text(
                          'Lang Park, nicknamed "The Cauldron", also known as Brisbane Stadium and by the sponsored name Suncorp Stadium, is a multi-purpose stadium in Brisbane, Queensland, Australia, located in the suburb of Milton. The current facility comprises a three-tiered rectangular sporting stadium with a capacity of 52,500 people.',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 20,),
                        Text('Location', style: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xffFFA800)),),
                        SizedBox(height: 20,),
                        Container(
                          width: 400.0,
                          height: 180.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: AssetImage('assets/images/stadiummapSuncorp.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                SizedBox(height: 40,),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    key: Key("addAccount"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        elevation: 0,
                        backgroundColor: const Color(0XFFFF5C00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        )),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Stadium())),
                  
                    child: const Text(
                      'Navigate',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(height: 30,)
                ],
              )
            ),
          )]   
          ),
        ));
  }
}

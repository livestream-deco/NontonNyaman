// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:my_app/page/authentication/LoginPage.dart';

import 'package:flutter/material.dart';

class WelcomPage extends StatefulWidget {
  const WelcomPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/youssef-naddam-iJ2IG8ckCpA-unsplash 1.png'), // path to your image file
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100,),
            const Padding(padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
              child:  Image(image: AssetImage('assets/images/logo2.png')),
            ),
            
            const SizedBox(height: 170,),
           Container(
            height: 150,
            width: 330,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1), // 90% opacity
              borderRadius: BorderRadius.circular(12), // Border radius of 12.
            ),
            child: 
            Padding(
              padding: const EdgeInsets.fromLTRB(45,10,45,10),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center, // This will center the column children vertically.
                children: [
                  const Center(  // This will center the Text widget horizontally.
                    child: Text(
                      'Brings equal enjoyment to all sports fans.',
                      textAlign: TextAlign.center,  // This will center the text within the Text widget.
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    key: const Key("loginAccount"),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        elevation: 0,
                        backgroundColor: const Color(0XFFFF5C00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Login()),
                        );
                      },
                      child: const Text(
                        'Get Started!',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          )
        ],
        ) // rest of your widgets go here
      ),
    );
  }
}
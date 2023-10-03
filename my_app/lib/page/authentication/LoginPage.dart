// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_import

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/page/HomePage.dart';
import 'package:my_app/page/authentication/RegisterPage.dart';
import 'package:my_app/page/navbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   ),
        backgroundColor: const Color(0xFFECECEC),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 100,
                ),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 40,
                      fontWeight: FontWeight.w700),
                ),
                const Text(
                  'Login into your account',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      color: Color(0xFF848484),
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 32,
                ),
                SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            hintText: 'Insert email..'),
                      ),
                    ])),
                const SizedBox(
                  height: 32,
                ),
                SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Text(
                        'Password',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            hintText: 'Insert password..'),
                      ),
                    ])),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        elevation: 0,
                        backgroundColor: const Color(0XFFFF5C00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Navbar()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    // <-- TextButton
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Register()));
                    },
                    child: const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Color(0XFF787878),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                )
              ]),
        ));
  }
}

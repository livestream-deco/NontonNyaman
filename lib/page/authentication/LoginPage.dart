// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_import

import 'dart:convert';
import 'package:my_app/page/authentication/RegisterPage.dart';

import '../navbar.dart';

import '../../models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  Future<User> webServiceLogin(String telephone, String password) async {
    var response = await post(Uri.parse("http://10.0.2.2:8000/user/flu-login/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"email": telephone, "password": password}));

    if (response.statusCode == 200) {
      Map<String, dynamic> userData = jsonDecode(response.body);
      User user = User(
          datetime: userData["datetime"],
          sessionId: userData["session-id"],
          isCitizen: true,
          email: userData["email"],
          name: userData["name"]);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('sessionId', userData["session-id"]);
      prefs.setBool('isCitizen', userData["role_users"]);
      prefs.setString('email', userData["email"]);
      // prefs.setString('name', userData["name"]);

      return user;
    } else {
      return Future.error("Incorrect Login");
    }
  }

  @override
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        key: Key("addEmail"),
                        controller: _email,
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
                        key: Key("addPassword"),
                        controller: _password,
                        obscureText: true,
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
                  key: Key("loginAccount"),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        elevation: 0,
                        backgroundColor: const Color(0XFFFF5C00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        )),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      {
                        User user = await widget.webServiceLogin(
                            _email.text, _password.text);
                        {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        Navbar(user)),
                                (Route<dynamic> route) => false);
                          });
                        }
                      }
                      _email.clear();
                      _password.clear();
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
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

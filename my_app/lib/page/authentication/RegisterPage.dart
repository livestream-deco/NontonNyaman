// ignore: duplicate_ignore
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, unused_local_variable, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:my_app/page/HomePage.dart';
import 'package:my_app/page/authentication/LoginPage.dart';
import 'package:my_app/page/navbar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterPage createState() => RegisterPage();
}

class RegisterPage extends State<Register> {
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
                  'Welcome!',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 40,
                      fontWeight: FontWeight.w700),
                ),
                const Text(
                  'Register your account',
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
                        'Fullname',
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
                            hintText: 'Insert fullname..'),
                      ),
                    ])),
                const SizedBox(
                  height: 32,
                ),

          SingleChildScrollView(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Date of Birth',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide:
                          BorderSide(width: 1.0, color: Color(0xFFDBDBDB))),
                  hintText:
                      'YYYY-MM-dd'), //editing controller of this TextField
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

              },
            )
          ])),
            const SizedBox(height: 32,),
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

                const SizedBox( height: 32,),
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
                      'Register',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.center,
              child: TextButton(
                // <-- TextButton
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: const Text(
                  'Already have an account?',
                  style: TextStyle(
                      color: Color(0XFF787878),
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),),
              ]),
        ));
  }
}

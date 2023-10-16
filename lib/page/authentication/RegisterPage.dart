// ignore: duplicate_ignore
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, unused_local_variable, duplicate_ignore

import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/user.dart';
import 'package:my_app/page/authentication/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

Future<User> registerUser(
  String email,
  String password,
  String name,
  String datetime,
  String disability,
  File imageFile,
) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          "http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/flu-register-user/"),
    );

    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['name'] = name;
    request.fields['datetime'] = datetime;
    request.fields['disability'] = disability;

    String fieldName = 'image'; // Field name for the image on the server.
    request.files
        .add(await http.MultipartFile.fromPath(fieldName, imageFile.path));

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    if (response.statusCode == 200) {
      Map userData = jsonDecode(responseString);
      User user = User(
          datetime: userData["datetime"],
          sessionId: userData["session-id"],
          isCitizen: userData["role_users"],
          email: userData["email"],
          isStaff: false,
          name: userData["name"],
          disability: userData["disability"]);

      final prefs = await SharedPreferences.getInstance();

      prefs.setString('sessionId', userData["session-id"]);
      prefs.setString('email', userData["email"]);
      prefs.setString('name', userData["name"]);
      prefs.setString('disability', userData["disability"]);

      return user; // Return the user object on success
    } else {
      return Future.error("internal");
    }
  } catch (e) {
    return Future.error("offline");
  }
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterPage createState() => RegisterPage();
}

class RegisterPage extends State<Register> {
  TextEditingController dateinput = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  Future<File?> pickImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _datetime = TextEditingController();
  final TextEditingController _disability = TextEditingController();
  bool submitting = false;
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
          padding: const EdgeInsets.only(left: 30, right: 30),
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
                        key: const Key("addEmail"),
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
                        key: const Key("addName"),
                        controller: _name,
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Text(
                        'Disability',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        key: const Key("addDisability"),
                        controller: _disability,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            hintText: 'Insert disability..'),
                      ),
                    ])),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () async {
                    File? image = await pickImage();
                    setState(() {
                      _selectedImage = image;
                    });
                  },
                  child: const Text('Select Profile Picture'),
                ),
                if (_selectedImage != null)
                  Image.file(_selectedImage!)
                else
                  const Text('No image selected.'),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Text('Date of Birth',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      TextField(
                        key: const Key("addDate"),
                        controller: dateinput,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(
                                    width: 1.0, color: Color(0xFFDBDBDB))),
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
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              dateinput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      )
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
                        key: const Key("addPassword"),
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
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    key: const Key("addAccount"),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size.fromHeight(48)),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return const Color(
                                0XFFFF5C00); // use the same color even when the button is disabled
                          }
                          return const Color(0XFFFF5C00); // default color
                        },
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    onPressed: submitting || _selectedImage == null
                        ? null
                        : () async {
                            setState(() {
                              submitting = true;
                            });

                            try {
                              User user = await registerUser(
                                _email.text,
                                _password.text,
                                _name.text,
                                _datetime.text,
                                _disability.text,
                                _selectedImage!,
                              );

                              // After the user is registered, navigate to the login page and remove
                              // all previous routes from the stack.
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Login(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            } catch (e) {
                              // Show error message using a SnackBar
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'An error occurred: Email or Password does not exist'),
                                ),
                              );
                            } finally {
                              setState(() {
                                submitting = false;
                              });
                            }
                          },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    // <-- TextButton
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(
                          color: Color(0XFF787878),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ),
              ]),
        ));
  }
}

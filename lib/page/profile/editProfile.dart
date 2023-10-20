// ignore: file_names
// ignore: file_names
// ignore_for_file: avoid_, file_names, duplicate_ignore, unnecessary_cast, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/page/navbar.dart';
import 'package:image_picker/image_picker.dart';

// the fetch of sendNewUser only for the button to click save

Future<Map<String, dynamic>> sendNewUser(
  String name,
  String description,
  File? imageFile,
  User user,
) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          "http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/edit_user/"),
    );
    request.fields['session_id'] = user.sessionId;
    request.fields['name'] = name;
    request.fields['disability'] = description;

    // Only add the image file to the request if it's not null
    if (imageFile != null) {
      String fieldName = 'image'; // Field name for the image on the server.
      request.files
          .add(await http.MultipartFile.fromPath(fieldName, imageFile.path));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return {"isSuccessful": true, "error": null};
    } else {
      return Future.error("internal");
    }
  } catch (e) {
    return Future.error("offline");
  }
}

// this fetch is for showing the existing data from database
Future<Map<String, dynamic>> fetchUser(User user) async {
  String url =
      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com/user/user_info/?session_id=${user.sessionId}';

  try {
    final response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> userData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {"isSuccessful": true, "data": userData, "error": null};
    } else {
      return {
        "isSuccessful": false,
        "data": userData,
        "error": "An error has occurred"
      };
    }
  } catch (error) {
    return {
      "isSuccessful": false,
      "data": {},
      "error": "Our web service is down."
    };
  }
}

class EditProfile extends StatefulWidget {
  final User user;
  const EditProfile(this.user, {super.key});

  @override
  EditProfilePage createState() => EditProfilePage();
}

class EditProfilePage extends State<EditProfile> {
  // using map for this page
  Map<String, dynamic> response = {};
  Map<String, dynamic> user = {};
  Map<String, dynamic>? fetchedResult;

  // controller for editing the text
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userDescription = TextEditingController();
  Future<void> _intializeData() async {
    response = await fetchUser(widget.user);
    if (response["isSuccessful"]) {
      user = response["data"];
      userName.text = user['name'];
      userDescription.text = user['disability'];
      (user);
    }
  }

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFECECEC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Edit Your Profile',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black, 
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.black,
              size: 25.0,
            ),
            onPressed: () async {
              fetchedResult = await sendNewUser(userName.text,
                  userDescription.text, _selectedImage, widget.user);
              // ignore: use_build_context_synchronously
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Navbar(widget.user)));
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFECECEC),
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: _intializeData(),
              builder: (context, snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Stack(
                      children: <Widget>[
                        // The image
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: _selectedImage == null
                                  // ignore: unnecessary_cast
                                  ? NetworkImage(
                                      'http://nonton-nyaman-cbfc2703b99d.herokuapp.com' +
                                          jsonDecode(user[
                                              'user_picture'])) as ImageProvider<
                                      Object>
                                  : FileImage(_selectedImage!)
                                      as ImageProvider<Object>,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // The edit button
                        Positioned(
                          right: -10,
                          bottom: 0,
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: _pickImage,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      height: 500,
                      width: 500,
                      decoration: const BoxDecoration(
                          color: Color(0XFFFF5C00),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Fullname',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: userName,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your name',
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 48,
                                width: 500,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  border: Border.all(
                                    color: Colors
                                        .white, 
                                    width: 2, 
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    user['email'],
                                    style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: userDescription,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your Description',
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}

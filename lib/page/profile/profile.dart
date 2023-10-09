import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfilePage createState() => ProfilePage();
}

class ProfilePage extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text('Profile Name', style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700),),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                width: 500,
                height: 260,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lorem ipsum dolor sit amet', style: TextStyle(fontFamily: 'Inter', fontSize: 12),),
                    Text('Lorem ipsum dolor sit amet', style: TextStyle(fontFamily: 'Inter', fontSize: 12),),
                    Text('Lorem ipsum dolor sit amet', style: TextStyle(fontFamily: 'Inter', fontSize: 12),),
                    Text('Lorem ipsum dolor sit amet', style: TextStyle(fontFamily: 'Inter', fontSize: 12),),
                    Text('Lorem ipsum dolor sit amet', style: TextStyle(fontFamily: 'Inter', fontSize: 12),),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  const Text('Profile Name', style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700),),
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                width: 500,
                height: 260,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: const Column(
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

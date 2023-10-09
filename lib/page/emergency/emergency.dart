import 'package:flutter/material.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  EmergencyPage createState() => EmergencyPage();
}

class EmergencyPage extends State<Emergency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFF7D05),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFF7D05),
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100,),
              Row(
                children:[
              const SizedBox(width: 135,),
              Image.asset(
                'assets/images/alert.png',
                width: 150,
                height: 150,
              ),]),
              const SizedBox(height: 20,),
              const Text('We’re ringing your phone right now!', style: TextStyle(fontSize: 24, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: Colors.white), textAlign: TextAlign.center,),
              const SizedBox(height: 80,)
              
            ],
          ),
      ),
    );
  }
}

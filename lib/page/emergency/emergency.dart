import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class Emergency extends StatefulWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  EmergencyPage createState() => EmergencyPage();
}

class EmergencyPage extends State<Emergency> {
  final String _phoneNumber = 'tel:+1911';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFF7D05),
      body: SingleChildScrollView(
        child: 
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
            Link(
              uri: Uri.parse(_phoneNumber),
              builder: (context, followLink) {
                return GestureDetector(
                  onTap: followLink,
                  child: Image.asset(
                    'assets/images/alert.png',
                    width: 150,
                    height: 150,
                  ),
                );
              },
            ),
            const SizedBox(height: 20,),
            const Text('Please tap the alert button to call the assistance!', style: TextStyle(fontSize: 24, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: Colors.white), textAlign: TextAlign.center,),
            const SizedBox(height: 80,)
          ],
        ),
      )),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selfbetter/screens/home_screen.dart';
import 'package:selfbetter/screens/landing_screen.dart';

class LoggingPage extends StatelessWidget {
  const LoggingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData){
            return HomePage();
          } else if (snapshot.hasError){
            return Center(child: Text('Something went Wrong!'));
          } else {
            return LandingPage();
          }
        },
      ),
    );
  }
}

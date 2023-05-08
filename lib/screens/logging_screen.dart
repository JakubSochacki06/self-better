import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selfbetter/screens/navigation_bar.dart';
import 'package:selfbetter/screens/landing_screen.dart';

class LoggingPage extends StatefulWidget {


  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData){
            return PageNavigator();
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
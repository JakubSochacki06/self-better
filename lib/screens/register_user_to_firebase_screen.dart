import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:selfbetter/screens/home_screen.dart';
import 'package:selfbetter/screens/logging_screen.dart';

class RegisterUserToFirebasePage extends StatefulWidget {
  @override
  State<RegisterUserToFirebasePage> createState() =>
      _RegisterUserToFirebasePageState();
}

class _RegisterUserToFirebasePageState
    extends State<RegisterUserToFirebasePage> {
  final _firestore = FirebaseFirestore.instance;
  bool shouldAddUser = true;

  @override
  void initState() {
    final currentUser = FirebaseAuth.instance.currentUser!;
    shouldAddUserToFirebase(currentUser);
    if(shouldAddUser){
      addUserToFirebase(currentUser);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoggingPage();
    }));
    super.initState();
  }

  void addUserToFirebase(currentUser) async{
      _firestore.collection('users_data').add({
        'user_id': currentUser.uid,
      });
      print('DODADANO DO FIREBASE');
  }

  void shouldAddUserToFirebase(currentUser) async{
    await for (var snapshot in _firestore.collection('users_data').snapshots()) {
      for (var user in snapshot.docs) {
        if (user.data()['user_id'] == currentUser.uid) {
          shouldAddUser = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPouringHourGlass(
          color: Colors.black,
          size: 100.0,
        ),
      ),
    );
  }
}

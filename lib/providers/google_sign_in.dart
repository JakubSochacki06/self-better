import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final db = FirebaseFirestore.instance;
    DateTime now = new DateTime.now();
    // String? memberSince = await FirestoreHelper.getUserDataFromDataField('member_since', _user!.email);
    // print(memberSince);
    await db.collection('users_data').doc(_user!.email).set({'user_email':_user!.email, 'member_since':'${now.day}, ${now.month}, ${now.year}', 'notes':[]}, SetOptions(merge : true));
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }
}

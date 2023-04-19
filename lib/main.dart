import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selfbetter/providers/google_sign_in.dart';
import 'package:selfbetter/screens/add_note_screen.dart';
import 'package:selfbetter/screens/home_screen.dart';
import 'package:selfbetter/screens/logging_screen.dart';
import 'screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/firestore_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isLogged = FirebaseAuth.instance.currentUser == null? false : true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        Provider(create: (_) => FirestoreHelper()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/landing': (context) => LandingPage(),
          '/logging': (context) => LoggingPage(),
          '/addNote': (context) => AddNotePage(),
          '/home':(context) => HomePage(),
        },
        initialRoute: isLogged? '/home' :'/landing',
      ),
    );
  }
}


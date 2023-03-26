import 'package:flutter/material.dart';
import 'package:selfbetter/providers/google_sign_in.dart';
import 'screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/landing': (context) => LandingScreen(),
        },
        initialRoute: '/landing',
      ),
    );
  }
}


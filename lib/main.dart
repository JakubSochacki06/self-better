import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selfbetter/providers/google_sign_in_provider.dart';
import 'package:selfbetter/screens/add_note_screen.dart';
import 'package:selfbetter/screens/navigation_bar.dart';
import 'package:selfbetter/screens/logging_screen.dart';
import 'screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'helpers/firestore_helper.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isLogged = FirebaseAuth.instance.currentUser == null ? false : true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(

            primary: Color(0xFF27B5BE),
          ),
        ),
        routes: {
          '/landing': (context) => LandingPage(),
          '/logging': (context) => LoggingPage(),
          '/addNote': (context) => AddNotePage(),
          '/home': (context) => PageNavigator(),
        },
        initialRoute: isLogged ? '/home' : '/landing',
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:selfbetter/screens/landing_screen.dart';

class UserProfilePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  final _FirebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tekst zależny od tego, czy użytkownik zarejestrował się przez E-mail i hasło, czy konto Google.
            user.displayName == null
                ? Text('Hey ${user.email}\n keep grinding!',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 32))
                : Text('Hey ${user.displayName}\n keep grinding!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32)),
            SizedBox(
              height: 20,
            ),
            // Tekst zależny od tego, czy użytkownik zarejestrował się przez E-mail i hasło, czy konto Google.
            user.photoURL == null
                ? Icon(
                    FontAwesomeIcons.user,
                    size: 50,
                  )
                : CircleAvatar(
                    radius: 45,
                    child: Image.network(
                      user.photoURL!,
                      fit: BoxFit.cover,
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            Text('Your badges:', style: TextStyle(fontSize: 30),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(child: Image.asset('assets/images/badges/muscle-badge.png', fit: BoxFit.cover,), height: 40, width: 40,)
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _FirebaseAuth.signOut();
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: LandingPage(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Text('Wyloguj się'),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                minimumSize: Size(200, 50),
                primary: Color(0xFF71C9CE),
                onSurface: Colors.black12,
                elevation: 0,
              ),
            )
            // Text(
            // user.displayName!
            // ),
          ],
        ),
      ),
    );
  }
}

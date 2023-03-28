import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'slider_screen.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    List<Widget> _widgetOptions = <Widget>[
      Text(
        'Home',
      ),
      Text(
        'Likes',
      ),
      SliderPage(),
      Text(
        'Profile',
      ),
    ];

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            gap: 12,
            color: Colors.white,
            backgroundColor: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(16),
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              GButton(icon: FontAwesomeIcons.house, text: 'Home'),
              GButton(icon: FontAwesomeIcons.heart),
              GButton(icon: FontAwesomeIcons.smile),
              GButton(icon: FontAwesomeIcons.user, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

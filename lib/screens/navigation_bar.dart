import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'rate_your_day_screen.dart';
import 'user_profile_screen.dart';
import 'notes_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'home_screen.dart';


class PageNavigator extends StatefulWidget {

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    List<Widget> _widgetOptions = <Widget>[
      HomePage(),
      NotesPage(),
      RateYourDayPage(),
      Text('Stats'),
      UserProfilePage(),
    ];

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.home),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey.shade500,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.noteSticky),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey.shade500,
        ),
        PersistentBottomNavBarItem(
          icon: Center(child: Icon(FontAwesomeIcons.add, color: Colors.white)),
          activeColorPrimary: Color(0xFF27B5BE),
          inactiveColorPrimary: Colors.grey.shade300,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.chartSimple),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey.shade500,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.user),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.grey.shade500,
        ),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);


    return PersistentTabView(
      context,
      controller: _controller,
      screens: _widgetOptions,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}



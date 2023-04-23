import 'package:flutter/material.dart';

class AddNotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Center(
            child: Column(
              children: [
                Text('How do you feel today?'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

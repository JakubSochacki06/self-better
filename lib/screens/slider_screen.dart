import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:gradient_colored_slider/gradient_colored_slider.dart';


final db = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser!;
class SliderPage extends StatefulWidget {
  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  @override
  Widget build(BuildContext context) {
    int value = _rangedSelectedValue(_TOP_SLIDER_MAX_STEP, _topSliderValue);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            child: GradientColoredSlider(
              value: _topSliderValue,
              barWidth: 2.5,
              barSpace: 0,
              onChanged: (double value) {
                setState(() {
                  _topSliderValue = value;
                });
              },
            ),
          ),
          const SizedBox(height: 32),
          Text('$value',
              style: TextStyle(fontSize: 32)),
          ElevatedButton(
            onPressed: () async{
              DateTime now = new DateTime.now();
              await for (var snapshot in db.collection('users_data').snapshots()) {
                for (var message in snapshot.docs) {
                  if (message.data()['user_email'] == user.email) {
                    if(message.data()['day_ratings'] == null){
                      // List<Array<dynamic>>
                      await db.collection('users_data').doc(user.email).set({'day_ratings':[{'${now.day}, ${now.month}, ${now.year}':value}]}, SetOptions(merge: true));
                    } else {
                      List<dynamic> ratings = message.data()['day_ratings'];
                      ratings.add({'${now.day}, ${now.month}, ${now.year}':value});
                      print('test');
                      await db.collection('users_data').doc(user.email).set({'day_ratings':ratings}, SetOptions(merge: true));
                    }
                  }
                }
              }
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
        ],
      ),
    );
  }
}

const _TOP_SLIDER_MAX_STEP = 5;

double _topSliderValue = 0.3;

// final List<Color> _colors = [
//   Color.fromARGB(255, 255, 0, 0),
//   Color.fromARGB(255, 255, 128, 0),
//   Color.fromARGB(255, 255, 255, 0),
//   Color.fromARGB(255, 128, 255, 0),
//   Color.fromARGB(255, 0, 255, 0),
//   Color.fromARGB(255, 0, 255, 128),
//   Color.fromARGB(255, 0, 255, 255),
//   Color.fromARGB(255, 0, 128, 255),
//   Color.fromARGB(255, 0, 0, 255),
//   Color.fromARGB(255, 127, 0, 255),
//   Color.fromARGB(255, 255, 0, 255),
//   Color.fromARGB(255, 255, 0, 127),
// ];

int _rangedSelectedValue(int maxSteps, double value) {
  double stepRange = 1.0 / maxSteps;
  return (value / stepRange + 1).clamp(1, maxSteps).toInt();
}

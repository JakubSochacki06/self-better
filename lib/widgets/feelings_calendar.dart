import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

User user = FirebaseAuth.instance.currentUser!;

class FeelingsCalendar extends StatelessWidget {
  Map<dynamic, dynamic> submittedDays = {};

  void setSubmittedDays(dynamic snapshotData) {
    print(snapshotData);
    for (Map<String, dynamic> dayRating in snapshotData['day_ratings']) {
      int day = int.parse(dayRating.keys.toList()[0].split(',')[0]);
      int month = int.parse(dayRating.keys.toList()[0].split(',')[1]);
      int year = int.parse(dayRating.keys.toList()[0].split(',')[2]);
      int feeling = dayRating.values.toList()[0][0];
      submittedDays[DateTime(year, month, day)] = feeling;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
      FirebaseFirestore.instance
          .collection('users_data')
          .doc(user.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          setSubmittedDays(snapshot.data);
          return CalendarCarousel<Event>(
            todayButtonColor: Colors.black12,
            todayBorderColor: Colors.black12,
            weekendTextStyle: TextStyle(
              color: Colors.red,
            ),
            thisMonthDayBorderColor: Colors.grey,
            showIconBehindDayText: true,
//      weekDays: null, /// for pass null when you do not want to render weekDays
     headerText: 'Feelings Calendar',
            customDayBuilder: (
              bool isSelectable,
              int index,
              bool isSelectedDay,
              bool isToday,
              bool isPrevMonthDay,
              TextStyle textStyle,
              bool isNextMonthDay,
              bool isThisMonthDay,
              DateTime date,
            ) {
              if (submittedDays.containsKey(date)) {
                List<String> feelingNameAsIndex = [
                  'angry',
                  'sad',
                  'mixed',
                  'neutral',
                  'happy'
                ];
                int feeling = submittedDays[date];
                String feelingName = feelingNameAsIndex[feeling - 1];
                return Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                        'assets/images/emojis/${feelingName}-emoji.png'),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              } else {
                return null;
              }
            },
            weekFormat: false,
            height: 420.0,
            daysHaveCircularBorder: null,

            /// null for not rendering any border, true for circular border, false for rectangular border
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

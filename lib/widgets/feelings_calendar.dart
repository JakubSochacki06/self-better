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
    int index = 0;
    for(String date in snapshotData['day_ratings'].keys){
      DateTime dateTime = DateTime.parse(date);
      dynamic feeling = snapshotData['day_ratings'].values.elementAt(index)['feeling'];
      submittedDays[dateTime] = feeling;
      index += 1;
    }
  }

  // static Widget _eventIcon = new Container(
  //   decoration: new BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(Radius.circular(1000)),
  //       border: Border.all(color: Colors.blue, width: 2.0)),
  //   child: new Icon(
  //     Icons.person,
  //     color: Colors.amber,
  //   ),
  // );
  //
  // EventList<Event> _markedDateMap = new EventList<Event>(
  //   events: {
  //     new DateTime(2023, 5, 13): [
  //       new Event(
  //         date: new DateTime(2023, 5, 12),
  //         title: 'Event 1',
  //         icon: _eventIcon,
  //         dot: Container(
  //           margin: EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.red,
  //           height: 5.0,
  //           width: 5.0,
  //         ),
  //       ),
  //       new Event(
  //         date: new DateTime(2023, 5, 13),
  //         title: 'Event 2',
  //         icon: _eventIcon,
  //       ),
  //     ],
  //   },
  // );

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
            // markedDatesMap: _markedDateMap,
            disableDayPressed: true,
            todayButtonColor: Colors.black12,
            todayBorderColor: Colors.black12,
            weekendTextStyle: TextStyle(
              color: Colors.red,
            ),
            thisMonthDayBorderColor: Colors.grey,
            showIconBehindDayText: true,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: 'Feelings Calendar',
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
                return Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                        'assets/images/emojis/${submittedDays[date]}-emoji.png'),
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
            height: 390.0,
            daysHaveCircularBorder: null,

            /// null for not rendering any border, true for circular border, false for rectangular border
          );
        } else {
          return Container(
            height: 390,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

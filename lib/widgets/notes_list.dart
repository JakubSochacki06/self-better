import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selfbetter/text_styles.dart';
import 'note_tile.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final user = FirebaseAuth.instance.currentUser!;

class NotesList extends StatefulWidget {
  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  List<Widget> userNotes = [];

  void setUpMonthlyNotes(dynamic snapshotData) {
    userNotes = [];
    Map<String, List<Widget>> monthlyNotes = {};
    snapshotData['notes'].forEach((key,value){
      String day = key.split(',')[0];
      String month = key.split(',')[1].replaceAll(' ', '');
      String year = key.split(',')[2].replaceAll(' ', '');
      String noteTitle = value[0];
      String noteDescription = value[1];
      String noteFeeling = value[2];
      bool hasPhoto = value[3];
      int noteID = value[4];
      List months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      String monthName = months[int.parse(month) - 1];
      // If month doesn't contain key
      if (!monthlyNotes.containsKey('${month} ${year}')) {
        monthlyNotes['${month} ${year}'] = [
          RichText(
            text: TextSpan(text: monthName, style: kNotesMainMonth, children: [
              WidgetSpan(
                  child: SizedBox(
                    width: 5,
                  )),
              TextSpan(text: year, style: kNotesMainYear)
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          NoteTile(
            noteTitle: noteTitle,
            noteDescription: noteDescription,
            feeling: noteFeeling,
            day: day,
            monthName: monthName,
            hasPhoto: hasPhoto,
            noteID: noteID,
            month: month,
            year: year,
          )
        ];
      } else {
        monthlyNotes['${month} ${year}']!.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: NoteTile(
            noteTitle: noteTitle,
            noteDescription: noteDescription,
            feeling: noteFeeling,
            day: day,
            monthName: monthName,
            hasPhoto: hasPhoto,
            noteID: noteID,
            month: month,
            year: year,
          ),
        ));
      }
    });
    for (List<Widget> note in monthlyNotes.values) {
      userNotes.add(Column(
        children: note,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users_data')
            .doc(user.email)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            setUpMonthlyNotes(snapshot.data);
            return Column(
              children: userNotes,
            );
          } else {
            return Center(
              child: Text(
                'No notes left yet.\nClick "+" in top right corner to add one.'
              )
            );
          }
        });
  }
}

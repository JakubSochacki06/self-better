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

  void setUpMonthlyNotes(dynamic snapshotData){
    userNotes = [];
    Map<String, List<Widget>> monthlyNotes = {};
    for (Map<String, dynamic> note in snapshotData['notes']) {
      // TODO: Chanage firebase storing, maybe list not map
      String month = note.keys.toList()[0].split(',')[1];
      String year = note.keys.toList()[0].split(',')[2];
      String noteTitle = note.values.toList()[0][0];
      String noteDescription = note.values.toList()[0][1];
      int noteFeeling = note.values.toList()[0][2];
      print(month);
      print(year);
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
          Text(
            monthName,
            style: kNotesMonth,
          ),
          NoteTile(
              noteTitle: noteTitle,
              noteDescription: noteDescription,
              feeling: noteFeeling)
        ];
      } else {
        monthlyNotes['${month} ${year}']!.add(NoteTile(
            noteTitle: noteTitle,
            noteDescription: noteDescription,
            feeling: noteFeeling));
      }
    }
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
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
        });
  }
}

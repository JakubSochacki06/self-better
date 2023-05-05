import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteTile extends StatelessWidget {
  final String noteTitle;
  final String noteDescription;
  final int feeling;
  final String day;
  final String monthName;
  final bool hasPhoto;
  final int noteID;

  NoteTile({
    required this.noteTitle,
    required this.noteDescription,
    required this.feeling,
    required this.day,
    required this.monthName,
    required this.hasPhoto,
    required this.noteID,
  });

  final user = FirebaseAuth.instance.currentUser!;
  Map feelingToString = {
    '1': 'angry',
    '2': 'sad',
    '3': 'mixed',
    '4': 'neutral',
    '5': 'happy',
  };

  Future<bool> wantToDeleteNoteAlert(BuildContext context) async {
    bool deleteNote = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete note?'),
          content: Text('Are you sure you want to delete note?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
    return deleteNote;
  }

  @override
  Widget build(BuildContext context) {
    String feelingString = feelingToString[feeling.toString()];
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF0F2F5), borderRadius: BorderRadius.circular(20)),
      height: 200,
      width: width - 50,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: Image.asset(
                      'assets/images/emojis/${feelingString}-emoji.png'),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${feelingString[0].toUpperCase()}${feelingString.substring(1).toLowerCase()}',
                          style: kNotesFeelingName,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${day} ${monthName}',
                          style: kNotesDate,
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Photo: '),
                Icon(hasPhoto == true
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.x),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.pen,
                    color: Colors.black38,
                  ),
                ),
                IconButton(
                  onPressed: () async{
                    bool wantToDelete = await wantToDeleteNoteAlert(context);
                    if(wantToDelete){
                      List<dynamic> notes = await FirestoreHelper.getUserDataFromDataField('notes', user.email!);
                      int indexOfNoteToRemove = notes.indexWhere((element) => element.values.toList()[0][4] == noteID);
                      notes.removeAt(indexOfNoteToRemove);
                      FirestoreHelper.addDataToFirestore('users_data', user.email!, 'notes', notes);
                    }
                  },
                  icon: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                noteTitle,
                style: kNoteTitle,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                noteDescription,
                style: kNoteDescription,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

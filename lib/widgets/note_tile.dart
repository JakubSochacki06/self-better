import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbetter/screens/note_details_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'edit_note_popup.dart';

class NoteTile extends StatelessWidget {
  final String noteTitle;
  final String noteDescription;
  final String feeling;
  final String day;
  final String month;
  final String year;
  final String monthName;
  final bool hasPhoto;
  final int noteID;

  NoteTile({
    required this.noteTitle,
    required this.noteDescription,
    required this.feeling,
    required this.day,
    required this.month,
    required this.year,
    required this.monthName,
    required this.hasPhoto,
    required this.noteID,
  });

  final user = FirebaseAuth.instance.currentUser!;

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
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: NoteDetailsPage(title: noteTitle, description: noteDescription, feelingImagePath: 'assets/images/emojis/${feeling}-emoji.png', userEmail: user.email!, day: day, month: monthName, hasPhoto: hasPhoto,),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Container(
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
                        'assets/images/emojis/${feeling}-emoji.png'),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${feeling[0].toUpperCase()}${feeling.substring(1).toLowerCase()}',
                          style: kNotesFeelingName,
                        ),
                      ),
                      SizedBox(
                        height: 5,
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
                  SizedBox(width: 10,),
                  Text('Photo: '),
                  Icon(hasPhoto == true
                      ? FontAwesomeIcons.check
                      : FontAwesomeIcons.x),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: EditNotePopup(
                          title: noteTitle,
                          description: noteDescription,
                          feeling: feeling,
                          hasPhoto: hasPhoto,
                          userEmail: user.email!,
                          day: day,
                          month: month,
                          year: year,
                          noteID: noteID,
                        ),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    },
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
      ),
    );
  }
}

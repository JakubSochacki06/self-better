import 'package:flutter/material.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';

class EditNotePopup extends StatefulWidget {
  final String title;
  final String description;
  final String feeling;
  final String userEmail;
  final String day;
  final String month;
  final String year;
  final int noteID;
  final bool hasPhoto;
  EditNotePopup({required this.title, required this.feeling, required this.description, required this.userEmail, required this.day, required this.month, required this.year, required this.noteID, this.hasPhoto = false});
  @override
  State<EditNotePopup> createState() => _EditNotePopupState();
}

class _EditNotePopupState extends State<EditNotePopup> {

  MaterialStateProperty<Color> emoji1 =
  MaterialStateProperty.all(Color(0xFFf5f5f5));

  MaterialStateProperty<Color> emoji2 =
  MaterialStateProperty.all(Color(0xFFf5f5f5));

  MaterialStateProperty<Color> emoji3 =
  MaterialStateProperty.all(Color(0xFFf5f5f5));

  MaterialStateProperty<Color> emoji4 =
  MaterialStateProperty.all(Color(0xFFf5f5f5));

  MaterialStateProperty<Color> emoji5 =
  MaterialStateProperty.all(Color(0xFFf5f5f5));

  late int activeGeneralEmoji;

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    _titleController.text = widget.title;
    final _descriptionController = TextEditingController();
    _descriptionController.text = widget.description;

    switch (widget.feeling){
      case 'angry':
        activeGeneralEmoji = 1;
        emoji1 = MaterialStateProperty.all(Colors.red.shade300);
        break;
      case 'sad':
        activeGeneralEmoji = 2;
        emoji2 = MaterialStateProperty.all(Colors.orange.shade300);
        break;
      case 'mixed':
        activeGeneralEmoji = 3;
        emoji3 = MaterialStateProperty.all(Colors.purple.shade300);
        break;
      case 'neutral':
        activeGeneralEmoji = 4;
        emoji4 = MaterialStateProperty.all(Colors.yellow.shade300);
        break;
      case 'happy':
        activeGeneralEmoji = 5;
        emoji5 = MaterialStateProperty.all(Colors.green.shade300);
        break;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Edit Note',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeGeneralEmoji = 1;
                          emoji1 = MaterialStateProperty.all(
                              Colors.red.shade300);
                          emoji2 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji3 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji4 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji5 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                            'assets/images/emojis/angry-emoji.png'),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: emoji1,
                        shape: MaterialStateProperty.all(CircleBorder()),
                        padding:
                        MaterialStateProperty.all(EdgeInsets.all(10)),
                        elevation: MaterialStateProperty.all(0),
                        overlayColor:
                        MaterialStateProperty.resolveWith<Color?>(
                                (states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.red.shade300;
                            }),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Angry',
                      style: kRateYourDayEmojiName,
                    )
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeGeneralEmoji = 2;
                          emoji1 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji2 = MaterialStateProperty.all(
                              Colors.orange.shade300);
                          emoji3 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji4 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji5 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                            'assets/images/emojis/sad-emoji.png'),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: emoji2,
                        padding:
                        MaterialStateProperty.all(EdgeInsets.all(10)),
                        shape: MaterialStateProperty.all(CircleBorder()),
                        elevation: MaterialStateProperty.all(0),
                        overlayColor:
                        MaterialStateProperty.resolveWith<Color?>(
                                (states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.orange.shade300;
                            }),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Sad',
                      style: kRateYourDayEmojiName,
                    )
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeGeneralEmoji = 3;
                          emoji1 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji2 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji3 = MaterialStateProperty.all(
                              Colors.purple.shade300);
                          emoji4 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji5 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                            'assets/images/emojis/mixed-emoji.png'),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: emoji3,
                        padding:
                        MaterialStateProperty.all(EdgeInsets.all(10)),
                        shape: MaterialStateProperty.all(CircleBorder()),
                        elevation: MaterialStateProperty.all(0),
                        overlayColor:
                        MaterialStateProperty.resolveWith<Color?>(
                                (states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.purple.shade300;
                            }),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Mixed',
                      style: kRateYourDayEmojiName,
                    )
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeGeneralEmoji = 4;
                          emoji1 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji2 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji3 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji4 = MaterialStateProperty.all(
                              Colors.yellow.shade300);
                          emoji5 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                            'assets/images/emojis/neutral-emoji.png'),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: emoji4,
                        padding:
                        MaterialStateProperty.all(EdgeInsets.all(10)),
                        shape: MaterialStateProperty.all(CircleBorder()),
                        elevation: MaterialStateProperty.all(0),
                        overlayColor:
                        MaterialStateProperty.resolveWith<Color?>(
                                (states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.yellow.shade300;
                            }),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Neutral',
                      style: kRateYourDayEmojiName,
                    )
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeGeneralEmoji = 5;
                          emoji1 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji2 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji3 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji4 =
                              MaterialStateProperty.all(Color(0xFFf5f5f5));
                          emoji5 = MaterialStateProperty.all(
                              Colors.green.shade300);
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                            'assets/images/emojis/happy-emoji.png'),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: emoji5,
                        padding:
                        MaterialStateProperty.all(EdgeInsets.all(10)),
                        shape: MaterialStateProperty.all(CircleBorder()),
                        elevation: MaterialStateProperty.all(0),
                        overlayColor:
                        MaterialStateProperty.resolveWith<Color?>(
                                (states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.green.shade300;
                            }),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Happy',
                      style: kRateYourDayEmojiName,
                    )
                  ],
                ),
              ],
            ),

            TextField(
              controller: _titleController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _descriptionController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                Map<String, dynamic> notes = await FirestoreHelper.getUserDataFromDataField('notes', widget.userEmail);
                notes['${widget.day}, ${widget.month}, ${widget.year}']=[_titleController.text, _descriptionController.text, widget.feeling, widget.hasPhoto, widget.noteID];
                FirestoreHelper.addDataToFirestore('users_data', widget.userEmail, 'notes', notes);
                Navigator.pop(context);
              },
              child: Text('Add', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
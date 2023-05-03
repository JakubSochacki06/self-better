import 'package:flutter/material.dart';
import 'package:selfbetter/text_styles.dart';

class NoteTile extends StatelessWidget {
  final String noteTitle;
  final String noteDescription;
  final int feeling;
  final String day;
  final String month;

  NoteTile({
    required this.noteTitle,
    required this.noteDescription,
    required this.feeling,
    required this.day,
    required this.month,
  });

  Map feelingToString = {
    '1': 'angry',
    '2': 'sad',
    '3': 'mixed',
    '4': 'neutral',
    '5': 'happy',
  };

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
                          '${day} ${month}',
                          style: kNotesDate,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(noteTitle, style: kNoteTitle,),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(noteDescription, style: kNoteDescription, overflow: TextOverflow.ellipsis, maxLines: 4,),
            ),
          ],
        ),
      ),
    );
  }
}

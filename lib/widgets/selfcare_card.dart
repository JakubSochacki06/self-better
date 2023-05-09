import 'package:flutter/material.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SelfcareCard extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color emojiBackgroundColor;
  final String time;
  SelfcareCard({required this.title, required this.backgroundColor, required this.emojiBackgroundColor, required this.time});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 125,
      height: 175,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          CircleAvatar(
              radius: 30,
              backgroundColor: emojiBackgroundColor,
              child: Container(width:30, height:30, child: Image.asset('assets/images/emojis/${title.toLowerCase()}-emoji.png'))
          ),
          Spacer(),
          AutoSizeText(title, style: kToolContainerTitle, maxLines: 1,),
          SizedBox(height: 5,),
          Text('${time} min', style: kToolContainerSubject,)
        ],
      ),
    );
  }
}

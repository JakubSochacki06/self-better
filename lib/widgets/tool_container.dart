import 'package:flutter/material.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ToolContainer extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color emojiBackgroundColor;
  final Future<dynamic> future;
  final String subject;
  final Function() onTap;
  ToolContainer({required this.title, required this.backgroundColor, required this.emojiBackgroundColor, required this.future, required this.subject, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              child: Container(width:30, height:30, child: Image.asset('assets/images/emojis/${title}-emoji.png'))
            ),
            Spacer(),
            AutoSizeText(title, style: kToolContainerTitle, maxLines: 1,),
            SizedBox(height: 5,),
            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                  return Text('${snapshot.data!.length} ${subject}', style: kToolContainerSubject,);
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:selfbetter/text_styles.dart';

class FeelingButton extends StatelessWidget {
  final dynamic onPressed;
  MaterialStateProperty<Color> activeBackgroundColor;
  bool isActive;
  String feeling;
  FeelingButton({required this.onPressed, required this.activeBackgroundColor, required this.isActive, required this.feeling});
  MaterialStateProperty<Color> buttonBackgroundColor = MaterialStatePropertyAll(Color(0xfff5f5f5));

  @override
  Widget build(BuildContext context) {
    isActive == true? buttonBackgroundColor = activeBackgroundColor: buttonBackgroundColor = MaterialStatePropertyAll(Color(0xfff5f5f5));
    return Container(
      height: 100,
      width: 100,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: onPressed,
            child: Container(
              width: 40,
              height: 40,
              child:
              Image.asset('assets/images/emojis/${feeling}-emoji.png'),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: buttonBackgroundColor,
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              shape: MaterialStateProperty.all(CircleBorder()),
              elevation: MaterialStateProperty.all(0),
            ),
          ),
          SizedBox(height: 10),
          Text('${feeling[0].toUpperCase()}${feeling.substring(1).toLowerCase()}', style: kRateYourDayEmojiName,)
        ],
      ),
    );
  }
}

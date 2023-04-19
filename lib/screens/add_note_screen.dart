import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AddNotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Text('How do you feel today?'),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(width: 20.0, height: 100.0),
                  const Text(
                    'Write about',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(width: 20.0, height: 100.0),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText('your emotions'),
                        RotateAnimatedText('your plans'),
                        RotateAnimatedText('your feelings'),
                        RotateAnimatedText('fear or insecurity you’re working to overcome'),
                        RotateAnimatedText('your day'),
                        RotateAnimatedText('your recent failure'),
                        RotateAnimatedText('your thoughts'),
                        RotateAnimatedText('your goals'),
                        RotateAnimatedText('your recent disappointment'),
                        RotateAnimatedText('something you’re grateful for'),
                        RotateAnimatedText('recent realization'),
                        RotateAnimatedText('difficult decision they’re facing'),
                        RotateAnimatedText('your skill you’re working to improve'),
                        RotateAnimatedText('your dream'),
                        RotateAnimatedText('personal project you’re working on'),
                        RotateAnimatedText('omething you’ve been struggling with'),
                        RotateAnimatedText('relationship that is important to you'),
                        RotateAnimatedText('recent change in your life'),
                        RotateAnimatedText('personal values and beliefs'),
                        RotateAnimatedText('recent accomplishments you feel proud of'),
                        RotateAnimatedText('A new experience you’ve had recently'),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

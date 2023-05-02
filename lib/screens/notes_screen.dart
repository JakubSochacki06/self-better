import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:selfbetter/screens/add_note_screen.dart';
import 'package:selfbetter/text_styles.dart';

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Center(child: Text('Diary', style: kNotesScreenTitle)),
              leading: IconButton(
                icon: Icon(FontAwesomeIcons.kitchenSet),
                onPressed: (){
                },
              ),
              trailing: IconButton(
                icon: Icon(FontAwesomeIcons.add),
                onPressed: (){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: AddNotePage(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

// Widget AnimatedInsipirationsText(){
//   return               Row(
//     children: <Widget>[
//       const Text(
//         'Write about',
//         style: TextStyle(fontSize: 20.0),
//       ),
//       SizedBox(width: 20,),
//       DefaultTextStyle(
//         style: const TextStyle(
//           fontSize: 20.0,
//           color: Colors.black,
//         ),
//         child: Container(
//           height: 100,
//           width: MediaQuery.of(context).size.width/2,
//           child: AnimatedTextKit(
//             animatedTexts: [
//               RotateAnimatedText('your emotions', ),
//               RotateAnimatedText('your plans'),
//               RotateAnimatedText('your feelings'),
//               RotateAnimatedText('fear or insecurity you’re working to overcome'),
//               RotateAnimatedText('your day'),
//               RotateAnimatedText('your recent failure'),
//               RotateAnimatedText('your thoughts'),
//               RotateAnimatedText('your goals'),
//               RotateAnimatedText('your recent disappointment'),
//               RotateAnimatedText('something you’re grateful for'),
//               RotateAnimatedText('recent realization'),
//               RotateAnimatedText('difficult decision they’re facing'),
//               RotateAnimatedText('your skill you’re working to improve'),
//               RotateAnimatedText('your dream'),
//               RotateAnimatedText('personal project you’re working on'),
//               RotateAnimatedText('omething you’ve been struggling with'),
//               RotateAnimatedText('relationship that is important to you'),
//               RotateAnimatedText('recent change in your life'),
//               RotateAnimatedText('personal values and beliefs'),
//               RotateAnimatedText('recent accomplishments you feel proud of'),
//               RotateAnimatedText('A new experience you’ve had recently'),
//             ],
//             onTap: () {
//               print("Tap Event");
//             },
//           ),
//         ),
//       ),
//     ],
//   ),
// }
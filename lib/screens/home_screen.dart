import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:selfbetter/screens/notes_screen.dart';
import 'package:selfbetter/screens/rate_your_day_screen.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selfbetter/widgets/tool_container.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(FontAwesomeIcons.star),
                        SizedBox(
                          width: 10,
                        ),
                        Text('354 PTS'),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            'https://cdn.betterttv.net/emote/5f65d6494c714103dfb56ca5/3x.webp',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  user.displayName == null
                      ? 'Hey ${user.email},'
                      : 'Hey ${user.displayName},',
                  style: kHomePageGreeting,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('hope you are well today!', style: kHomePageWish),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Your toolbox', style: kHomePageTitle),
              ),
              SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ToolContainer(
                        title: 'notes',
                        backgroundColor: Color(0xFFFFF2CC),
                        emojiBackgroundColor: Color(0x80FADAB1),
                        future: FirestoreHelper.getUserDataFromDataField('notes', user.email!),
                        subject: 'notes',
                      onTap: (){
                        print('change index of navbar');
                      },
                    ),
                    SizedBox(width: 15,),
                    ToolContainer(
                        title: 'day ratings',
                        backgroundColor: Color(0xFFE7F3FF),
                        emojiBackgroundColor: Color(0xFFD2E7FD),
                        future: FirestoreHelper.getUserDataFromDataField('day_ratings', user.email!),
                        subject: 'day rates',
                      onTap: (){
                          print('change index of navbar');
                      },),
                    SizedBox(width: 15,),
                    ToolContainer(
                      title: 'day ratings',
                      backgroundColor: Color(0xFFE7F3FF),
                      emojiBackgroundColor: Color(0xFFD2E7FD),
                      future: FirestoreHelper.getUserDataFromDataField('day_ratings', user.email!),
                      subject: 'day rates',
                      onTap: (){
                        print('change index of navbar');
                      },),
                    SizedBox(width: 15,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

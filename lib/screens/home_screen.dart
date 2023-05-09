import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selfbetter/widgets/summary_box.dart';
import 'package:provider/provider.dart';
import 'package:selfbetter/widgets/selfcare_card.dart';

List<dynamic> activities = [
  ['Meditation', Color(0xFFC4F1CD), Colors.white, '30'],
  ['Journaling', Color(0xFFE5EEC2), Colors.white, '20'],
  ['Gymnastics', Color(0xFFAAEDE9), Colors.white, '10-15'],
  ['Mindful walking', Color(0xFFBFE9EF), Colors.white, '30+'],
  ['Mindful walking', Color(0xFFBFE9EF), Colors.white, '30+'],
  ['Mindful walking', Color(0xFFBFE9EF), Colors.white, '30+'],
];

class HomePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(25),
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
                child: Text('Your summary', style: kHomePageTitle),
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SummaryBox(
                      title: 'notes',
                      backgroundColor: Color(0xFFFFF2CC),
                      emojiBackgroundColor: Color(0x80FADAB1),
                      future: FirestoreHelper.getUserDataFromDataField(
                          'notes', user.email!),
                      subject: 'notes',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SummaryBox(
                      title: 'day ratings',
                      backgroundColor: Color(0xFFE7F3FF),
                      emojiBackgroundColor: Color(0xFFD2E7FD),
                      future: FirestoreHelper.getUserDataFromDataField(
                          'day_ratings', user.email!),
                      subject: 'day rates',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SummaryBox(
                      title: 'day ratings',
                      backgroundColor: Color(0xFFE7F3FF),
                      emojiBackgroundColor: Color(0xFFD2E7FD),
                      future: FirestoreHelper.getUserDataFromDataField(
                          'day_ratings', user.email!),
                      subject: 'day rates',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Self-care', style: kHomePageTitle),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 545,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2/2,
                      crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10
                  ),
                  itemBuilder: (context, index) {
                    return SelfcareCard(
                        title: activities[index][0],
                        backgroundColor: activities[index][1],
                        emojiBackgroundColor: activities[index][2],
                        time: activities[index][3],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

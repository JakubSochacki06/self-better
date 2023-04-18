import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfbetter/providers/firestore_helper.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:selfbetter/widgets/feeling_button.dart';
import 'package:slide_countdown/slide_countdown.dart';

final db = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser!;

class RateYourDayPage extends StatefulWidget {
  Widget submitButtonChild =
  Text('Submit', style: TextStyle(color: Colors.black87));

  @override
  State<RateYourDayPage> createState() => _RateYourDayPageState();
}

class _RateYourDayPageState extends State<RateYourDayPage> {
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
  MaterialStateProperty<Color> emojiTiredActiveColor =
  MaterialStateProperty.all(Colors.grey.shade300);
  MaterialStateProperty<Color> emojiLonelyActiveColor =
  MaterialStateProperty.all(Colors.grey.shade300);
  MaterialStateProperty<Color> emojiBadMentalActiveColor =
  MaterialStateProperty.all(Colors.grey.shade300);
  MaterialStateProperty<Color> emojiOverthinkingActiveColor =
  MaterialStateProperty.all(Colors.grey.shade300);
  MaterialStateProperty<Color> emojiStressedActiveColor =
  MaterialStateProperty.all(Colors.grey.shade300);
  MaterialStateProperty<Color> emojiSuccessActiveColor =
  MaterialStateProperty.all(Colors.grey.shade300);
  bool emojiTiredIsActive = false;
  bool emojiLonelyIsActive = false;
  bool emojiBadMentalIsActive = false;
  bool emojiOverthinkingIsActive = false;
  bool emojiStressedIsActive = false;
  bool emojiSuccessIsActive = false;
  int activeGeneralEmoji = 0;

  bool? isButtonActive() {
    if (activeGeneralEmoji != 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool submitActive = isButtonActive()!;
    print(submitActive);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'How do you feel today?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.0),
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
                SizedBox(height: 15),
                Text(
                  'Tell me a little bit more',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade400),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FeelingButton(
                        activeBackgroundColor: emojiTiredActiveColor,
                        isActive: emojiTiredIsActive,
                        feeling: 'tired',
                        onPressed: () {
                          setState(() {
                            emojiTiredIsActive = !emojiTiredIsActive;
                          });
                        }),
                    FeelingButton(
                        activeBackgroundColor: emojiLonelyActiveColor,
                        isActive: emojiLonelyIsActive,
                        feeling: 'lonely',
                        onPressed: () {
                          setState(() {
                            emojiLonelyIsActive = !emojiLonelyIsActive;
                          });
                        }),
                    FeelingButton(
                        activeBackgroundColor: emojiBadMentalActiveColor,
                        isActive: emojiBadMentalIsActive,
                        feeling: 'bad mental',
                        onPressed: () {
                          setState(() {
                            emojiBadMentalIsActive = !emojiBadMentalIsActive;
                          });
                        }),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FeelingButton(
                        activeBackgroundColor: emojiStressedActiveColor,
                        isActive: emojiStressedIsActive,
                        feeling: 'stressed',
                        onPressed: () {
                          setState(() {
                            emojiStressedIsActive = !emojiStressedIsActive;
                          });
                        }),
                    FeelingButton(
                        activeBackgroundColor: emojiOverthinkingActiveColor,
                        isActive: emojiOverthinkingIsActive,
                        feeling: 'overthinking',
                        onPressed: () {
                          setState(() {
                            emojiOverthinkingIsActive =
                            !emojiOverthinkingIsActive;
                          });
                        }),
                    FeelingButton(
                        activeBackgroundColor: emojiSuccessActiveColor,
                        isActive: emojiSuccessIsActive,
                        feeling: 'success',
                        onPressed: () {
                          setState(() {
                            emojiSuccessIsActive = !emojiSuccessIsActive;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Today was a',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade400),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Good day',
                        style: TextStyle(color: Colors.black87),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              width: 1.0,
                              color: Colors.green,
                            )),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Bad day',
                          style: TextStyle(color: Colors.black87)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              width: 1.0,
                              color: Colors.red,
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  onPressed: submitActive
                      ? () async {
                    List activeEmojis = [
                      activeGeneralEmoji,
                      emojiTiredIsActive,
                      emojiLonelyIsActive,
                      emojiBadMentalIsActive,
                      emojiOverthinkingIsActive,
                      emojiStressedIsActive,
                      emojiSuccessIsActive
                    ];
                    DateTime now = new DateTime.now();
                    FirestoreHelper firestoreHelper = Provider.of<FirestoreHelper>(context, listen: false);
                    Map data = {'${now.day}, ${now.month}, ${now.year}': activeEmojis};
                    List<dynamic>? dayRatings = await firestoreHelper.getUserDataFromDataField('day_ratings', user.email!);
                    if(dayRatings == null){
                      firestoreHelper.addDataToFirestore('users_data', user.email!, 'day_ratings', [data]);
                      return;
                    } else {
                      List<dynamic> ratings = dayRatings;
                      // Checks if user is NOT trying to sumbit same day
                      var lastEntryKey = ratings[ratings.length - 1].entries.toList()[0].key;
                      if(!(lastEntryKey == '${now.day}, ${now.month}, ${now.year}')){
                        ratings.add({
                          '${now.day}, ${now.month}, ${now.year}':
                          activeEmojis
                        });
                        firestoreHelper.addDataToFirestore('users_data', user.email!, 'day_ratings', ratings);
                      }
                      else {
                        if(listEquals(ratings[ratings.length - 1]['${now.day}, ${now.month}, ${now.year}'], data['${now.day}, ${now.month}, ${now.year}'])){
                          return;
                        }
                        ratings[ratings.length-1] = data;
                        firestoreHelper.addDataToFirestore('users_data', user.email!, 'day_ratings', ratings);
                      }
                      return;
                    }



                    // await for (var snapshot
                    // in db.collection('users_data').snapshots()) {
                    //   for (var message in snapshot.docs) {
                    //     if (message.data()['user_email'] == user.email) {
                    //       if (message.data()['day_ratings'] == null) {
                    //         firestoreHelper.addDataToFirestore('users_data', user.email!, 'day_ratings', [data]);
                    //         return;
                    //       } else {
                    //         List<dynamic> ratings =
                    //         message.data()['day_ratings'];
                    //         // Checks if user is NOT trying to sumbit same day
                    //         var lastEntryKey = ratings[ratings.length - 1].entries.toList()[0].key;
                    //         if(!(lastEntryKey == '${now.day}, ${now.month}, ${now.year}')){
                    //           ratings.add({
                    //             '${now.day}, ${now.month}, ${now.year}':
                    //             activeEmojis
                    //           });
                    //           firestoreHelper.addDataToFirestore('users_data', user.email!, 'day_ratings', ratings);
                    //         }
                    //         // Same day submitted again, so we have to check if values are also the same
                    //         else {
                    //           if(listEquals(ratings[ratings.length - 1]['${now.day}, ${now.month}, ${now.year}'], data['${now.day}, ${now.month}, ${now.year}'])){
                    //             return;
                    //           }
                    //           ratings[ratings.length-1] = data;
                    //           firestoreHelper.addDataToFirestore('users_data', user.email!, 'day_ratings', ratings);
                    //         }
                    //         return;
                    //       }
                    //     }
                    //   }
                    // }
                  }
                      : null,
                  child: widget.submitButtonChild,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.blue,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

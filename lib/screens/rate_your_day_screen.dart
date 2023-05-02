import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:selfbetter/widgets/feeling_button.dart';

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
  MaterialStateProperty<Color> emojiAnnoyedActiveColor =
  MaterialStateProperty.all(Colors.grey.shade300);
  MaterialStateProperty<Color> emojiAnxiousActiveColor =
  MaterialStateProperty.all(Colors.grey.shade300);
  MaterialStateProperty<Color> emojiProudActiveColor =
  MaterialStateProperty.all(Colors.grey.shade300);
  bool emojiTiredIsActive = false;
  bool emojiLonelyIsActive = false;
  bool emojiBadMentalIsActive = false;
  bool emojiOverthinkingIsActive = false;
  bool emojiStressedIsActive = false;
  bool emojiSuccessIsActive = false;
  bool emojiAnnoyedIsActive = false;
  bool emojiAnxiousIsActive = false;
  bool emojiProudIsActive = false;
  int activeGeneralEmoji = 0;
  bool badDayActive = false;
  bool goodDayActive = false;

  TextEditingController _textEditingController = TextEditingController();

  bool? isButtonActive() {
    if (activeGeneralEmoji != 0) {
      return true;
    }
    return false;
  }

  void sendData() async {
    List activeEmojis = [
      activeGeneralEmoji,
      emojiTiredIsActive,
      emojiLonelyIsActive,
      emojiBadMentalIsActive,
      emojiOverthinkingIsActive,
      emojiStressedIsActive,
      emojiSuccessIsActive,
      emojiAnnoyedIsActive,
      emojiProudIsActive,
      emojiAnxiousIsActive,
      goodDayActive
    ];
    DateTime now = new DateTime.now();
    Map data = {
      '${now.day}, ${now.month}, ${now.year}':
      activeEmojis
    };
    List<dynamic>? dayRatings =
    await FirestoreHelper.getUserDataFromDataField(
        'day_ratings', user.email!);
    if (dayRatings == null) {
      FirestoreHelper.addDataToFirestore('users_data',
          user.email!, 'day_ratings', [data]);
      return;
    } else {
      List<dynamic> ratings = dayRatings;
      // Checks if user is NOT trying to sumbit same day
      var lastEntryKey = ratings[ratings.length - 1]
          .entries
          .toList()[0]
          .key;
      if (!(lastEntryKey ==
          '${now.day}, ${now.month}, ${now.year}')) {
        ratings.add({
          '${now.day}, ${now.month}, ${now.year}':
          activeEmojis
        });
        FirestoreHelper.addDataToFirestore('users_data',
            user.email!, 'day_ratings', ratings);
      } else {
        if (listEquals(
            ratings[ratings.length - 1]
            ['${now.day}, ${now.month}, ${now.year}'],
            data[
            '${now.day}, ${now.month}, ${now.year}'])) {
          return;
        }
        ratings[ratings.length - 1] = data;
        FirestoreHelper.addDataToFirestore('users_data',
            user.email!, 'day_ratings', ratings);
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool submitActive = isButtonActive()!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
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
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FeelingButton(
                          activeBackgroundColor: emojiAnnoyedActiveColor,
                          isActive: emojiAnnoyedIsActive,
                          feeling: 'annoyed',
                          onPressed: () {
                            setState(() {
                              emojiAnnoyedIsActive = !emojiAnnoyedIsActive;
                            });
                          }),
                      FeelingButton(
                          activeBackgroundColor: emojiProudActiveColor,
                          isActive: emojiProudIsActive,
                          feeling: 'proud',
                          onPressed: () {
                            setState(() {
                              emojiProudIsActive =
                              !emojiProudIsActive;
                            });
                          }),
                      FeelingButton(
                          activeBackgroundColor: emojiAnxiousActiveColor,
                          isActive: emojiAnxiousIsActive,
                          feeling: 'anxious',
                          onPressed: () {
                            setState(() {
                              emojiAnxiousIsActive = !emojiAnxiousIsActive;
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
                        onPressed: () {
                          setState(() {
                            badDayActive = true;
                            goodDayActive = false;
                          });
                        },
                        child: Text('Bad day',
                            style: TextStyle(color: Colors.black87)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(120, 40),
                          backgroundColor: badDayActive? Colors.red.shade100 : Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                width: 1.0,
                                color: badDayActive? Colors.red : Colors.grey.shade100,
                              )),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            badDayActive = false;
                            goodDayActive = true;
                          });
                        },
                        child: Text(
                          'Good day',
                          style: TextStyle(color: Colors.black87),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(120, 40),
                          backgroundColor: goodDayActive? Colors.green.shade100 : Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                width: 1.0,
                                color: goodDayActive? Colors.green : Colors.grey.shade100,
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
                        ? sendData
                        : null,
                    child: widget.submitButtonChild,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                      minimumSize: Size(120, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            width: 1.0,
                            color: submitActive? Colors.blue : Colors.grey.shade100,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
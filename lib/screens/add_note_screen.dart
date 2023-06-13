import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:selfbetter/helpers/storage_helper.dart';
import 'package:selfbetter/widgets/image_input.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AddNotePage extends StatefulWidget {
  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  File? _pickedImage;

  String? addressFromDetails;

  double? latFromDetails;

  double? longFromDetails;

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

  int activeGeneralEmoji = 0;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void sendData() async{
      Map<String, dynamic>? notes = await FirestoreHelper.getUserDataFromDataField('notes', user.email!);
      int noteID;
      print(notes!.values.elementAt(notes.length-1));
      notes!.length == 0? noteID = 0: noteID = notes.values.elementAt(notes.length-1)[4];
      DateTime now = new DateTime.now();
      List<dynamic> notesData = [_titleController.text, _descriptionController.text, activeGeneralEmoji, _pickedImage == null? false : true, noteID];
      Map data = {'${now.day}, ${now.month}, ${now.year}': notesData};
      print(notes);
      if(notes == null){
        print('NO NOTES');
        FirestoreHelper.addDataToFirestore('users_data', user.email!, 'notes', data);
        return;
      } else {
        print('NOTES FOUND');
        if(notes['${now.day}, ${now.month}, ${now.year}'] != null){
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message:
              'You already added note today! Try to edit it.',
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else {
          notes['${now.day}, ${now.month}, ${now.year}'] = notesData;
          FirestoreHelper.addDataToFirestore('users_data', user.email!, 'notes', notes);
        }
      }
      if(_pickedImage != null){
        StorageHelper.uploadFile(_titleController.text, user.email!, _pickedImage!);
      }
      Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text('Leave a note about this day', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
              SizedBox(height: 10),
              Text('Overall feeling', style: TextStyle(fontSize: 16),),
              SizedBox(height: 10),
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Write about',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          width: 250,
                          child: DefaultTextStyle(
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                RotateAnimatedText(
                                  'your emotions', alignment: Alignment.centerLeft, textAlign: TextAlign.center
                                ),
                                RotateAnimatedText('your plans', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText('your feelings', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    'insecurity you’re working to overcome', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText('your day', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText('your recent failure', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText('your thoughts', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText('your goals', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    'your recent disappointment', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    'something you’re grateful for', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText('recent realization', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    'difficult decision you’re facing', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    'skill you’re working to improve', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText('your dream', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    'personal project you’re working on', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    'something you’ve been struggling with', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    'relationship that is important to you', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    'recent change in your life', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    'personal values and beliefs', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    'recent accomplishments you feel proud of', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                                RotateAnimatedText(
                                    ' new experience you’ve had recently', alignment: Alignment.centerLeft, textAlign: TextAlign.center),
                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _titleController,
                    onChanged: (value){
                      if(value.length<=1){
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 125,
                    child: TextField(
                      maxLines: null,
                      expands: true,
                      onChanged: (value){
                        if(value.length<=1){
                          print('setstate');
                          setState(() {});
                        }
                      },
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ImageInput(
                    onSelectImage: _selectImage,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: activeGeneralEmoji != 0 && _titleController.text != '' && _descriptionController.text != ''?
                    sendData
                    :null,
                child: Text('Submit', style: TextStyle(color: Colors.black87)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  minimumSize: Size(120, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        width: 1.0,
                        color: activeGeneralEmoji != 0 && _titleController.text != '' && _descriptionController.text != ''? Colors.blue: Colors.grey.shade100,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

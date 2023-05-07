import 'package:flutter/material.dart';
import 'package:selfbetter/helpers/storage_helper.dart';

class NoteDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final String day;
  final String month;
  final String userEmail;
  final String feelingImagePath;
  final bool hasPhoto;

  NoteDetailsPage({
    required this.title,
    required this.description,
    required this.day,
    required this.month,
    required this.userEmail,
    required this.feelingImagePath,
    required this.hasPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Note Details',
              style: TextStyle(
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            Text('${day} ${month}',
                style: TextStyle(
                  fontSize: 35,
                ),
                textAlign: TextAlign.center),
            Text(title,
                style: TextStyle(
                  fontSize: 35,
                ),
                textAlign: TextAlign.center),
            SizedBox(
              height: 15,
            ),
            Text(description,
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                hasPhoto == true?                 FutureBuilder(
                  future: StorageHelper.getImageURL(title, userEmail),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        width: 300,
                        height: 250,
                        child: Image.network(snapshot.data!, fit: BoxFit.cover,),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                        ),
                      );
                    }
                  },
                ) : Text('No photo left in note'),
                Image.asset(feelingImagePath),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

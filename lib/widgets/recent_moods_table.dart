import 'package:flutter/material.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:selfbetter/widgets/mood_chart.dart';
User user = FirebaseAuth.instance.currentUser!;
class RecentMoodsTable extends StatefulWidget {

  @override
  State<RecentMoodsTable> createState() => _RecentMoodsTableState();
}

class _RecentMoodsTableState extends State<RecentMoodsTable> {
  late Future<dynamic> dataFuture;

  @override
  void initState() {
    dataFuture = FirestoreHelper.getUserDataFromDataField('day_ratings', user.email!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int amountOfMoods = 14;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Recent moods:',
            style: kStatsPageTitle,
          ),
        ),
        FutureBuilder(
          future: dataFuture,
          builder: (context, snapshot) {
            print(amountOfMoods);
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return MoodChart(
                amountOfMoods: amountOfMoods,
                snapshotData: snapshot.data,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
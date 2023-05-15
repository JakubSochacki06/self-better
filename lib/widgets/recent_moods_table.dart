import 'package:flutter/material.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:selfbetter/widgets/mood_chart.dart';

class RecentMoodsTable extends StatefulWidget {
  const RecentMoodsTable({Key? key}) : super(key: key);

  @override
  State<RecentMoodsTable> createState() => _RecentMoodsTableState();
}

class _RecentMoodsTableState extends State<RecentMoodsTable> {
  User user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    int amountOfDays = 7;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Recent moods:',
            style: kStatsPageTitle,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TextButton(onPressed: () {}, child: Text('Last 7 days')),
              TextButton(onPressed: () {}, child: Text('Last 14 days')),
              TextButton(onPressed: () {}, child: Text('Last 30 days')),
              TextButton(onPressed: () {}, child: Text('Last 90 days')),
            ],
          ),
        ),
        FutureBuilder(
          future: FirestoreHelper.getUserDataFromDataField('day_ratings', user.email!),
          builder: (context, snapshot) {
            return MoodChart(amountOfMoods: amountOfDays, snapshotData: snapshot.data,);
          },
        ),
      ],
    );
  }
}

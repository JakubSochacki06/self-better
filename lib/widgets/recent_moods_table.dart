import 'package:flutter/material.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbetter/text_styles.dart';

class RecentMoodsTable extends StatefulWidget {
  const RecentMoodsTable({Key? key}) : super(key: key);

  @override
  State<RecentMoodsTable> createState() => _RecentMoodsTableState();
}

class _RecentMoodsTableState extends State<RecentMoodsTable> {
  User user = FirebaseAuth.instance.currentUser!;

  // void getMoodData(int amountOfDays, dynamic snapshotData) async{
  //   List<dynamic> dayRatings = await FirestoreHelper.getUserDataFromDataField('day_ratings', user.email!);
  //   print(dayRatings.keys);
  // }
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
              TextButton(onPressed: () {}, child: Text('Last 30 days')),
              TextButton(onPressed: () {}, child: Text('Last 3 months')),
              TextButton(onPressed: () {}, child: Text('Last year months')),
            ],
          ),
        ),
        FutureBuilder(
          future: FirestoreHelper.getUserDataFromDataField('day_ratings', user.email!),
          builder: (context, snapshot) {
            return Container();
          },
        ),
      ],
    );
  }
}

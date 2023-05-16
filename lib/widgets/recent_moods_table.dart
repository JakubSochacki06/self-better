import 'package:flutter/material.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:selfbetter/widgets/mood_chart.dart';
User user = FirebaseAuth.instance.currentUser!;
class RecentMoodsTable extends StatefulWidget {
  const RecentMoodsTable({Key? key}) : super(key: key);

  @override
  State<RecentMoodsTable> createState() => _RecentMoodsTableState();
}

class _RecentMoodsTableState extends State<RecentMoodsTable> {
  Future _future = FirestoreHelper.getUserDataFromDataField(
      'day_ratings', user.email!);

  Future<dynamic> getNewFuture() async {
    return FirestoreHelper.getUserDataFromDataField(
        'day_ratings', user.email!);
  }
  void refreshData() {
    setState(() {
      _future = getNewFuture();
    });
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TextButton(
                  onPressed: () {
                      amountOfMoods = 7;
                      refreshData();
                  },
                  child: Text('Last 7 moods')),
              TextButton(
                  onPressed: () {
                      amountOfMoods = 14;
                      refreshData();
                  },
                  child: Text('Last 14 moods')),
              TextButton(onPressed: () {}, child: Text('Last 30 moods')),
              TextButton(onPressed: () {}, child: Text('Last 90 moods')),
            ],
          ),
        ),
        FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
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

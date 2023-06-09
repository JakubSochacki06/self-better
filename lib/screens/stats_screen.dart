import 'package:flutter/material.dart';
import 'package:selfbetter/widgets/feelings_calendar.dart';
import 'package:selfbetter/widgets/recent_moods_table.dart';
import 'package:selfbetter/widgets/recent_moods_stats.dart';
import 'package:selfbetter/helpers/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatsPage extends StatefulWidget {
  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  User user = FirebaseAuth.instance.currentUser!;
  late Future<dynamic> dataFuture;

  void initState() {
    dataFuture =
        FirestoreHelper.getUserDataFromDataField('day_ratings', user.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: FutureBuilder(
                future: dataFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        FeelingsCalendar(),
                        RecentMoodsTable(
                          snapshotData: snapshot.data,
                        ),
                        SizedBox(height: 20,),
                        RecentMoodsStats(
                          snapshotData: snapshot.data,
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),
    );
  }
}

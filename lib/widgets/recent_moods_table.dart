import 'package:flutter/material.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:selfbetter/widgets/mood_chart.dart';
import 'package:selfbetter/widgets/recent_moods_stats.dart';

class RecentMoodsTable extends StatefulWidget {
  final Map<String, dynamic> snapshotData;
  RecentMoodsTable({required this.snapshotData});
  @override
  State<RecentMoodsTable> createState() => _RecentMoodsTableState();
}

class _RecentMoodsTableState extends State<RecentMoodsTable> {
  @override
  Widget build(BuildContext context) {
    int amountOfMoods;
    widget.snapshotData.length < 7? amountOfMoods = widget.snapshotData.length: amountOfMoods = 7;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Recent moods:',
            style: kStatsPageTitle,
          ),
        ),
        amountOfMoods>2?MoodChart(
          amountOfMoods: amountOfMoods,
          snapshotData: widget.snapshotData,
        ):Container(
          padding: EdgeInsets.all(15),
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
          child: Center(
            child: Text('You have less than 2 moods submitted.\nCome back tomorrow and check the result!'),
          ),
        ),
      ],
    );
  }
}

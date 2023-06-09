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
        MoodChart(
          amountOfMoods: amountOfMoods,
          snapshotData: widget.snapshotData,
        )
      ],
    );
  }
}

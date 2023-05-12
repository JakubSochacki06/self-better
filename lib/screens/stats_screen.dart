import 'package:flutter/material.dart';
import 'package:selfbetter/widgets/feelings_calendar.dart';

class StatsPage extends StatefulWidget {
  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            FeelingsCalendar(),
            
          ],
        ),
      ),
    );
  }
}

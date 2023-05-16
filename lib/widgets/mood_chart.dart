import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoodChart extends StatelessWidget {
  final int amountOfMoods;
  final dynamic snapshotData;

  MoodChart({required this.snapshotData, required this.amountOfMoods});

  List<Color> gradientColors = [Colors.red, Colors.orange, Colors.green];
  List<FlSpot> spots = [];

  void setSpots(int amountOfMoods, dynamic snapshotData) {
    Map<DateTime, Map<String, dynamic>> orderedData = {};

    List<dynamic> sortedKeys = snapshotData.keys
        .map((key) => DateFormat('yyyy-MM-dd').parse(key))
        .toList()
      ..sort();

    for (var key in sortedKeys) {
      orderedData[key] = snapshotData[DateFormat('yyyy-MM-dd').format(key)]!;
    }
    List<dynamic> chosenAmountOfSortedValues = orderedData.values.toList().reversed.toList().sublist(0,amountOfMoods);
    for(int i = 0;i< chosenAmountOfSortedValues.length;i++){
      int feelingAsNumber = chosenAmountOfSortedValues.toList()[i]['feelingAsNumber'];
      spots.add(FlSpot(i.toDouble(), feelingAsNumber.toDouble()));
    }
  }

  @override
  Widget build(BuildContext context) {
    setSpots(amountOfMoods, snapshotData);
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.7,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Text text = Text('', style: style);
    if(!(value>snapshotData.keys.toList().length)){
      if(value < amountOfMoods){
        List<dynamic> sortedDates = snapshotData.keys.toList()
            .map((dateString) => DateFormat('yyyy-MM-dd').parse(dateString))
            .toList();
        sortedDates.sort((a, b) => a.day.compareTo(b.day));
        List<dynamic> chosenAmountOfSortedDates = sortedDates.reversed.toList().sublist(0,amountOfMoods);
        DateTime date = chosenAmountOfSortedDates.reversed.toList()[value.toInt()];
        List<String> months = [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December'
        ];
        String monthName = months[date.month - 1];
        text = Text('${date.day} ${monthName}');
      };
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String feelingName;
    switch (value.toInt()) {
      case 1:
        feelingName = 'angry';
        break;
      case 2:
        feelingName = 'sad';
        break;
      case 3:
        feelingName = 'mixed';
        break;
      case 4:
        feelingName = 'neutral';
        break;
      case 5:
        feelingName = 'happy';
        break;
      default:
        return Container();
    }

    return Container(
      width: 30,
      height: 30,
      child: Image.asset(
          'assets/images/emojis/${feelingName}-emoji.png'),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
    );
  }

  LineChartData mainData() {
    print(spots);
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.black12),
      ),
      minX: 0,
      maxX: 14,
      minY: 1,
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            // stops: [1,3,5],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.red, Colors.orange, Colors.green],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoodChart extends StatefulWidget {
  int amountOfMoods;
  final dynamic snapshotData;

  MoodChart({required this.snapshotData, required this.amountOfMoods});

  @override
  State<MoodChart> createState() => _MoodChartState();
}

class _MoodChartState extends State<MoodChart> {
  List<Color> gradientColors = [Colors.red, Colors.orange, Colors.green];

  List<FlSpot> spots = [];

  void setSpots(int amountOfMoods, dynamic snapshotData) {
    spots = [];
    Map<DateTime, Map<String, dynamic>> orderedData = {};

    List<dynamic> sortedKeys = snapshotData.keys
        .map((key) => DateFormat('yyyy-MM-dd').parse(key))
        .toList()
      ..sort();

    for (var key in sortedKeys) {
      orderedData[key] = snapshotData[DateFormat('yyyy-MM-dd').format(key)]!;
    }
    List<dynamic> chosenAmountOfSortedValues =
    orderedData.values.toList().reversed.toList().sublist(0, amountOfMoods);
    for (int i = 0; i < chosenAmountOfSortedValues.length; i++) {
      int feelingAsNumber =
      chosenAmountOfSortedValues.toList().reversed.toList()[i]['feelingAsNumber'];
      spots.add(FlSpot(i.toDouble(), feelingAsNumber.toDouble()));
    }
  }

  @override
  Widget build(BuildContext context) {
    setSpots(widget.amountOfMoods, widget.snapshotData);
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.7,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              widget.amountOfMoods = 7;
                            });
                          }, child: Text('Last 7 moods')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              widget.amountOfMoods = 14;
                            });
                          }, child: Text('Last 14 moods')),
                      TextButton(
                          onPressed: () {}, child: Text('Last 30 moods')),
                      TextButton(
                          onPressed: () {}, child: Text('Last 90 moods')),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 5,
                child: LineChart(
                  mainData(),
                ),
              ),
            ],
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
    if (!(value > widget.snapshotData.keys.toList().length)) {
      if (value < widget.amountOfMoods) {
        List<dynamic> sortedDates = widget.snapshotData.keys
            .toList()
            .map((dateString) => DateFormat('yyyy-MM-dd').parse(dateString))
            .toList();
        sortedDates.sort((a, b) => a.day.compareTo(b.day));
        List<dynamic> chosenAmountOfSortedDates =
        sortedDates.reversed.toList().sublist(0, widget.amountOfMoods);
        DateTime date =
        chosenAmountOfSortedDates.reversed.toList()[value.toInt()];
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
      }
      ;
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
      child: Image.asset('assets/images/emojis/${feelingName}-emoji.png'),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
    );
  }

  LineChartData mainData() {
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
            showTitles: false,
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
      maxX: widget.amountOfMoods-1,
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
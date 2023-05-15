import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MoodChart extends StatelessWidget {
  final int amountOfMoods;
  final dynamic snapshotData;

  MoodChart({required this.snapshotData, required this.amountOfMoods});

  List<Color> gradientColors = [Colors.red, Colors.orange, Colors.green];
  List<FlSpot> spots = [];

  // void setSpots(int amountOfDays, dynamic snapshotData) {
  //   final endDate = DateTime.now().subtract(Duration(days: amountOfDays));
  //   f
  //   snapshotData.forEach((key, value) {
  //     if (DateTime.parse(key).isAfter(endDate)) {
  //       spots
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // setSpots(amountOfMoods, snapshotData);
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
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
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
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 1),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
            FlSpot(14, 2),
          ],
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
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:selfbetter/text_styles.dart';

class RecentMoodsStats extends StatefulWidget {
  final Map<String, dynamic> snapshotData;

  RecentMoodsStats({required this.snapshotData});

  @override
  State<StatefulWidget> createState() => RecentMoodsStatsState();
}

class RecentMoodsStatsState extends State<RecentMoodsStats> {
  int touchedIndex = 0;
  Map<String, int> feelingsAmount = {};

  void setChartData(Map<String, dynamic> snapshotData) {
    snapshotData.forEach((key, value) {
      print(value['feeling']);
      if (feelingsAmount.containsKey(value['feeling'])) {
        feelingsAmount[value['feeling']] =
            feelingsAmount[value['feeling']]! + 1;
      } else {
        feelingsAmount[value['feeling']] = 1;
      }
    });
  }

  @override
  void initState() {
    setChartData(widget.snapshotData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Total moods chart',
            style: kStatsPageTitle,
          ),
        ),
        AspectRatio(
          aspectRatio: 1.3,
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showingSections(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      // print((feelingsAmount['angry']! * 100/widget.snapshotData.length).roundToDouble());
      switch (i) {
        case 0:
          double value =
              (feelingsAmount['angry']! * 100 / widget.snapshotData.length)
                  .roundToDouble();
          return PieChartSectionData(
            color: Colors.red,
            value: value,
            title: '${value}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/images/emojis/angry-emoji.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          double value =
              (feelingsAmount['sad']! * 100 / widget.snapshotData.length)
                  .roundToDouble();
          return PieChartSectionData(
            color: Colors.orange,
            value: value,
            title: '${value}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/images/emojis/sad-emoji.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          double value =
              (feelingsAmount['mixed']! * 100 / widget.snapshotData.length)
                  .roundToDouble();
          return PieChartSectionData(
            color: Colors.purple,
            value: value,
            title: '${value}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/images/emojis/mixed-emoji.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          double value =
              (feelingsAmount['neutral']! * 100 / widget.snapshotData.length)
                  .roundToDouble();
          return PieChartSectionData(
            color: Colors.yellow,
            value: value,
            title: '${value}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/images/emojis/neutral-emoji.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          double value =
              (feelingsAmount['happy']! * 100 / widget.snapshotData.length)
                  .roundToDouble();
          return PieChartSectionData(
            color: Colors.green,
            value: value,
            title: '${value}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/images/emojis/happy-emoji.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.emojiPath, {
    required this.size,
    required this.borderColor,
  });

  final String emojiPath;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(child: Image.asset(emojiPath)),
    );
  }
}

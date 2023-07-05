import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:selfbetter/string_extension.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:selfbetter/helpers/feelings_helper.dart';
import 'package:http/http.dart';

class RecentMoodsStats extends StatefulWidget {
  final Map<String, dynamic> snapshotData;

  RecentMoodsStats({required this.snapshotData});

  @override
  State<StatefulWidget> createState() => RecentMoodsStatsState();
}

class RecentMoodsStatsState extends State<RecentMoodsStats> {
  late Future<String> adviceFuture;
  int touchedIndex = 0;
  late Map<String, int> feelingsAmount;
  late String averageMood;
  late Color adviceBorderColor;
  late Color adviceBackgroundColor;


  Future<String> getAdvice(String mood) async {
    switch(mood){
      case 'angry':
        adviceBorderColor = Colors.red.shade600;
        adviceBackgroundColor = Colors.red.shade200;
        break;
      case 'sad':
        adviceBorderColor = Colors.orange.shade600;
        adviceBackgroundColor = Colors.orange.shade200;
        break;
      case 'mixed':
        adviceBorderColor = Colors.purple.shade600;
        adviceBackgroundColor = Colors.purple.shade200;
        break;
      case 'neutral':
        adviceBorderColor = Colors.yellow.shade600;
        adviceBackgroundColor = Colors.yellow.shade200;
        break;
      case 'happy':
        adviceBorderColor = Colors.green.shade600;
        adviceBackgroundColor = Colors.green.shade200;
        break;
    }
    Response response = await get(Uri.parse('https://selfbetter-api.onrender.com/advice/$mood'));
    return response.body;
  }

  @override
  void initState() {
    feelingsAmount = FeelingsHelper.getFeelingsAmount(widget.snapshotData);
    averageMood = FeelingsHelper.getAverageMood(feelingsAmount);
    adviceFuture = getAdvice(averageMood);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
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
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Average feeling: ${averageMood.capitalize()}',
            style: kStatsPageTitle,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: adviceBorderColor, width: 1.5),
              color: adviceBackgroundColor,
            ),
            child: FutureBuilder(
              future: adviceFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          '${snapshot.data}',
                          style: kHomePageQuoteText,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('No internet connection'),
                  );
                }
              },
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
      switch (i) {
        case 0:
          double value = feelingsAmount['angry'] != null?
              (feelingsAmount['angry']! * 100 / widget.snapshotData.length)
                  .roundToDouble(): 0;
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
          double value = feelingsAmount['sad'] != null?
              (feelingsAmount['sad']! * 100 / widget.snapshotData.length)
                  .roundToDouble():0;
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
          double value = feelingsAmount['mixed'] != null?
              (feelingsAmount['mixed']! * 100 / widget.snapshotData.length)
                  .roundToDouble():0;
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
          double value = feelingsAmount['neutral'] != null?
              (feelingsAmount['neutral']! * 100 / widget.snapshotData.length)
                  .roundToDouble():0;
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
          double value = feelingsAmount['happy'] != null?
              (feelingsAmount['happy']! * 100 / widget.snapshotData.length)
                  .roundToDouble():0;
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

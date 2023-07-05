
class FeelingsHelper{

  static Map<String, int> getFeelingsAmount(Map<String, dynamic> snapshotData) {
    Map<String, int> feelingsAmount = {};
    snapshotData.forEach((key, value) {
      if (feelingsAmount.containsKey(value['feeling'])) {
        feelingsAmount[value['feeling']] =
            feelingsAmount[value['feeling']]! + 1;
      } else {
        feelingsAmount[value['feeling']] = 1;
      }
    });
    return feelingsAmount;
  }

  static String getAverageMood(Map<String, int> feelingsAmount){
    String averageMood = '';
    int biggestMoodAmount = 0;
    feelingsAmount.forEach((key, value) {
      if(value > biggestMoodAmount){
        biggestMoodAmount = value;
        averageMood = key;
      }
    });
    return averageMood;
  }

}
import 'dart:math';

class RecordManager {
  // 获取某一天的总计
  static Future<double> getDaySum(DateTime day) async {
    return Random().nextDouble() * 100;
    ;
  }

  // 获取某月的总计
  static Future<double> getMonthSum(int month) async {
    return Random().nextDouble() * 100;
    ;
  }

  // 获取某年的总计
  static Future<double> getYearSum(int year) async {
    return Random().nextDouble() * 100;
    ;
  }

  // 获取某一天的详情
  static Future<List> getTodayDetail(DateTime day) async {
    return [];
  }
}

void aaa() {}

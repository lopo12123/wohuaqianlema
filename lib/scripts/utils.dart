import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 日期选择器
Future<DateTime?> pickDateLocal({required BuildContext context}) async {
  return await showDatePicker(
    context: context,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    initialDate: DateTime.now(),
    firstDate: DateTime.utc(2020, 1, 1),
    lastDate: DateTime.utc(2030, 1, 1),
  );
}

/// 时间选择器
Future<TimeOfDay?> pickTimeLocal({required BuildContext context}) async {
  return await showTimePicker(
    context: context,
    initialEntryMode: TimePickerEntryMode.dialOnly,
    initialTime: TimeOfDay.now(),
  );
}

// 格式化日期
String formatDate(DateTime t) {
  return '${t.year}-${t.month < 10 ? '0${t.month}' : t.month}-${t.day < 10 ? '0${t.day}' : t.day}';
}

// 格式化时间
String formatTime(TimeOfDay t) {
  return '${t.hour < 10 ? '0${t.hour}' : t.hour}:${t.minute < 10 ? '0${t.minute}' : t.minute}';
}

/// 仅在debug模式下打印
void safePrint(Object? o, {String? condition = '默认'}) {
  if (kDebugMode) {
    print("[$condition] $o");
  }
}

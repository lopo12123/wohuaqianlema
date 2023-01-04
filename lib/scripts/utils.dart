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

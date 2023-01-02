import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent.withOpacity(0.2),
        elevation: 0,
        title: const Text('全览 Overview'),
      ),
      backgroundColor: const Color.fromRGBO(0xf4, 0x43, 0x36, 0.1),
      body: TableCalendar(
        locale: 'zh_CN',
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        availableCalendarFormats: const {
          CalendarFormat.month: '周',
          CalendarFormat.twoWeeks: '月',
          CalendarFormat.week: '两周'
        },
        calendarFormat: _format,
        onFormatChanged: (format) {
          setState(() => _format = format);
        },
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        focusedDay: _focusedDay,
      ),
    );
  }
}

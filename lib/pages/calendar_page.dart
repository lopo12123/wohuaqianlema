import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with AutomaticKeepAliveClientMixin {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _format = CalendarFormat.month;

  double _todayCount = 0.0;

  // 计算当日花费和明细
  void queryTodayDetail(DateTime today) {
    // RecordManager.getDaySum(today).then((value) => _todayCount = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade100,
        elevation: 0,
        title: const Text('日历 Calendar'),
      ),
      backgroundColor: Colors.red.shade50,
      body: Column(
        children: [
          TableCalendar(
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
              queryTodayDetail(focusedDay);
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
          Container(
            height: 1,
            margin: const EdgeInsets.all(8),
            color: Colors.grey,
          ),
          Text(
            '${_selectedDay.year}年${_selectedDay.month}月${_selectedDay.day}日',
            textScaleFactor: 2,
            style: const TextStyle(fontFamily: 'Gilroy'),
          ),
          const Text('今日总计', textScaleFactor: 2),
          Text(
            _todayCount.toStringAsFixed(2),
            textScaleFactor: 2,
          ),
          const Text('今日明细', textScaleFactor: 2),
          ElevatedButton(onPressed: () {}, child: const Text('点击查看')),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

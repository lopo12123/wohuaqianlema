import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/record_form.dart';

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
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        elevation: 0,
        title: const Text(
          '快去花钱! 快去花钱! 快去花钱!',
          style: TextStyle(fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showMaterialModalBottomSheet<bool?>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (v) {
              return const RecordForm();
            },
          ).then((addNew) {
            if (addNew == true) {
              // todo
              print("刷新页面列表数据");
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.green.shade50,
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
            color: Colors.green,
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

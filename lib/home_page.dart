import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:wohuaqianlema/pages/calendar_page.dart';
import 'package:wohuaqianlema/pages/overview_page.dart';
import 'package:wohuaqianlema/pages/record_page.dart';
import 'package:wohuaqianlema/pages/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIdx = 0;
  final _tabController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SlidingClippedNavBar.colorful(
        selectedIndex: _tabIdx,
        backgroundColor: [
          Colors.blue.shade100,
          Colors.red.shade100,
          Colors.green.shade100,
          Colors.orange.shade100
        ][_tabIdx],
        onButtonPressed: (idx) {
          _tabController.jumpToPage(idx);
          setState(() => _tabIdx = idx);
        },
        barItems: [
          BarItem(
            title: '记录',
            icon: Icons.receipt_long_outlined,
            activeColor: Colors.blue.shade300,
            inactiveColor: Colors.black12,
          ),
          BarItem(
            title: '日历',
            icon: Icons.calendar_month_outlined,
            activeColor: Colors.red.shade300,
            inactiveColor: Colors.black12,
          ),
          BarItem(
            title: '统计',
            icon: Icons.insert_chart_outlined,
            activeColor: Colors.green.shade300,
            inactiveColor: Colors.black12,
          ),
          BarItem(
            title: '设置',
            icon: Icons.settings_outlined,
            activeColor: Colors.orange.shade300,
            inactiveColor: Colors.black12,
          ),
        ],
      ),
      body: PageView(
        controller: _tabController,
        onPageChanged: (idx) {
          setState(() => _tabIdx = idx);
        },
        children: const [
          RecordPage(),
          CalendarPage(),
          OverviewPage(),
          SettingPage(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:wohuaqianlema/pages/calendar_page.dart';
import 'package:wohuaqianlema/pages/overview_page.dart';
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
      bottomNavigationBar: SlidingClippedNavBar(
        selectedIndex: _tabIdx,
        activeColor: Colors.green.shade400,
        inactiveColor: Colors.green.shade100,
        onButtonPressed: (idx) {
          _tabController.jumpToPage(idx);
          setState(() => _tabIdx = idx);
        },
        barItems: [
          BarItem(title: '记录', icon: Icons.calendar_month_outlined),
          BarItem(title: '统计', icon: Icons.insert_chart_outlined),
          BarItem(title: '设置', icon: Icons.settings_outlined),
        ],
      ),
      body: PageView(
        controller: _tabController,
        onPageChanged: (idx) {
          setState(() => _tabIdx = idx);
        },
        children: const [
          CalendarPage(),
          OverviewPage(),
          SettingPage(),
        ],
      ),
    );
  }
}

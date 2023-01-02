import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:wohuaqianlema/pages/calendar_page.dart';
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
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        showElevation: false,
        selectedIndex: _tabIdx,
        backgroundColor:
            [Colors.blue, Colors.red, Colors.orange][_tabIdx].withOpacity(0.2),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.create),
            title: const Text('记录'),
            textAlign: TextAlign.center,
            activeColor: Colors.blueAccent,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.calendar_month_outlined),
            title: const Text('全览'),
            textAlign: TextAlign.center,
            activeColor: Colors.redAccent,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('设置'),
            textAlign: TextAlign.center,
            activeColor: Colors.orange,
          ),
        ],
        onItemSelected: (idx) {
          _tabController.jumpToPage(idx);
          setState(() => _tabIdx = idx);
        },
      ),
      body: PageView(
        controller: _tabController,
        onPageChanged: (idx) {
          setState(() => _tabIdx = idx);
        },
        children: const [RecordPage(), CalendarPage(), SettingPage()],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wohuaqianlema/scripts/db.dart';
import '../scripts/utils.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('初始化数据库'),
              onPressed: () {
                DBController.init();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('查询全部数据表'),
              onPressed: () {
                DBController.testQueryTableList();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('新增标签 123'),
              onPressed: () {
                DBController.addTag('123 456');
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('查询全部标签'),
              onPressed: () {
                DBController.queryTag().then((value) => safePrint(value, condition: '测试:查询全部标签'));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('查询标签 id=1'),
              onPressed: () {
                DBController.queryTag(tagId: 1).then((value) => safePrint(value, condition: '测试:查询标签 id=1'));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('查询标签 name like 12'),
              onPressed: () {
                DBController.queryTag(nameLike: '12').then((value) => safePrint(value, condition: '测试:查询标签 name like 12'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../scripts/record_manager.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0xff, 0x98, 0x00, 0.1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('点击查询数据表'),
              onPressed: () {
                RecordManager.getValidTableNames()
                    .then((tables) => print('tables: $tables'));
              },
            ),
            ElevatedButton(
              child: Text('点击初始化数据库'),
              onPressed: () {
                RecordManager.init().then((tables) => print('[测试] 初始化完成'));
              },
            ),
            ElevatedButton(
              child: Text('点击关闭数据库'),
              onPressed: () {
                RecordManager.dispose().then((v) => print('[测试] 关闭数据库完成'));
              },
            ),
            ElevatedButton(
              child: Text('点击清空数据库'),
              onPressed: () {
                RecordManager.clear()
                    .then((count) => print('[测试] 清空数据库完成, 删除条目数: $count'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
              child: Text('查询全部数据表'),
              onPressed: () {
                DBOperator.testQueryTableList();
              },
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            //   child: Text('点击查询数据表'),
            //   onPressed: () {
            //     RecordManager.getValidTableNames()
            //         .then((tables) => print('tables: $tables'));
            //   },
            // ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            //   child: Text('点击关闭数据库'),
            //   onPressed: () {
            //     RecordManager.dispose().then((v) => print('[测试] 关闭数据库完成'));
            //   },
            // ),
            // ElevatedButton(
            //   child: Text('点击查询全部数据'),
            //   onPressed: () {
            //     RecordManager.query();
            //   },
            // ),
            // ElevatedButton(
            //   child: Text('点击删除目标数据'),
            //   onPressed: () {
            //     RecordManager.delete(1).then((value) => print("删除测试: $value"));
            //   },
            // ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('点击选择日期'),
              onPressed: () {
                pickDateLocal(context: context).then((value) {
                  print('picked: $value');
                  if (value != null) print('picked: ${formatDate(value)}');
                });
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('点击选择时间'),
              onPressed: () {
                pickTimeLocal(context: context).then((value) {
                  print('picked: $value');
                  if (value != null) print('picked: ${formatTime(value)}');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

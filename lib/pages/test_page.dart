import 'package:flutter/material.dart';
import 'package:wohuaqianlema/scripts/db.dart';
import 'package:wohuaqianlema/scripts/range.dart';
import '../scripts/utils.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: ListView(
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('查询自增表'),
              onPressed: () {
                DBController.testQuerySeq();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('查询安卓元数据表'),
              onPressed: () {
                DBController.testQueryMeta();
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
                DBController.queryTag()
                    .then((value) => safePrint(value, condition: '测试:查询全部标签'));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('查询标签 id=1'),
              onPressed: () {
                DBController.queryTag(tagId: 1).then(
                    (value) => safePrint(value, condition: '测试:查询标签 id=1'));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('查询标签 name like 12'),
              onPressed: () {
                DBController.queryTag(nameLike: '12').then((value) =>
                    safePrint(value, condition: '测试:查询标签 name like 12'));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('删除标签 id=1'),
              onPressed: () {
                DBController.deleteTag(1).then(
                    (value) => safePrint(value, condition: '测试:删除标签 id=1'));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('编辑标签 id=1'),
              onPressed: () {
                DBController.editTag(2, 'edited').then(
                    (value) => safePrint(value, condition: '测试:编辑标签 id=1'));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('清空标签'),
              onPressed: () {
                DBController.clearAllTag()
                    .then((value) => safePrint(value, condition: '测试:清空标签'));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              child: Text('新增记录'),
              onPressed: () {
                safePrint('请使用完整表单测试', condition: '测试:新增记录');
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              child: Text('查询全部记录'),
              onPressed: () {
                DBController.queryRecord()
                    .then((value) => safePrint(value, condition: '测试:新增记录'));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              child: Text('条件查询记录'),
              onPressed: () {
                DBController.queryRecord(
                  isIncome: true,
                  amountRange: RangeNumber(min: 0, max: 9999),
                  descLike: '测试',
                  dateRange:
                      RangeDate(min: DateTime(2010), max: DateTime(2024)),
                  tagId: 1,
                ).then((value) => safePrint(value, condition: '测试:条件查询记录'));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              child: Text('删除记录'),
              onPressed: () {
                DBController.deleteRecord(1)
                    .then((value) => safePrint(value, condition: '测试:删除记录'));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('清空记录'),
              onPressed: () {
                DBController.clearAllRecord()
                    .then((value) => safePrint(value, condition: '测试:清空记录'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RecordForm extends StatefulWidget {
  const RecordForm({super.key});

  @override
  State<StatefulWidget> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  // 是否是收入
  bool isIncome = false;

  // 金额
  double amount = 0.0;

  // 日期
  bool bb = false;

  // 日期
  String method = '';

  // 日期
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
          bottom: Radius.zero,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            Switch(
              value: isIncome,
              onChanged: (v) {
                setState(() {
                  isIncome = v;
                });
              },
            ),
            TextField(
              maxLength: 50,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '备注',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            Text('2222'),
            Text(isIncome ? 'true' : 'false'),
          ],
        ),
      ),
    );
  }
}

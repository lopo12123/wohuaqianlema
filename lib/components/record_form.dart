import 'package:animated_button_bar/animated_button_bar.dart';
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

  // 方式
  String method = '';

  // 描述
  var _descController = TextEditingController();

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
            // 入/出 -- radio group
            AnimatedButtonBar(
              radius: 8,
              innerVerticalPadding: 16,
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade100,
              borderColor: Colors.blue,
              children: [
                ButtonBarEntry(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.indeterminate_check_box_outlined,
                        color: isIncome ? Colors.blue.shade100 : Colors.blue,
                      ),
                      Text(
                        '支出',
                        style: TextStyle(
                          color: isIncome ? Colors.blue.shade100 : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      isIncome = false;
                    });
                  },
                ),
                ButtonBarEntry(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_box_outlined,
                        color: isIncome ? Colors.blue : Colors.blue.shade100,
                      ),
                      Text(
                        '收入',
                        style: TextStyle(
                          color: isIncome ? Colors.blue : Colors.blue.shade100,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      isIncome = true;
                    });
                  },
                ),
              ],
            ),
            // 备注 - desc
            TextField(
              controller: _descController,
              maxLength: 50,
              keyboardType: TextInputType.number,
              onChanged: (s) {
                print(s);
              },
              decoration: InputDecoration(
                labelText: '备注',
                hintText: '请输入备注(可选)',
                suffixIcon: IconButton(
                  onPressed: () => _descController.clear(),
                  icon: const Icon(Icons.clear),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            Text(isIncome ? 'true' : 'false'),
          ],
        ),
      ),
    );
  }
}

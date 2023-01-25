import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wohuaqianlema/scripts/record_manager.dart';

class RecordForm extends StatefulWidget {
  const RecordForm({super.key});

  @override
  State<StatefulWidget> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  // 是否是收入
  bool isIncome = false;

  // 金额
  final _amountController = TextEditingController();

  // 描述
  final _descController = TextEditingController();

  // 方式
  // String method = '';

  // 日期
  // DateTime date = DateTime.now();

  // 动态计算底部外边距
  int _activeInputIdx = 0;

  double get _marginBottom {
    double currBottomInset = MediaQuery.of(context).viewInsets.bottom;

    if (currBottomInset == 0) {
      return 0;
    } else {
      return 130 + _activeInputIdx * 70;
    }
  }

  // 计算当前表单的数据
  void submitForm(BuildContext ctx) async {
    double? amount = double.tryParse(_amountController.text.trim());

    if (amount == null) {
      BotToast.showSimpleNotification(title: '请输入正确的金额!');
    } else {
      bool ifInsertOk = await RecordManager.insert(
        isIncome: isIncome,
        amount: amount,
        desc: _descController.text.trim(),
      );

      BotToast.showSimpleNotification(title: ifInsertOk ? '新增成功!' : '新增失败!');

      if (ifInsertOk) Navigator.of(ctx).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 404,
      margin: EdgeInsets.only(bottom: _marginBottom),
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
              innerVerticalPadding: 12,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
            // 金额 - amount - (paddingBottom: 130px)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onTap: () => setState(() {
                  _activeInputIdx = 0;
                }),
                decoration: const InputDecoration(
                  labelText: '金额',
                  hintText: '请输入金额(暂不支持小数)',
                  contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 12),
                  suffixText: '元',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            // 备注 - desc - (paddingBottom: 200px)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: TextField(
                controller: _descController,
                maxLength: 50,
                keyboardType: TextInputType.text,
                onTap: () => setState(() {
                  _activeInputIdx = 1;
                }),
                decoration: InputDecoration(
                  labelText: '备注',
                  hintText: '请输入备注(可选)',
                  contentPadding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                  suffixIcon: IconButton(
                    onPressed: () => _descController.clear(),
                    icon: const Icon(Icons.clear),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            // 确认 - (height: 70px)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: SizedBox(
                height: 50,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: ElevatedButton.icon(
                    onPressed: () => submitForm(context),
                    icon: const Icon(Icons.add_task),
                    label: const Text('确认'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

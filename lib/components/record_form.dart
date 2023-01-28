import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wohuaqianlema/scripts/db.dart';
import 'package:wohuaqianlema/scripts/utils.dart';

class RecordForm extends StatefulWidget {
  const RecordForm({super.key});

  @override
  State<StatefulWidget> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  _RecordFormState() {
    DBController.queryTag().then((tagList) {
      setState(() {
        validTagList = tagList;
      });
      safePrint(tagList, condition: '可用Tag列表');
    });
  }

  // 下拉选择列表 Array<{id: number, name: string}>
  List<Map<String, Object?>> validTagList = [];

  List<DropdownMenuItem<int>> get dropdownList {
    List<DropdownMenuItem<int>> tagList = validTagList
        .map((tagInfo) => DropdownMenuItem(
              value: tagInfo['id'] as int,
              child: Text(
                tagInfo['name'].toString(),
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ))
        .toList();

    tagList.insert(
      0,
      const DropdownMenuItem(
        value: 0,
        child: Text(
          '选择标签(可选)',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );

    return tagList;
  }

  // 是否是收入
  bool isIncome = false;

  // 记录时间
  DateTime recordTime = DateTime.now();

  // 标签id
  int tagId = 0;

  // 标签名
  String tagName = '选择标签(可选)';

  // 金额
  final _amountController = TextEditingController();

  // 描述
  final _descController = TextEditingController();

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
    String amountStr = _amountController.text.trim();
    if (!RegExp(r'^(0|[1-9])[0-9]*(\.[0-9]+)$').hasMatch(amountStr)) {
      BotToast.showSimpleNotification(title: '请输入正确的金额!');
    } else {
      double? amount = double.tryParse(amountStr);
      if (amount == null) {
        BotToast.showSimpleNotification(title: '请输入正确的金额!');
      } else {
        // bool ifInsertOk = await RecordManager.insert(
        //   isIncome: isIncome,
        //   amount: amount,
        //   desc: _descController.text.trim(),
        // );

        // BotToast.showSimpleNotification(title: ifInsertOk ? '新增成功!' : '新增失败!');

        // if (ifInsertOk) Navigator.of(ctx).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550, // 50 + 10 * 2 (单项高度)
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
              foregroundColor: Colors.green.shade100,
              borderColor: Colors.green,
              children: [
                ButtonBarEntry(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sentiment_satisfied_outlined,
                        color: isIncome ? Colors.green.shade100 : Colors.green,
                      ),
                      Text(
                        '支出',
                        style: TextStyle(
                          color:
                              isIncome ? Colors.green.shade100 : Colors.green,
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
                        Icons.sentiment_dissatisfied_outlined,
                        color: isIncome ? Colors.green : Colors.green.shade100,
                      ),
                      Text(
                        '收入',
                        style: TextStyle(
                          color:
                              isIncome ? Colors.green : Colors.green.shade100,
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
            // 时间
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: SizedBox(
                height: 50,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                    ),
                    onPressed: () async {
                      try {
                        DateTime? date = await pickDateLocal(context: context);
                        if (date == null) {
                          return;
                        } else {
                          TimeOfDay? time =
                              await pickTimeLocal(context: context);
                          if (time == null) {
                            return;
                          }
                          date = date.add(Duration(
                            hours: time.hour,
                            minutes: time.minute,
                          ));

                          setState(() {
                            recordTime = date!;
                          });
                        }
                      } catch (err) {
                        safePrint(err, condition: '选择时间');
                      }
                    },
                    icon: const Icon(
                      Icons.schedule_outlined,
                      color: Colors.green,
                    ),
                    label: Text(
                      '选择时间 (${formatDateTime(recordTime)})',
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ),
            ),
            // 标签
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: SizedBox(
                height: 50,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    decoration: BoxDecoration(
                      color: dropdownList.length > 1
                          ? Colors.transparent
                          : Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      border: const Border.fromBorderSide(
                        BorderSide(color: Colors.green),
                      ),
                    ),
                    child: DropdownButton(
                      hint: const Text('选择标签(可选)'),
                      disabledHint: const Text(
                        '暂无可用标签, 请先在设置页创建',
                        style: TextStyle(color: Colors.grey),
                      ),
                      style: const TextStyle(color: Colors.green),
                      icon: const Icon(
                        Icons.sell_outlined,
                        color: Colors.green,
                      ),
                      isExpanded: true,
                      underline: Container(color: Colors.transparent),
                      items: dropdownList.length > 1 ? dropdownList : null,
                      value: dropdownList.length > 1 ? tagId : null,
                      onChanged: (selectedTagId) {
                        setState(() {
                          if (selectedTagId != null) tagId = selectedTagId;
                        });
                        safePrint(selectedTagId, condition: 'dropdown');
                      },
                    ),
                  ),
                ),
              ),
            ),
            // 金额 - amount - (paddingBottom: 130px)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // 全串匹配 r'^(0|[1-9])[0-9]*(\.[0-9]+)$'
                  FilteringTextInputFormatter.allow(RegExp(r'[.0-9]')),
                ],
                style: const TextStyle(color: Colors.green),
                onTap: () => setState(() {
                  _activeInputIdx = 0;
                }),
                decoration: const InputDecoration(
                  labelText: '金额',
                  hintText: '请输入金额',
                  contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 12),
                  suffixIcon: Icon(
                    Icons.currency_yuan_outlined,
                    color: Colors.green,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
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
                style: const TextStyle(color: Colors.green),
                onTap: () => setState(() {
                  _activeInputIdx = 1;
                }),
                decoration: InputDecoration(
                  labelText: '备注(可选)',
                  hintText: '请输入备注(可选)',
                  contentPadding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                  suffixIcon: IconButton(
                    onPressed: () => _descController.clear(),
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.green,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
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
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
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

import 'package:animated_radial_menu/animated_radial_menu.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<StatefulWidget> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  showMaterialModalBottomSheet(
                      context: context,
                      builder: (v) {
                        // todo 记录详细内容
                        return Container(
                          height: 300,
                          child: Text('输入新建记录内容'),
                        );
                      });
                },
                icon: Icon(Icons.edit_outlined),
                label: Text('记个账!'),
              ),
            ],
          ),
        ));
  }
}

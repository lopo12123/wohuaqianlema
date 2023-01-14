import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wohuaqianlema/components/record_form.dart';

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
                      backgroundColor: Colors.transparent,
                      builder: (v) {
                        // todo 记录详细内容
                        return const RecordForm();
                      });
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text('记个账!'),
              ),
            ],
          ),
        ));
  }
}
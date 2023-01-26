import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wohuaqianlema/components/record_form.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<StatefulWidget> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange.shade50,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SwipeButton.expand(
                  width: 250,
                  thumb: const Icon(
                    Icons.double_arrow_rounded,
                    color: Colors.white,
                  ),
                  activeThumbColor: Colors.blue,
                  activeTrackColor: Colors.blue.shade100,
                  child: const Text(
                    'Slide to record.',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Gilroy',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  onSwipe: () {
                    showMaterialModalBottomSheet<bool?>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (v) {
                        return const RecordForm();
                      },
                    ).then((addNew) {
                      if (addNew == true) {
                        // todo
                        print("刷新页面列表数据");
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ));
  }
}

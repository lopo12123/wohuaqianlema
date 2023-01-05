import 'package:animated_radial_menu/animated_radial_menu.dart';
import 'package:flutter/material.dart';

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
              RadialMenu(children: [
                RadialButton(icon: Icon(Icons.add), onPress: () {}),
                RadialButton(icon: Icon(Icons.remove), onPress: () {}),
              ]),
            ],
          ),
        ));
  }
}

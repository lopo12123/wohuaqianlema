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
        backgroundColor: Color.fromRGBO(0x21, 0x96, 0xf3, 0.1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.large(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return SimpleDialog(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                          children: [
                            ElevatedButton.icon(
                              label: const Text('收入'),
                              icon: const Icon(Icons.add),
                              onPressed: () => null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                // fixedSize: const Size.fromHeight(50),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => null,
                              label: const Text('支出'),
                              icon: const Icon(Icons.remove),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                // fixedSize: const Size.fromHeight(50),
                              ),
                            ),
                          ],
                        );
                      });
                },
                backgroundColor: Colors.blueAccent,
                child: const Icon(Icons.create),
              ),
            ],
          ),
        ));
  }
}

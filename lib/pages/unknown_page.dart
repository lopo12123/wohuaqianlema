import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_amber,
            size: 32,
            color: Colors.red,
          ),
          const Text(
            '404 NotFound!',
            textScaleFactor: 1.5,
          ),
          ElevatedButton(
            child: const Text('返回上页'),
            onPressed: () {
              Get.back();
            },
          ),
          ElevatedButton(
            child: const Text('返回首页'),
            onPressed: () {
              Get.offAllNamed('/welcome');
            },
          ),
        ],
      )),
    );
  }
}

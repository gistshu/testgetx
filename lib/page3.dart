import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgetx/main2.dart';

class Page3 extends StatelessWidget {
  //這裡若有Model，也需要import
  final Controller ctrl = Get.find();

  Page3({super.key});
  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Page3 - Show params from Page1"),
        ),
        body: Center(
            child: Column(
          children: [
            Text(
              "count - ${ctrl.count}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "testModel - ${ctrl.tm.value?.sa} - ${ctrl.tm.value?.sb}",
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
            Text(
              "count2 - ${ctrl.count2}",
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
          ],
        )));
  }
}

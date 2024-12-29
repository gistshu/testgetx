/*
  GetX obs State 變更測試：類似changeprovider進行局部refresh，不需像setState一樣全畫面refreash.
  其他Page可以直接用GetxController 定義的參數Get.find()，不需要傳值過去。
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgetx/page3.dart';

void main() {
  runApp(GetMaterialApp(home: MyApp()));
}

class TestModel {
  String sa = "";
  String sb = "";

  TestModel(String a, String b) {
    sa = a;
    sb = b;
  }
}

class Controller extends GetxController {
  var count = 0.obs;
  var count2 = 99.obs;
  var tm = Rxn<TestModel>();
  void increment() {
    count++;
  }

  void increment2() {
    count2--;
  }

  void setmodel(RxInt cnt1, RxInt cnt2) {
    tm.value = TestModel(cnt1.toString(), cnt2.toString());
  }
}

class MyApp extends StatelessWidget {
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GetX Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  'clicks: ${controller.count}',
                )),
            ElevatedButton(
              child: const Text('Next Route'),
              onPressed: () {
                Get.to(() => Second());
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
            ),
            Text(
              'count2 clicks: ${controller.count2}',
              style: const TextStyle(color: Colors.red, fontSize: 20),
            ),
            Obx(
              () => Text(
                'count2 clicks obs: ${controller.count2}',
                style: const TextStyle(color: Colors.green, fontSize: 20),
              ),
            ),
            ElevatedButton(
              child: const Text('count2 clicks --'),
              onPressed: () {
                //Get.to(Second());
                controller.increment2();
              },
            ),
            const Divider(
              thickness: 3,
            ),
            Obx(
              () => Text(
                'testModel obs: ${controller.tm.value?.sa} ${controller.tm.value?.sb}',
                style: const TextStyle(color: Colors.green, fontSize: 20),
              ),
            ),
            ElevatedButton(
              child: const Text('assign count to model'),
              onPressed: () {
                //Get.to(Second());
                controller.setmodel(controller.count, controller.count2);
              },
            ),
            const Divider(
              thickness: 3,
            ),
            ElevatedButton(
              child: const Text('To Page3 Route'),
              onPressed: () {
                Get.to(() => Page3());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          controller.increment();
        },
      ),
    );
  }
}

class Second extends StatelessWidget {
  //直接取得有納入obs listening的參數
  final Controller ctrl = Get.find();

  Second({super.key});
  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Page2 - Show params from Page1"),
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

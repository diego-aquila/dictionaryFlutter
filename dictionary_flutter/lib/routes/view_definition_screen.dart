import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/randomC.dart';

class ShowWordsPage extends StatelessWidget {
  ShowWordsPage({super.key});

  final RandomC randomC = Get.put(RandomC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Definition Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Column(
          children: [
            for (var item in randomC.responseSave["results"] ?? [])
              Text(item["definition"]),
            printResponse(),
          ],
        ),
      ),
    );
  }

  // final List<String> definitions = randomC.responseSave["results"]
  //     .map<String>((result) => result["definition"] as String)
  //     .toList();

  printResponse() {
    print(randomC.responseSave);

    return const Text("INICIO");
  }
}

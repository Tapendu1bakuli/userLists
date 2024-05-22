import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';

class TaskViewScreen extends StatelessWidget {
  const TaskViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.ROOT);
                },
                child: const Text("Task-1")),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.TASK2);
                },
                child: const Text("Task-2")),
          ],
        ),
      ),
    );
  }
}

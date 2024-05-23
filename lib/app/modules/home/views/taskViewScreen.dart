import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users/utils/text_utils/app_strings.dart';

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
                child: Text(AppStrings.task1.tr)),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.TASK2);
                },
                child: Text(AppStrings.task2.tr)),
          ],
        ),
      ),
    );
  }
}

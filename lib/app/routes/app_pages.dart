


import 'package:get/get.dart';
import 'package:users/app/modules/home/binding/taskTwoBinding.dart';
import 'package:users/app/modules/home/binding/userListViewBinding.dart';
import 'package:users/app/modules/home/views/task2View.dart';
import 'package:users/app/modules/home/views/taskViewScreen.dart';
import 'package:users/app/modules/home/views/userListViewScreen.dart';
import 'package:users/app/routes/routes.dart';

class Theme1AppPages {
  static const INITIAL = Routes.TASK;
  static final routes = [
    GetPage(
        name: Routes.TASK,
        page: () => const TaskViewScreen(),
       ),
    GetPage(
      name: Routes.ROOT,
      page: () => const UserListViewScreen(),
      binding: Userlistviewbinding(),
    ),
    GetPage(
      name: Routes.TASK2,
      page: () => const TaskTwoViewScreen(),
      binding: TaskTwoBinding(),
    ),
  ];
}
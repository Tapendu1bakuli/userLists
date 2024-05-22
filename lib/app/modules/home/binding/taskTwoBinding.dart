import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:users/app/modules/home/controller/taskTwoController.dart';

class TaskTwoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TaskTwocontroller>(
            ()=> TaskTwocontroller()
    );
  }

}
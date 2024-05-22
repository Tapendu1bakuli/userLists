import 'package:get/get.dart';
import 'package:users/app/modules/home/controller/userListViewController.dart';

class Userlistviewbinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserListViewController>(
        ()=> UserListViewController()
    );
  }

}
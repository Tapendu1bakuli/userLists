


import 'package:get/get.dart';
import 'package:users/app/modules/home/binding/userListViewBinding.dart';
import 'package:users/app/modules/home/views/userListViewScreen.dart';
import 'package:users/app/routes/routes.dart';

class Theme1AppPages {
  static const INITIAL = Routes.ROOT;
  static final routes = [
    GetPage(
        name: Routes.ROOT,
        page: () => const UserListViewScreen(),
      binding: Userlistviewbinding(),
       ),

  ];
}
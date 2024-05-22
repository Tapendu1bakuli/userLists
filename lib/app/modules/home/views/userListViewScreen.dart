import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:users/device_manager/screen_constants.dart';
import 'package:users/utils/colors/app_colors.dart';
import 'package:users/utils/text_utils/app_strings.dart';

import '../../../../utils/TextStyles.dart';
import '../controller/userListViewController.dart';

class UserListViewScreen extends GetView<UserListViewController> {
  const UserListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<UserListViewController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 200), () async {
        await controller.fetchUsers();
      });
    }, builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.userLists,
          style: TextStyles.appbarTitleStyleBold
              .copyWith(color: CustomColor.bluishWhite),
        ),
        centerTitle: true,
        backgroundColor: CustomColor.alertDialogButton,
      ),
      body: ListView(
        children: [
          Card(
            elevation: 10,
            child: Center(child: Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightFifteen),
              child: const Text("ABCD"),
            )),
          )
        ],
      ),
    );
    });
  }
}

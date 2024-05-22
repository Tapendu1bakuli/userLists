import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:users/app/modules/home/views/albumsViewScreen.dart';
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
      body: controller.isLoading.value?const Center(child: CircularProgressIndicator(),):Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthTen),
        child: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.userList.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: (){
                    Get.to(const AlbumViewScreen(),arguments: [controller.userList[i].id]);
                  },
                  child: Card(
                    elevation: 10,
                    child: Center(child: Padding(
                      padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightFifteen),
                      child: Text(controller.userList[i].name ?? ""),
                    )),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: (){showAlertDialogForLogOut("Add user");}, child:const Text("Add user")),
                ElevatedButton(onPressed: (){showAlertDialogForLogOut("Edit existing user details?");}, child:const Text("Edit user details")),
                ElevatedButton(onPressed: (){showAlertDialogForLogOut("Delete user");}, child:const Text("Delete user")),
              ],
            )
          ],
        ),
      ),
    );
    });
  }
  showAlertDialogForLogOut(String title) {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Builder(
          builder: (context) {
            return Container(
              height: ScreenConstant.screenHeightThird,
              width: MediaQuery.of(context).size.width-80,
              padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightTen,horizontal: ScreenConstant.defaultWidthThirty),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: ScreenConstant.defaultHeightFifteen,),
                  Text(title,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 20,fontWeight: FontWeight.w500),),
                  Container(height: ScreenConstant.defaultHeightFifteen,),
                  Text("Are you sure?",style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 18,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                  Container(height: ScreenConstant.defaultHeightTen,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(onPressed: (){Get.back();},child: const Text("Cancel"),),
                      ElevatedButton(onPressed: (){Get.back();},child: const Text("Confirm"),)
                    ],
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

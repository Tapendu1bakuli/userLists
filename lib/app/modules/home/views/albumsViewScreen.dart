import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users/app/modules/home/views/photosViewScreen.dart';
import 'package:users/utils/text_utils/app_strings.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../controller/userListViewController.dart';

class AlbumViewScreen extends GetView<UserListViewController> {
  const AlbumViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return GetX<UserListViewController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 200), () async {
        await controller.fetchAlbum(data[0]);
      });
    }, builder: (_) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppStrings.albumViewScreen.tr),
        ),
        body: controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.albumList.length,
                    itemBuilder: (context, i) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: InkWell(
                              onTap: () {
                                Get.to(const PhotosViewScreen(),
                                    arguments: [controller.albumList[i].id]);
                              },
                              child: Card(
                                elevation: 10,
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          ScreenConstant.defaultHeightFifteen),
                                  child:
                                      Text(controller.albumList[i].title ?? ""),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: ElevatedButton(
                                  onPressed: () {
                                    showAlertDialogForDelete(
                                        AppStrings.deleteAlbum.tr, i);
                                  },
                                  child: Text(AppStrings.deleteAlbum.tr))),
                        ],
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            showAlertDialogForLogOut(AppStrings.editAlbum.tr);
                          },
                          child: Text(AppStrings.addNewAlbum.tr)),
                      ElevatedButton(
                          onPressed: () {
                            showAlertDialogForLogOut(AppStrings.editAlbum.tr);
                          },
                          child: Text(AppStrings.editAlbum.tr)),
                    ],
                  ),
                  Container(
                    height: ScreenConstant.defaultHeightFifteen,
                  ),
                  controller.temporaryDocImagePath.value.isEmpty
                      ? const Offstage()
                      : Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: ScreenConstant.defaultHeightTwoHundred,
                              width: ScreenConstant.defaultWidthOneEighty,
                              child: Image.file(
                                fit: BoxFit.fill,
                                File(controller.temporaryDocImagePath.value),
                              ),
                            ),
                          ),
                        )
                ],
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
              width: MediaQuery.of(context).size.width - 80,
              padding: EdgeInsets.symmetric(
                  vertical: ScreenConstant.defaultHeightTen,
                  horizontal: ScreenConstant.defaultWidthThirty),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: ScreenConstant.defaultHeightFifteen,
                  ),
                  Text(
                    title,
                    style: TextStyles.homeTabSecondCardSubTitleStyleBold
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: ScreenConstant.defaultHeightFifteen,
                  ),
                  Text(
                    AppStrings.areYouSure.tr,
                    style: TextStyles.homeTabSecondCardSubTitleStyleBold
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: ScreenConstant.defaultHeightTen,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(AppStrings.cancel.tr),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(AppStrings.confirm.tr),
                      )
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

  showAlertDialogForDelete(String title, int id) {
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
              width: MediaQuery.of(context).size.width - 80,
              padding: EdgeInsets.symmetric(
                  vertical: ScreenConstant.defaultHeightTen,
                  horizontal: ScreenConstant.defaultWidthThirty),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: ScreenConstant.defaultHeightFifteen,
                  ),
                  Text(
                    title,
                    style: TextStyles.homeTabSecondCardSubTitleStyleBold
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: ScreenConstant.defaultHeightFifteen,
                  ),
                  Text(
                    AppStrings.areYouSure.tr,
                    style: TextStyles.homeTabSecondCardSubTitleStyleBold
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: ScreenConstant.defaultHeightTen,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(AppStrings.cancel.tr),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          controller.albumList.removeAt(id);
                        },
                        child: Text(AppStrings.confirm.tr),
                      )
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

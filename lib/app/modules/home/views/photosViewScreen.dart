import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users/app/modules/home/controller/userListViewController.dart';
import 'package:users/utils/text_utils/app_strings.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/utils.dart';

class PhotosViewScreen extends GetView<UserListViewController> {
  const PhotosViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return GetX<UserListViewController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 200), () async {
        await controller.fetchPhotos(data[0]);
      });
    }, builder: (_) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(AppStrings.photosView.tr),
        ),
        body: controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenConstant.defaultWidthTen),
                child: ListView(
                  children: [
                    ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.photosList.length,
                      itemBuilder: (context, i) {
                        return SizedBox(
                            height: ScreenConstant.defaultHeightEightyTwo,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: Image.network(
                                        controller.photosList[i].thumbnailUrl ??
                                            "",fit: BoxFit.fill,)),
                                Expanded(
                                    flex: 4,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          showDialogForChooseImage(AppStrings.delete.tr, i);
                                        },
                                        child: Text(AppStrings.deleteAlbum.tr))),
                              ],
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          height: ScreenConstant.defaultHeightFifteen,
                        );
                      },
                    ),
                    Container(
                      height: ScreenConstant.defaultHeightTen,
                    ),
                    controller.temporaryDocImagePath.value.isEmpty
                        ? ElevatedButton(
                            onPressed: () async {
                              await modalBottomSheetMenuForCamera(context,
                                  (XFile? selectedImage) {
                                controller.temporaryDocImageName.value =
                                    selectedImage!.name;
                                controller.temporaryDocImagePath.value =
                                    selectedImage!.path;
                              });
                            },
                            child: Text(AppStrings.addNewAlbum.tr))
                        : ElevatedButton(
                            onPressed: () {
                              controller.temporaryDocImagePath.value = "";
                            },
                            child: Text(AppStrings.delete.tr)),
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
                        child: Text( AppStrings.cancel.tr),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text( AppStrings.confirm.tr),
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

  showDialogForChooseImage(String title, int id) {
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
                        child: Text( AppStrings.cancel.tr),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          controller.photosList.removeAt(id);
                        },
                        child:  Text( AppStrings.confirm.tr),
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

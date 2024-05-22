import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:users/app/modules/home/views/photosViewScreen.dart';

import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/utils.dart';
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
    title: const Text("Album view screen"),
    ),
      body:  controller.isLoading.value?const Center(child: CircularProgressIndicator(),):ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.albumList.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: (){
                  Get.to(const PhotosViewScreen(),arguments: [controller.albumList[i].id]);
                },
                child: Card(
                  elevation: 10,
                  child: Center(child: Padding(
                    padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightFifteen),
                    child: Text(controller.albumList[i].title ?? ""),
                  )),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: ()async{
                    await modalBottomSheetMenuForCamera(context,(XFile? selectedImage){
                      controller.temporaryDocImageName.value = selectedImage!.name;
                      controller.temporaryDocImagePath.value = selectedImage!.path;
                    });
              }, child:const Text("Add new album")),
              ElevatedButton(onPressed: (){showAlertDialogForLogOut("Edit album");}, child:const Text("Edit album")),
              ElevatedButton(onPressed: (){showAlertDialogForLogOut("Delete album");}, child:const Text("Delete album")),
            ],
          ),
          Container(height: ScreenConstant.defaultHeightFifteen,),
        controller
            .temporaryDocImagePath
            .value.isEmpty?const Offstage():Center(
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(20),
              child: Container(
                height: ScreenConstant
                    .defaultHeightTwoHundred,
                width: ScreenConstant
                    .defaultWidthOneEighty,
                child: Image.file(
                  fit: BoxFit.fill,
                  File(controller
                      .temporaryDocImagePath
                      .value),
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

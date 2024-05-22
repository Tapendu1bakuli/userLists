import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users/app/modules/home/controller/taskTwoController.dart';
import 'package:users/device_manager/screen_constants.dart';
import 'package:users/utils/utils.dart';

import '../../../../utils/TextStyles.dart';

class TaskTwoViewScreen extends GetView<TaskTwocontroller> {
  const TaskTwoViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.white10,
        centerTitle: true,
        title: const Text("Task 2 view"),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthTwenty),
        child: ListView(
          children: [
            Text("Select Collection Date & Time",
                style: TextStyles.textStyleRegular),
            Container(
              height: ScreenConstant.defaultHeightFifteen,
            ),
            Obx(
              () => SizedBox(
                height: ScreenConstant.defaultHeightSixty,
                child: Center(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.dateList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          controller.isCollectionSelected.value = true;
                          print(controller.index1.value);
                          print(controller.index2.value);
                          controller.index1.value = index;

                          print(controller.index1.value);
                          print(controller.index2.value);
                            controller.dateList
                                .forEach((element) => element.isColoured = false);
                            debugPrint("index:$index");
                            controller.dateList[index].isColoured =
                            !controller.dateList[index].isColoured!;
                            controller.dateList.refresh();
                            controller.dateList[index].ontap!();


                        },
                        child: Container(
                          height: ScreenConstant.defaultHeightNinety,
                          width: ScreenConstant.defaultWidthNinetyEight,
                          decoration: BoxDecoration(
                              color:
                                  controller.dateList[index].isColoured ?? false
                                      ? Colors.blueAccent
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0,
                                    offset: Offset(0.5, 3)),
                              ]),
                          margin: EdgeInsets.symmetric(
                              vertical: ScreenConstant.defaultHeightFour,
                              horizontal: ScreenConstant.defaultWidthTen),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.dateList[index].title ?? "",
                                style: TextStyles.hintTextStyle.copyWith(
                                    color:
                                        controller.dateList[index].isColoured ??
                                                false
                                            ? Colors.white
                                            : Colors.black),
                              ),
                              Text(controller.dates[index],
                                  style: TextStyles.hintTextStyle.copyWith(
                                      color: controller
                                                  .dateList[index].isColoured ??
                                              false
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 10,
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: ScreenConstant.defaultHeightFifteen,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Morning", style: TextStyles.textStyleRegular.copyWith(fontSize:16)),
                      Container(
                        height: ScreenConstant.defaultHeightFifteen,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),

                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: "Select date",
                          contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 10)
                        ),
                        isExpanded: true,
                        iconSize: 0.0,
                        style: TextStyle(color: Colors.black54,height: 0.1),
                        items: ['9.00am-10.0am', '10.00am-11.00am', '11.00am-12.00am'].map(
                              (val) {
                            return DropdownMenuItem<String>(
                              onTap: (){
                                print(controller.selectedLocation?.value);
                                print(controller.selectedLocation1?.value);
                              },
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (String? val) {
                          controller.selectedLocation?.value = val!;
                          controller.selectedLocation1 = null;
                         print(controller.selectedLocation?.value);
                         print(controller.selectedLocation1?.value);
                        },
                      )
                    ],
                  ),
                ),
                Container(width: ScreenConstant.defaultWidthTen,),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Afternoon", style: TextStyles.textStyleRegular.copyWith(fontSize:16)),
                      Container(
                        height: ScreenConstant.defaultHeightFifteen,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: "Select date",

                        ),
                        itemHeight: 60,
                        isExpanded: true,
                        iconSize: 0.0,
                        style: TextStyle(color: Colors.black54,height: 0.1),
                        items: ['9.00am-10.0am', '10.00am-11.00am', '11.00am-12.00am'].map(
                              (val) {
                            return DropdownMenuItem<String>(
                              alignment: AlignmentDirectional.center,
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (String? val) {
                          controller.selectedLocation = null;
                          controller.selectedLocation1?.value = val.toString();
                          print(controller.selectedLocation?.value);
                          print(controller.selectedLocation1?.value);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: ScreenConstant.defaultHeightFifteen,
            ),
            Text("Select Delivery Date & Time",
                style: TextStyles.textStyleRegular),
            Container(
              height: ScreenConstant.defaultHeightFifteen,
            ),
            Obx(
              () => SizedBox(
                height: ScreenConstant.defaultHeightSixty,
                child: Center(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.dateList1.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          if(controller.isCollectionSelected.value == false){
                            showFailureSnackBar("Choose Collection date first", "Choose Collection date first");
                          }else{
                            controller.index2.value = index;
                            print(index);
                            print(controller.index1.value);
                            if(index > 0 && index > controller.index1.value){
                              controller.dateList1
                                  .forEach((element) => element.isColoured = false);
                              debugPrint("index:$index");
                              controller.dateList1[index].isColoured =
                              !controller.dateList1[index].isColoured!;
                              controller.dateList1.refresh();
                              controller.dateList1[index].ontap!();
                            }
                          }


                        },
                        child: Container(
                          height: ScreenConstant.defaultHeightNinety,
                          width: ScreenConstant.defaultWidthNinetyEight,
                          decoration: BoxDecoration(
                              color: controller.dateList1[index].isColoured ??
                                      false
                                  ? Colors.blueAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0,
                                    offset: Offset(0.5, 3)),
                              ]),
                          margin: EdgeInsets.symmetric(
                              vertical: ScreenConstant.defaultHeightFour,
                              horizontal: ScreenConstant.defaultWidthTen),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.dateList1[index].title ?? "",
                                style: TextStyles.hintTextStyle.copyWith(
                                    color: controller
                                                .dateList1[index].isColoured ??
                                            false
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(controller.dates[index],
                                  style: TextStyles.hintTextStyle.copyWith(
                                      color: controller.dateList1[index]
                                                  .isColoured ??
                                              false
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 10,
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: ScreenConstant.defaultHeightFifteen,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Morning", style: TextStyles.textStyleRegular.copyWith(fontSize:16)),
                      Container(
                        height: ScreenConstant.defaultHeightFifteen,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),

                            borderSide: BorderSide(color: Color(0xFFD9D9D9)),
                          ),
                          hintText: controller.selectedLocation3!.value,

                        ),

                        isExpanded: true,
                        iconSize: 0.0,
                        style: TextStyle(color: Colors.black54,height: 0.1),
                        items: ['9.00am-10.0am', '10.00am-11.00am', '11.00am-12.00am'].map(
                              (val) {
                            return DropdownMenuItem<String>(
                              alignment: AlignmentDirectional.center,
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          if(controller.index1.value == controller.index2.value){
                            showFailureSnackBar("", "Delivery date should be after collection");
                          }else{
                            controller.selectedLocation3 = val as RxString?;
                          }
                        },
                      )
                    ],
                  ),
                ),
                Container(width: ScreenConstant.defaultWidthTen,),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Afternoon", style: TextStyles.textStyleRegular.copyWith(fontSize:16)),
                      Container(
                        height: ScreenConstant.defaultHeightFifteen,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),

                            borderSide: BorderSide(color: Color(0xFFD9D9D9)),
                          ),
                          hintText: controller.selectedLocation4!.value,

                        ),

                        isExpanded: true,
                        iconSize: 0.0,
                        style: TextStyle(color: Colors.black54,height: 0.1),
                        items: ['9.00am-10.0am', '10.00am-11.00am', '11.00am-12.00am'].map(
                              (val) {
                            return DropdownMenuItem<String>(
                              alignment: AlignmentDirectional.center,
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(), onChanged: (String? value) {  },
                        // onChanged: (val) {
                        //   if(controller.index1.value == controller.index2.value){
                        //     showFailureSnackBar("", "Delivery date should be after collection");
                        //   }else{
                        //     //controller.selectedLocation4?.value = val.toString();
                        //   }
                        // },
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: ScreenConstant.defaultHeightTwentyThree,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenConstant.defaultWidthTwenty,
                  vertical: ScreenConstant.defaultHeightTen),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent.withOpacity(0.4)),
              width: Get.width,
              child: const Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Note: ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text:
                          ' A delivery charge of £3.00 will be incurred for a full service',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: ScreenConstant.screenHeightSeventh,
            ),
            ElevatedButton(style: ElevatedButton.styleFrom(
              foregroundColor: Colors.pinkAccent,//change background color of button
              backgroundColor: Colors.blueAccent,//change text color of button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 15.0,
            ),onPressed: () {}, child: const Text("Continue",style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }
}

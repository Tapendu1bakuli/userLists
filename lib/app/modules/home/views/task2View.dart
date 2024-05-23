import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:users/app/modules/home/controller/taskTwoController.dart';
import 'package:users/device_manager/screen_constants.dart';
import 'package:users/utils/utils.dart';

import '../../../../utils/TextStyles.dart';

class TaskTwoViewScreen extends GetView<TaskTwocontroller> {
  const TaskTwoViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
print(controller.firstTimeSlotsForCollection);
print(controller.firstTimeSlotsForDelivery);
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
                    itemCount: controller.deliveryDates.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          controller.validDateChoosen.value = false;
                          controller.isCollectionSelected.value = true;
                            controller.deliveryDates
                                .forEach((element) => element.isColoured = false);
                            controller.deliveryDates[index].isColoured =
                            !controller.deliveryDates[index].isColoured!;
                          controller.collectionDates
                              .forEach((element) => element.isColoured = false);
                            controller.deliveryDates.refresh();
                            controller.collectionDates.refresh();
                            controller.deliveryDates[index].ontap!();
                            controller.collectionDate.value = controller.dates[index] ?? "";

                        },
                        child: Container(
                          height: ScreenConstant.defaultHeightNinety,
                          width: ScreenConstant.defaultWidthNinetyEight,
                          decoration: BoxDecoration(
                              color:
                                  controller.deliveryDates[index].isColoured ?? false
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
                                controller.deliveryDates[index].title ?? "",
                                style: TextStyles.hintTextStyle.copyWith(
                                    color:
                                        controller.deliveryDates[index].isColoured ??
                                                false
                                            ? Colors.white
                                            : Colors.black),
                              ),
                              Text(controller.convertDateFormat(controller.dates[index]),
                                  style: TextStyles.hintTextStyle.copyWith(
                                      color: controller
                                                  .deliveryDates[index].isColoured ??
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
                      Obx(()=> DropdownButtonFormField(
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
                            hintText: "Select Date",
                            contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 10)
                          ),
                          isExpanded: true,
                          iconSize: 0.0,
                          style: TextStyle(color: Colors.black54,height: 0.1),
                          items: controller.morningTimeSlots.map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (String? val) {
                            controller.selectedLocation?.value = val!;
                            controller.selectedLocation1?.value = controller.afternoonTestSlots[0];


                            controller.collectionTimeSlot.value = val!;
                            controller.firstTimeSlotsForCollection = controller.createTimestamp(controller.collectionDate.value, controller.collectionTimeSlot.value);
                            print("TimeStamp:${controller.firstTimeSlotsForCollection}");
                          },
                        ),
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
                      Obx(()=> DropdownButtonFormField(
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
                            hintText: "Select Date",

                          ),
                          itemHeight: 60,
                          isExpanded: true,
                          iconSize: 0.0,
                          style: TextStyle(color: Colors.black54,height: 0.1),
                          items: controller.afternoonTestSlots.map(
                                (val) {
                              return DropdownMenuItem<String>(
                                alignment: AlignmentDirectional.center,
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (String? val) {
                            controller.selectedLocation?.value = controller.afternoonTestSlots[0];
                            controller.afternoonTestSlots.refresh();
                            controller.selectedLocation1?.value = val!;



                            controller.collectionTimeSlot.value = val!;
                            print(controller.selectedLocation?.value);
                            print(controller.selectedLocation1?.value);
                            controller.firstTimeSlotsForCollection = controller.createTimestamp(controller.collectionDate.value, controller.collectionTimeSlot.value);
                            print("TimeStamp:${controller.firstTimeSlotsForCollection}");
                          },
                        ),
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
                    itemCount: controller.collectionDates.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          if(controller.isCollectionSelected.value == false){
                            showFailureSnackBar("Choose Collection date first", "Choose Collection date first");
                          }else{
                              controller.collectionDates
                                  .forEach((element) => element.isColoured = false);
                              controller.collectionDates[index].isColoured =
                              !controller.collectionDates[index].isColoured!;
                              controller.collectionDates.refresh();
                              controller.collectionDates[index].ontap!();
                              controller.deliveryDate.value = controller.dates[index];
                          }


                        },
                        child: Container(
                          height: ScreenConstant.defaultHeightNinety,
                          width: ScreenConstant.defaultWidthNinetyEight,
                          decoration: BoxDecoration(
                              color: controller.collectionDates[index].isColoured ??
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
                                controller.collectionDates[index].title ?? "",
                                style: TextStyles.hintTextStyle.copyWith(
                                    color: controller
                                                .collectionDates[index].isColoured ??
                                            false
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(controller.convertDateFormat(controller.dates[index]),
                                  style: TextStyles.hintTextStyle.copyWith(
                                      color: controller.collectionDates[index]
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
                        items: controller.morningTimeSlots.map(
                              (val) {
                            return DropdownMenuItem<String>(
                              alignment: AlignmentDirectional.center,
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          controller.deliveryTimeSlot.value = val!;
                          controller.firstTimeSlotsForDelivery = controller.createTimestamp(controller.deliveryDate.value, controller.deliveryTimeSlot.value);
                          print("TimeStamp:${controller.firstTimeSlotsForDelivery}");
                          if(controller.firstTimeSlotsForDelivery.isAfter(controller.firstTimeSlotsForCollection)){
                            controller.validDateChoosen.value = true;
                            controller.selectedLocation3?.value = val;

                          }else{
                            showFailureSnackBar("", "Delivery date should be after collection");
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
                          hintText: controller.selectedLocation3!.value,
                        ),

                        isExpanded: true,
                        iconSize: 0.0,
                        style: TextStyle(color: Colors.black54,height: 0.1),
                        items: controller.afternoonTestSlots.map(
                              (val) {
                            return DropdownMenuItem<String>(
                              alignment: AlignmentDirectional.center,
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(), onChanged: (String? val) {
                        controller.firstTimeSlotsForDelivery = controller.createTimestamp(controller.deliveryDate.value, controller.deliveryTimeSlot.value);
                        print("TimeStamp:${controller.firstTimeSlotsForDelivery}");
                        if(controller.firstTimeSlotsForDelivery.isAfter(controller.firstTimeSlotsForCollection)){
                          controller.validDateChoosen.value = true;
                          controller.selectedLocation3 = val as RxString?;

                        }else{
                          showFailureSnackBar("", "Delivery date should be after collection");
                        }
                      },
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
            Obx(()=> ElevatedButton(style: ElevatedButton.styleFrom(//change background color of button
                backgroundColor:controller.firstTimeSlotsForCollection!=controller.firstTimeSlotsForDelivery && controller.validDateChoosen.value?Colors.blueAccent:Colors.white30,//change text color of button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 15.0,
              ),onPressed: () {
                if(controller.firstTimeSlotsForCollection!=controller.firstTimeSlotsForDelivery && controller.validDateChoosen.value){
                  showSuccessSnackbar("title", "Time choosen is valid");
                }else
                  showFailureSnackBar("title", "Delivery time must be after collection time");
              }, child:  Text("Continue",style: TextStyle(color:controller.firstTimeSlotsForCollection!=controller.firstTimeSlotsForDelivery && controller.validDateChoosen.value? Colors.white:Colors.black),)),
            )
          ],
        ),
      ),
    );
  }
}

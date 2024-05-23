import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import '../../../models/dateTimeModel.dart';

class TaskTwocontroller extends GetxController{
  //Variables
  RxList<String> dates = <String>[].obs;
  RxBool isCollectionSelected = false.obs;
  RxList<DateTimeModel> deliveryDates = [
    DateTimeModel(isColoured: false,title: "Today",subTitle: "20 Dec",ontap: (){}),
    DateTimeModel(isColoured: false,title: "Tomorrow",subTitle: "21 Dec",ontap: (){}),
    DateTimeModel(isColoured: false,title: "Select Date",subTitle: "20 Dec",ontap: (){})
  ].obs;
  RxList<DateTimeModel> collectionDates = [
    DateTimeModel(isColoured: false,title: "Today",subTitle: "20 Dec",ontap: (){}),
    DateTimeModel(isColoured: false,title: "Tomorrow",subTitle: "21 Dec",ontap: (){}),
    DateTimeModel(isColoured: false,title: "Select Date",subTitle: "20 Dec",ontap: (){})
  ].obs;
  RxList<String> morningTimeSlots = ['Select Date','9.00am-10.0am', '10.00am-11.00am', '11.00am-12.00am'].obs;
  RxList<String> afternoonTestSlots = ['Select Date','01.00pm-02.00pm', '02.00pm-03.00pm', '03.00pm-04.00pm'].obs;
  RxString? selectedLocation = "Select Date".obs;
  RxString? selectedLocation1 = "Select Date".obs;
  RxString? selectedLocation3 = "Select Date".obs;
  RxString? selectedLocation4 = "Select Date".obs;
  RxString collectionDate = "".obs;
  RxString collectionTimeSlot = "".obs;
  RxString deliveryDate = "".obs;
  RxString deliveryTimeSlot = "".obs;
  late DateTime firstTimeSlotsForCollection;
  late DateTime firstTimeSlotsForDelivery;
  RxBool validDateChoosen = false.obs;

  String convertDateFormat(String inputDateStr) {
    // Parse the input date string
    DateTime inputDate = DateFormat('yyyy-MM-dd').parse(inputDateStr);

    // Format the date into the desired format
    String formattedDate = DateFormat('dd MMM').format(inputDate);

    return formattedDate;
  }
  //create time stamp for get the difference
  DateTime createTimestamp(String dateStr, String timeStr) {
    print("DATE:$dateStr");
    print("TIME:$timeStr");
    // Parse date into DateTime object
    DateTime dateObj = DateFormat('yyyy-MM-dd').parse(dateStr);

    // Split time string into components
    List<String> timeComponents = timeStr.split('-');

    // Parse start time components
    List<String> startTimeComponents = timeComponents[0].trim().split('.');
    int startHour = int.parse(startTimeComponents[0]);
    int startMinute = int.parse(startTimeComponents[1].replaceAll('am', '').replaceAll('pm', ''));
    bool startIsPM = startTimeComponents[1].contains('pm');

    // Parse end time components
    List<String> endTimeComponents = timeComponents[1].trim().split('.');
    int endHour = int.parse(endTimeComponents[0]);
    int endMinute = int.parse(endTimeComponents[1].replaceAll('am', '').replaceAll('pm', ''));
    bool endIsPM = endTimeComponents[1].contains('pm');

    // Adjust hour for PM times
    if (startIsPM && startHour < 12) startHour += 12;
    if (endIsPM && endHour < 12) endHour += 12;

    // Create TimeOfDay objects
    TimeOfDay startTime = TimeOfDay(hour: startHour, minute: startMinute);
    TimeOfDay endTime = TimeOfDay(hour: endHour, minute: endMinute);

    // Calculate midpoint of the range
    TimeOfDay timestampTime = TimeOfDay(
      hour: (startTime.hour + endTime.hour) ~/ 2,
      minute: (startTime.minute + endTime.minute) ~/ 2,
    );

    // Combine date and time into a DateTime object
    return DateTime(
      dateObj.year,
      dateObj.month,
      dateObj.day,
      timestampTime.hour,
      timestampTime.minute,
    );
  }
  //Get 3 dates in a list
  List<String> getDates() {

    // Get today's date
    DateTime now = DateTime.now();
    String today = DateFormat('yyyy-MM-dd').format(now);
    dates.add(today);

    // Get tomorrow's date
    DateTime tomorrow = now.add(const Duration(days: 1));
    String tomorrowDate = DateFormat('yyyy-MM-dd').format(tomorrow);
    dates.add(tomorrowDate);

    // Get the day after tomorrow's date
    DateTime dayAfterTomorrow = now.add(const Duration(days: 2));
    String dayAfterTomorrowDate = DateFormat('yyyy-MM-dd').format(dayAfterTomorrow);
    dates.add(dayAfterTomorrowDate);

    return dates;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    firstTimeSlotsForCollection = DateTime.now();
    firstTimeSlotsForDelivery = DateTime.now();
    getDates();
  }

}
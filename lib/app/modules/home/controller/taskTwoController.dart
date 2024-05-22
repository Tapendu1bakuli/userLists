import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import '../../../models/dateTimeModel.dart';

class TaskTwocontroller extends GetxController{
  RxList<String> dates = <String>[].obs;
  RxInt index1 = 0.obs;
  RxInt index2 = 0.obs;
  RxBool isCollectionSelected = false.obs;
  RxBool isMorning1 =false.obs;
  RxBool isMorning2 =false.obs;
  RxBool isAfter1 =false.obs;
  RxBool isAfter2 =false.obs;
  List<String> getDates() {

    // Get today's date
    DateTime now = DateTime.now();
    String today = DateFormat('dd MMM').format(now);
    dates.add(today);

    // Get tomorrow's date
    DateTime tomorrow = now.add(Duration(days: 1));
    String tomorrowDate = DateFormat('dd MMM').format(tomorrow);
    dates.add(tomorrowDate);

    // Get the day after tomorrow's date
    DateTime dayAfterTomorrow = now.add(Duration(days: 2));
    String dayAfterTomorrowDate = DateFormat('dd MMM').format(dayAfterTomorrow);
    dates.add(dayAfterTomorrowDate);

    return dates;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDates();
  }
RxList<DateTimeModel> dateList = [
  DateTimeModel(isColoured: false,title: "Today",subTitle: "20 Dec",ontap: (){}),
  DateTimeModel(isColoured: false,title: "Tomorrow",subTitle: "21 Dec",ontap: (){}),
  DateTimeModel(isColoured: false,title: "Select Date",subTitle: "20 Dec",ontap: (){})
].obs;
RxList<DateTimeModel> dateList1 = [
  DateTimeModel(isColoured: false,title: "Today",subTitle: "20 Dec",ontap: (){}),
  DateTimeModel(isColoured: false,title: "Tomorrow",subTitle: "21 Dec",ontap: (){}),
  DateTimeModel(isColoured: false,title: "Select Date",subTitle: "20 Dec",ontap: (){})
].obs;
List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];
List<String> locations = ['A', 'B', 'C', 'D']; // Option 2
RxString? selectedLocation = "Select Date".obs;
RxString? selectedLocation1 = "Select Date".obs;
RxString? selectedLocation3 = "Select Date".obs;
RxString? selectedLocation4 = "Select Date".obs;
}
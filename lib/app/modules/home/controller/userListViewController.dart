import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../models/user_data_model.dart';


class UserListViewController extends GetxController{
  RxBool isLoading = false.obs;
  RxList<UserDataModel> userList = <UserDataModel>[].obs;
  //getSlider
  Future fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        userList.assignAll(list.map((model) => UserDataModel.fromJson(model)).toList());
        print("USerslength:${userList.length}");
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
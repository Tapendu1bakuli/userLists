import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../models/album_model.dart';
import '../../../models/photos_model.dart';
import '../../../models/user_data_model.dart';


class UserListViewController extends GetxController{
  RxBool isLoading = false.obs;
  RxList<UserDataModel> userList = <UserDataModel>[].obs;
  RxList<AlbumModel> albumList = <AlbumModel>[].obs;
  RxList<PhotosModel> photosList = <PhotosModel>[].obs;

  RxString temporaryDocImageName = "".obs;
  RxString temporaryDocImagePath = "".obs;
  //fetUSer
  Future fetchUsers() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        userList.assignAll(list.map((model) => UserDataModel.fromJson(model)).toList());
        print("UsersLength:${userList.length}");
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to load users');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
    }
    isLoading.value = false;
  }
  //fetAlbumOnUser
  Future fetchAlbum(int id) async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/$id/albums'));
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        albumList.assignAll(list.map((model) => AlbumModel.fromJson(model)).toList());
        print("AlbumLength:${userList.length}");
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to load users');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
    }
    isLoading.value = false;
  }
  //fetchPhotos
  Future fetchPhotos(int id) async {
    isLoading.value = true;
    try {
      print("ID:$id");
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$id/photos'));
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        photosList.assignAll(list.map((model) => PhotosModel.fromJson(model)).toList());
        print("PhotosLength:${userList.length}");
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to load users');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
    }
    isLoading.value = false;
  }
}
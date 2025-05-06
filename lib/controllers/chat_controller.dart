
import 'dart:convert';

import 'package:flipzy/Api/chat_with_users_model.dart';
import 'package:flipzy/Api/repos/get_chat_list_repo.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'package:flipzy/Api/chat_users_model.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_socket.dart';
import 'package:flipzy/resources/auth_data.dart';

class ChatController extends GetxController {
  final SocketService socketService = SocketService();
  TextEditingController searchCtrl = TextEditingController();
  ChatWithUsersModel model = ChatWithUsersModel();
  bool isDataLoading = false;
  List<ChatWithUser> usersList = [];

  final deBounce = Debouncer(milliseconds: 1000);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // fetchUsersList();
    socketService.connect();
    connectWithThreads();
  }



  connectWithThreads({searchTerm}){
    developer.log('lokesh:::chat:::::$socketService');
    developer.log('lokesh:::chat:::::${AuthData().userModel?.id}');
    String? userID = AuthData().userModel?.id;
    isDataLoading = true;
    final requestData = {
      'userId': userID,
      'searchTerm': searchTerm??'',
    };
    developer.log('Requesting threads list with data: $requestData');
    socketService.socket?.emit('userOnline', { 'userId': userID});
    socketService.socket?.emit('getSupportMessages', requestData);
    socketService.socket?.on('getAllChatMessages', (data) {
      print('data data data: ${jsonEncode(data)}');

      if (data != null && data['status'] == true) {
        // Parse response into model
        final model = ChatWithUsersModel.fromJson(Map<String, dynamic>.from(data));

        print('Support data: ${jsonEncode(model.data)}');
        usersList.clear();
        isDataLoading = false;


        if (model.data != null && model.data!.isNotEmpty) {
          usersList.addAll(model.data!); // Ensure usersList accepts List<ChatWithUser>
        }
        update();
        // Optionally update UI with setState()
      } else {
        final errorMessage = data?['message'] ?? 'Error fetching data';
        print('Error: $errorMessage');
        isDataLoading = false;
        update();
        // Show toast/snackbar
      }
    });

  }
  fetchUsersList({String? searchValue}) async{
    isDataLoading = true;
    await getChatUsersListApi(searchParam: searchValue).then((value){
      usersList.clear();
      model = value;
      isDataLoading = false;
      if(model.data!=null && model.data!.isNotEmpty){
        usersList.addAll(value.data??[]);
      }

      update();
    });
  }


}

class ChatUser {
  String name;
  String image;
  String message;
  String time;
  ChatUser({this.name = "", this.image = "", this.message = "", this.time = ""});
}
import 'dart:convert';

import 'package:flipzy/Api/api_models/common_model_response.dart';
import 'package:flipzy/Api/repos/fatch_profile_repo.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/local_storage.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  CommonModelResponse modelResponse = CommonModelResponse();



@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileData();
  }


  getProfileData() async{
    await fetchProfileApi().then((value){
      modelResponse = value;
      LocalStorage().setValue(LocalStorage.USER_DATA, jsonEncode(value.data));
      AuthData().getLoginData();
      update();
    });
  }



}
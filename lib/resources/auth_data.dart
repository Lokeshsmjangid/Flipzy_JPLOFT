import 'dart:convert';
import 'dart:developer';

import 'package:flipzy/Api/api_models/user_model.dart';
import 'package:flipzy/resources/utils.dart';

import 'local_storage.dart';

class AuthData {

  AuthData._internal(); // Private constructor
  static final AuthData _instance = AuthData._internal();

  String? userToken;
  bool isLogin = false;

  String? rememberedEmail;
  String? rememberedPassword;
  UserModel? userModel;


  // Factory constructor to return the same instance
  factory AuthData() {
    return _instance;
  }

  getLoginData() {
    if(LocalStorage().getValue(LocalStorage.USER_ACCESS_TOKEN).isNotEmpty){
      AuthData().userToken = LocalStorage().getValue(LocalStorage.USER_ACCESS_TOKEN);
      AuthData().isLogin = true;

      var userData = jsonDecode(LocalStorage().getValue(LocalStorage.USER_DATA));
      if(userData!=null){
        AuthData().userModel = UserModel.fromJson(userData);
      }
    }
    if(LocalStorage().getBoolValue(LocalStorage.REMEMBER_ME)){ // added after remember me functionality
      rememberedEmail = LocalStorage().getValue(LocalStorage.REMEMBER_EMAIL);
      rememberedPassword = LocalStorage().getValue(LocalStorage.REMEMBER_PASSWORD);
      log('---------------REMEMBER_ME_DETAILS----------------\n REMEMBER_EMAIL:$rememberedEmail, REMEMBER_PASSWORD:$rememberedPassword,');
    }

    flipzyPrint(message: 'AuthData.IS_LOGIN-->${AuthData().isLogin}<--\n\n [\nLOGIN USER DETAILS--------********----------\nTOKEN: ${AuthData().userToken} \n\n '
        'Detail:'
        '${jsonEncode(AuthData().userModel)}'
        '\n-----********-----\n]'// uncommen when api implemented
    );
  }
}

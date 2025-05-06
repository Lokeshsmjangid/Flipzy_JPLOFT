
import 'package:flipzy/Screens/auth_screens/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'auth_data.dart';

class LocalStorage {
  static const IS_LOGIN = "IS_LOGIN";
  static const USER_ACCESS_TOKEN = "USER_ACCESS_TOKEN";
  static const USER_DATA = "USER_DATA";


  // remember me
  static const REMEMBER_ME = "REMEMBER_ME";
  static const REMEMBER_EMAIL = "REMEMBER_EMAIL";
  static const REMEMBER_PASSWORD = "REMEMBER_PASSWORD";

  final box = GetStorage();

// Local Storage Getx methods
  setValue(String key, String value) {
    GetStorage localStorage = GetStorage();
    localStorage.write(key, value);
  }

  String getValue(String key) {
    GetStorage localStorage = GetStorage();
    var value = localStorage.read(key);
    return value ?? '';
  }

  setBoolValue(String key, value){
    GetStorage localStorage = GetStorage();
    localStorage.write(key, value);
  }

  bool getBoolValue(String key){
    GetStorage localStorage = GetStorage();
    var value = localStorage.read(key);
    return value ?? false;
  }

  clearLocalStorage({isRemember=false,email='',pass=''}){
    GetStorage localStorage = GetStorage();
    localStorage.erase();
    AuthData().userModel=null;
    AuthData().isLogin = false;
    LocalStorage().setBoolValue(LocalStorage.REMEMBER_ME,isRemember);
    LocalStorage().setValue(LocalStorage.REMEMBER_EMAIL,email);
    LocalStorage().setValue(LocalStorage.REMEMBER_PASSWORD,pass);
    Get.offAll(()=>LoginScreen());
  }
}
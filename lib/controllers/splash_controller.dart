import 'package:flipzy/Screens/custom_bottom_navigation.dart';
import 'package:flipzy/Screens/onboarding_screens/onboarding_screens.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    AuthData().getLoginData();
    super.onInit();
    Future.delayed(const Duration(milliseconds: 2500),(){
      Future.microtask((){
        navigateUser();
      });
    });
  }

  void navigateUser() {
    if (AuthData().isLogin) {
      final user = AuthData().userModel;
      if(user?.email!=null){
        Get.offAll(() =>CustomBottomNav());
      } else {
        Get.offAllNamed(AppRoutes.setupProfileScreen);
      }
    }
    else {
      Get.offNamed(AppRoutes.onboardingScreen);
    }
  }

}
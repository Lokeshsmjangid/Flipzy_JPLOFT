import 'package:flipzy/Screens/custom_bottom_navigation.dart';
import 'package:flipzy/Screens/onboarding_screens/onboarding_screens.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/utils.dart';
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
      if(user?.email != null){
        flipzyPrint(message: 'user?.email---00---> ${user?.email}');
        Get.offAll(() =>CustomBottomNav());
      } else {
        flipzyPrint(message: 'user?.email---11---> ${user?.email}');
        Get.offAllNamed(AppRoutes.setupProfileScreen);
      }
    }
    else {
      flipzyPrint(message: 'user?.email---12---> ${AuthData().isLogin}');
      Get.offNamed(AppRoutes.onboardingScreen);
    }
  }

}
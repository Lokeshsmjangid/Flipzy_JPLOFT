
import 'package:flipzy/Screens/auth_screens/login_screen.dart';
import 'package:flipzy/Screens/custom_drawer.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_back_appbar.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/app_color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flipzy/controllers/bottom_bar_controller.dart';

import 'products/add_product.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(builder: (controller) {
      return Scaffold(
        key: controller.key,
        body: controller.widgetOptions.elementAt(controller.selectedIndex),
        extendBody: true,
        extendBodyBehindAppBar: true,
        drawer: controller.selectedIndex == 2 ? null :CustomDrawer(),
        appBar:
        controller.selectedIndex == 2 ? null
        // AppBar(title: addText500("", fontSize: 18, color: AppColors.blackColor), automaticallyImplyLeading: false, centerTitle: true, backgroundColor:  AppColors.whiteColor, elevation: 0, )
            : customAppBar(
          backgroundColor: AppColors.bgColor,
          leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
          leadingIcon: Container(
              margin: const EdgeInsets.only(right: 15, top: 10, ),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(
                AppAssets.homeLogoImg,
                // color: AppColors.blackColor,
                width: 15,
                height: 15,
              )
            /*child: SvgPicture.asset(
                AppAssets.homeLogoImg,
                // color: AppColors.blackColor,
                width: 15,
                height: 15,
              )*/
          ),
          centerTitle: false,
          titleTxt: "",
          titleColor: AppColors.blackColor,
          titleFontSize: 18,
          actionItems: [

            const SizedBox(width: 10,),

            GestureDetector(
              onTap: () {
                // print("Drawer opend");
                // contt.openDrawer = true;
                // contt.update();
                controller.key.currentState?.openDrawer();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.12,
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Icon(Icons.menu,color: AppColors.blackColor,size: 40),
                ),
              ),
            ),

            SizedBox(width: 10,),
          ],
          bottomLine: false ),

        bottomNavigationBar: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
            ),
            child: Stack(
              // clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(AppAssets.bottomNavShape).marginOnly(bottom: 10),
                Positioned(
                  left: 0,right: 0,
                  top: 0,bottom: 0,
                  child: BottomAppBar(
                    // shape: const CircularNotchedRectangle(),
                    color: Colors.transparent,
                    elevation: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: (){
                          if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);}
                          else {
                            controller.selectedIndex = 0;
                            controller.update();
                          }
                          }, icon: SvgPicture.asset(AppAssets.bottomNav0,height: 24,width: 24, color: controller.selectedIndex==0? AppColors.blackColor:Colors.grey)),
                        IconButton(onPressed: (){
                          if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);
                          } else{
                            controller.selectedIndex = 1;
                            controller.update();
                          }

                        }, icon: SvgPicture.asset(AppAssets.bottomNav1,height: 24,width: 24, color: controller.selectedIndex==1? AppColors.blackColor: Colors.grey),),
                        IconButton(padding: EdgeInsets.all(0), onPressed: (){
                          if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);} else{

                            controller.selectedIndex = 2;
                            controller.update();
                          }
                          },
                          // icon: Icon(Icons.add),
                          icon: const CircleAvatar(radius: 90,  backgroundColor: Colors.transparent),
                        ),
                        IconButton(onPressed: (){

    if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);} else{
                          controller.selectedIndex = 3;
                          controller.update();}
                        }, icon: SvgPicture.asset(AppAssets.bottomNav3,height: 24,width: 24, color: controller.selectedIndex==3 ? AppColors.blackColor : Colors.grey),),
                        IconButton(onPressed: (){
    if(AuthData().userModel?.guestId!=null){Get.toNamed(AppRoutes.loginScreen);} else{
                          controller.selectedIndex = 4;
                          controller.update();}
                        }, icon: Icon(Icons.person, size: 33, color: controller.selectedIndex==4 ? AppColors.blackColor : Colors.grey) ),
                          // icon: SvgPicture.asset(AppAssets.textUserIcon,height: 24,width: 24, color: controller.selectedIndex==4 ? AppColors.blackColor : Colors.grey),),
                      ],
                    ).marginOnly(bottom: 10,left: 20,right: 20),
                  ),
                )

              ],
            ).marginOnly(top: 6),
          ),
        )

      );
    });
  }
}

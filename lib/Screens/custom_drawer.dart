
import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/about_us_model.dart';
import 'package:flipzy/Api/repos/delete__account_repo.dart';
import 'package:flipzy/Api/repos/terms_privacy_aboutUs_repo.dart';
import 'package:flipzy/Screens/help/help_support.dart';
import 'package:flipzy/Screens/auth_screens/login_screen.dart';
import 'package:flipzy/Screens/manage_business.dart';
import 'package:flipzy/Screens/userProfile/user_profile.dart';
import 'package:flipzy/controllers/bottom_bar_controller.dart';
import 'package:flipzy/dialogues/about_us_dialogue.dart';
import 'package:flipzy/dialogues/delete_acount_dialogue.dart';
import 'package:flipzy/dialogues/logout_acount_dialogue.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/local_storage.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            addHeight(10),
            if(AuthData().userModel?.guestId ==null)
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                        tooltip: 'Delete Account',
                        onPressed: (){
                          Get.back();
                          DeleteAccountDialog.show(context,onTap1: (){
                            showLoader(true);
                            deleteAccountApi(userType: 'User').then((value){
                              showLoader(false);
                              if(value.status==true);
                              showToast('${value.message}');
                              LocalStorage().clearLocalStorage();
                            });
                          }, onTap2: (){
                            Get.back();
                          });


                        }, icon: SvgPicture.asset(AppAssets.deleteIC,color: AppColors.greenColor,height: 20,))).marginOnly(left: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                        tooltip: 'logout',
                        onPressed: (){
                          Get.back();
                          LogoutAccountDialog.show(context,
                              onTap1: (){
                            Get.back();

                            bool isRemember = LocalStorage().getBoolValue(LocalStorage.REMEMBER_ME);
                            String email = LocalStorage().getValue(LocalStorage.REMEMBER_EMAIL);
                            String pass = LocalStorage().getValue(LocalStorage.REMEMBER_PASSWORD);

                            showLoader(true);
                            Future.delayed(Duration(milliseconds: 1500),(){
                              LocalStorage().clearLocalStorage(isRemember: isRemember,email: email,pass: pass);
                              showLoader(false);
                            });
                          }, onTap2: (){Get.back();}
                          );

                        }, icon: SvgPicture.asset(AppAssets.drawerLogout))).marginSymmetric(horizontal: 16),
              ],
            ),


            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [

                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>UserProfile());
                        },
                        child: CircularPercentIndicator(
                          radius: 50,
                          lineWidth: 4.0,
                          percent: 0.50,
                          startAngle: 180,
                          fillColor: Colors.transparent,progressColor: AppColors.blackColor,
                          backgroundColor: AppColors.greenColor,

                          center: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            // child: Image.asset(AppAssets.profileImage),
                            child: CachedImageCircle2(
                                isCircular: true,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                imageUrl: '${AuthData().userModel?.profileImage}'),
                          ),
                          /* linearGradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFFFFD854),
                          Color(0xffFF9249),
                          Color(0xffEB4A66),
                          Color(0xffCB39A6)
                        ],
                                            ),
                                            rotateLinearGradient: true,*/
                        ),
                      ),
                      if(AuthData().userModel?.guestId ==null)
                      Positioned(
                          right: 0,
                          left: 0,
                          bottom: -4,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              alignment: Alignment.center,
                              height: 24,
                              width: 36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(color: Color(0XFFE9F0CA),width: 2),
                                  gradient: LinearGradient(
                                    tileMode: TileMode.repeated,
                                    colors: [Color(0xFF91B636), Color(0xffBBD15B), Color(0xff91B636)
                                    ],)
                              ),
                              child: addText700('${AuthData().userModel?.profilePercentage}%',fontSize: 10,fontFamily: 'Poppins'),
                            ),
                          ))

                    ],
                  ),

                  addHeight(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      if(AuthData().userModel?.guestId !=null)
                      addText600('Flipzy User'.capitalize.toString(),fontFamily: 'Poppins',fontSize: 18,color: AppColors.blackColor),
                      if(AuthData().userModel?.guestId ==null)
                      addText600('${AuthData().userModel?.firstname} ${AuthData().userModel?.lastname}'.capitalize.toString(),fontFamily: 'Poppins',fontSize: 18,color: AppColors.blackColor),
                      SizedBox(width: 10,),
                      if(AuthData().userModel?.guestId ==null)
                      SvgPicture.asset(AppAssets.drawerProfileVerify)
                    ],
                  ).marginSymmetric(horizontal: 16),
                  if(AuthData().userModel?.guestId ==null)
                  addText500('Complete Profile',fontFamily: 'Poppins',fontSize: 14,color: AppColors.blackColor),
                  addHeight(20),


                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset(AppAssets.drawerLine),
                      Positioned(
                        // top: 0,
                        // bottom: 0,
                          child: SvgPicture.asset(AppAssets.drawerEllipse)),
                    ],
                  ),


                  build_text_tile(imgPath: AppAssets.drawerHome,title: 'home',upperBorder: false,
                      onTap: (){

                    Future.microtask((){
                      Get.back();
                      Get.find<BottomBarController>().selectedIndex = 0;
                      Get.find<BottomBarController>().update();

                    });
                  }),

                  if(AuthData().userModel?.guestId ==null)
                    build_text_tile(imgPath: AppAssets.drawerMyProfile,title: 'My Profile',upperBorder: false,
                        onTap: (){
                          Future.microtask((){
                            Get.back();
                            Get.find<BottomBarController>().selectedIndex = 4;
                            Get.find<BottomBarController>().update();

                          });
                        }),

                  if(AuthData().userModel?.guestId ==null)
                    build_text_tile(imgPath: AppAssets.drawerNotification,title: 'Notifications',upperBorder: false,
                        onTap: (){
                          Future.microtask((){
                            Get.back();
                            Get.toNamed(AppRoutes.notificationScreen);
                          });
                        }),
                  if(AuthData().userModel?.guestId ==null)
                  build_text_tile(imgPath: AppAssets.textLocationIcon,title: 'shipping address',upperBorder: false,
                      onTap: (){
                    Get.back();
                    Get.toNamed(AppRoutes.allAddressScreen);
                  }),
                  // build_text_tile(imgPath: AppAssets.drawerOT,title: 'Order Tracking',upperBorder: false,
                  //     onTap: (){
                  //
                  //   Get.to(OrderTrackingWithId());
                  //     }),
                  if(AuthData().userModel?.guestId ==null)
                    build_text_tile(imgPath: AppAssets.drawerRatingReview,title: 'Ratings & Reviews',upperBorder: false,
                      onTap: (){
                        Future.microtask((){
                          Get.back();
                          Get.toNamed(AppRoutes.reviewsRatingScreen);
                        });
                      }),

                  /*build_text_tile(imgPath: AppAssets.drawerCart,title: 'Cart',upperBorder: false,
                      onTap: (){
                  Future.microtask((){
                    Get.back();Get.to(CartScreen());
                  });
                  }),*/
                  if(AuthData().userModel?.guestId ==null)
                    build_text_tile(imgPath: AppAssets.drawerOrderHistory,title: 'Order History',upperBorder: false,
                      onTap: (){
                        Future.microtask((){
                          Get.back();
                          Get.toNamed(AppRoutes.orderHistoryScreen,arguments: {'is_order_history':true,'userType':'User'});
                        });
                      }),
                  if(AuthData().userModel?.guestId ==null && AuthData().userModel!.userType!.toLowerCase() != 'user')
                    build_text_tile(imgPath: AppAssets.drawerManageBusiness,title: 'Manage Business',upperBorder: false,
                      onTap: (){
                        Get.back();
                    Get.to(()=>ManageBusiness());
                      }),


                  // my product and boost product
                  /*if(AuthData().userModel?.guestId ==null)
                    build_text_tile(imgPath: AppAssets.drawerMyProduct,title: 'My Products',upperBorder: false,
                      onTap: (){
                    Future.microtask((){
                      Get.back();
                      Get.toNamed(AppRoutes.myProductsScreen);
                    });}),
                  if(AuthData().userModel?.guestId ==null)
                    build_text_tile(imgPath: AppAssets.drawerMyProduct,title: 'Boost Products',upperBorder: false,
                      onTap: (){
                    Get.back();
                    Get.toNamed(AppRoutes.allBoostProduct,arguments: {'selectedBox':1});

                      }),*/
                  // my product and boost product

//Contact Us
                  /*build_text_tile(imgPath: AppAssets.drawerHelp,title: 'Contact Us',upperBorder: false,
                      onTap: (){
                        Future.microtask((){
                          Get.back();
                          Get.toNamed(AppRoutes.contactUsScreen);
                        });
                      }),*/

                  build_text_tile(imgPath: AppAssets.drawerHelp,title: 'Help & Support ',upperBorder: false,
                      onTap: (){
                        Get.back();
                    Get.to(()=>HelpSupport());
                      }),
                  if(AuthData().userModel?.guestId ==null)
                  build_text_tile(imgPath: AppAssets.drawerHelp,title: 'Chat With Support ',upperBorder: false,
                      onTap: (){
                        Get.back();
                    Get.toNamed(AppRoutes.supportScreen);
                      }),


                  build_text_tile(imgPath: AppAssets.drawerHelp,title: 'About Us',upperBorder: false,
                      onTap: (){
                    AboutUsModel model = AboutUsModel();
                    showLoader(true);
                        termsAboutUsPrivacyApi(url: ApiUrls.aboutUsUrl).then((about){
                          showLoader(false);
                          model = about;
                          setState(() {});
                          if(model.data!=null){
                            AboutUsDialog.show(context,pageTitle: 'About Us',aboutUsDesc: '${model.data!.details}');
                          }
                        });

                      }),




                ],
              ),
            ))

          ],
        ),
      ),
    );
  }
  build_text_tile({String? imgPath, String? title,bool upperBorder = false,bool lowerBorder = true,void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          if(upperBorder==true)
            const Divider(height: 0,thickness: 1,color: AppColors.greenLightColor,),
          Row(
            children: [

              // Divider(height: 0,),
              Container(
                  height: 44,width: 44,
                  decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.lightGreyColor),
                  child: SvgPicture.asset(imgPath!, color: AppColors.blackColor,).marginAll(14)),
              addWidth(10),
              addText600(title!.capitalize.toString(),fontSize: 16,color: AppColors.blackColor,fontFamily: 'Manrope')
            ],
          ).marginSymmetric(vertical: 14),

          if(lowerBorder==true)
            const Divider(height: 0,thickness: 1,color: AppColors.greenLightColor),
        ],
      ).marginSymmetric(horizontal: 16),
    );

  }

}

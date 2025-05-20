import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_set_id/app_set_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipzy/Api/repos/guest_login_repo.dart';
import 'package:flipzy/Api/repos/social_login_repo.dart';
import 'package:flipzy/Screens/custom_bottom_navigation.dart';
import 'package:flipzy/Screens/auth_screens/login_screen.dart';
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
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'register_mobile_number_screen.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});

  RxBool acceptCondition = false.obs;

   // Social Login
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final GoogleSignIn _googleSignIn = GoogleSignIn();
   Future<User?> signInWithGoogle() async {
     try {
       // Sign out if a user is already signed in
       await _googleSignIn.signOut();
       await _auth.signOut();

       // Trigger the authentication flow
       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

       if (googleUser == null) {
         return null; // If the user cancels the login process
       }

       // Obtain the auth details from the request
       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

       // Create a new credential
       final AuthCredential credential = GoogleAuthProvider.credential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
       );

       // Once signed in, return the UserCredential
       final UserCredential userCredential = await _auth.signInWithCredential(credential);
       return userCredential.user;
     } catch (e) {
       print('Google login error::$e:::');
       showToastError('Google login error: $e');
       return null;
     }
   }

   Future<AuthorizationCredentialAppleID?> signInWithApple() async {
     try {
       final credential = await SignInWithApple.getAppleIDCredential(
         scopes: [
           AppleIDAuthorizationScopes.email,
           AppleIDAuthorizationScopes.fullName,
         ],
       );

       // print('User ID: ${credential.userIdentifier}');
       // print('Email: ${credential.email}');
       // print('Full Name: ${credential.givenName} ${credential.familyName}');

       return credential;
     } catch (e) {
       print('Apple login error::$e:::');
       showToastError('Apple login error: $e');
       return null;
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          addHeight(110),
          Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(AppAssets.splashLogo)).marginSymmetric(horizontal: 16),
          addHeight(40),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.appBgColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    addHeight(20),

                    if(Platform.isIOS)
                    build_social_button(buttonIcon: AppAssets.appleIcon, buttonText: 'Continue with Apple Id',onTap: (){
                      if(acceptCondition.value) {
                        showLoader(true);
                        signInWithApple().then((value) {
                          showLoader(false);
                          if(value !=null){
                            log('Apple Data:$value');
                            String displayName = value.givenName ?? "";
                            List<String> nameParts = displayName.split(" ");

                            String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
                            String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";

                            print("First Name: $firstName");
                            print("Last Name: $lastName");

                            showLoader(true);
                            socialLoginApi(
                                firstName: firstName,
                                lastName: lastName,
                                email: value.email,
                                login_type: 'apple',
                                social_id: value.userIdentifier).then((socialValue){
                              showLoader(false);
                              if(socialValue.status==true){
                                if(socialValue.data?.email!=null){
                                  LocalStorage().setValue(LocalStorage.USER_ACCESS_TOKEN, socialValue.token.toString());
                                  LocalStorage().setValue(LocalStorage.USER_DATA, jsonEncode(socialValue.data));
                                  AuthData().getLoginData();
                                  Get.to(CustomBottomNav());
                                } else {
                                  Get.offAllNamed(AppRoutes.setupProfileScreen);
                                }

                              }
                              else if(socialValue.status==false){
                                showToastError('${socialValue.message}');
                              }
                            });

                          }
                        });
                      } else { showToastError('Please accept flipzy\'s term & condition');}



                    }),
                    if(Platform.isIOS)
                    addHeight(16),
                    build_social_button(
                        buttonIcon: AppAssets.callIcon,
                        buttonText: 'Continue with Mobile Number',
                        onTap: (){
                          if(acceptCondition.value){
                            Get.toNamed(AppRoutes.registerMobileNumberScreen);
                          } else {
                            showToastError('Please accept flipzy\'s term & condition');
                          }
                        }
                    ),
                    addHeight(16),

                    build_social_button(buttonIcon: AppAssets.googleIcon,
                        buttonText: 'Continue with Google',onTap: (){
                      if(acceptCondition.value) {
                        showLoader(true);
                        signInWithGoogle().then((value) {
        showLoader(false);
        if(value !=null){
          List<String> nameParts = value.displayName!.split(" ");
          String firstName = nameParts.isNotEmpty ? nameParts.first : "";
          String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";


          print("Google First Name: $firstName");
          print("Google Last Name: $lastName");
          log('Google login Data:$value');
          showLoader(true);
          socialLoginApi(
              firstName: firstName,
              lastName: lastName,
              email: value.email,
              login_type: 'google',
              social_id: value.uid).then((socialValue){
            showLoader(false);
            if(socialValue.status==true){
              if(socialValue.data?.email!=null){
                LocalStorage().setValue(LocalStorage.USER_ACCESS_TOKEN, socialValue.token.toString());
                LocalStorage().setValue(LocalStorage.USER_DATA, jsonEncode(socialValue.data));
                AuthData().getLoginData();
                Get.to(CustomBottomNav());
              } else {
                Get.offAllNamed(AppRoutes.setupProfileScreen);
              }

            }
            else if(socialValue.status==false){
              showToastError('${socialValue.message}');
            }
          });
        }});}
                      else { showToastError('Please accept flipzy\'s term & condition');}

                    }),
                    addHeight(20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => GestureDetector(
                          onTap: () {
                            acceptCondition.value = !acceptCondition.value;
                            // contt.update();
                          },
                          child: Container(
                            height: 17, width: 17,
                            decoration: BoxDecoration(
                                // color: acceptCondition.value ?  AppColors.primaryColor : AppColors.greyColor ,
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: AppColors.primaryColor, width: 2)
                            ),
                            child: acceptCondition.value ? Image.asset(AppAssets.checkIC) : IgnorePointer(),
                          ),
                        ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: addText500("I accept flipzy's term & condition to create my account", fontFamily: 'Manrope',
                              fontSize: 12),
                        ),
                        // Text(
                        //   "I accept flipzy's term & condition to create my account",
                        //   style: TextStyle(
                        //     fontSize: 11.0,
                        //     color: AppColors.blackColor,
                        //     fontWeight: FontWeight.w300,
                        //   ),
                        // ),
                      ],
                    ),

                    addHeight(20),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        addText700('Already have an account? ', fontSize: 13,
                            fontFamily: 'Manrope',
                            color: AppColors.blackColor),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>LoginScreen());
                          },
                          child: addText700(
                              'Log In', fontSize: 13,
                              fontFamily: 'Manrope',
                              color: AppColors.blackColor,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),

                    addHeight(20),

                    if(AuthData().userModel?.guestId ==null)
                    Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () async{
                            String? guestId = await AppSetId().getIdentifier();;
                            log('GuestID::::$guestId');

                            showLoader(true);
                            guestLoginApi(firstName: 'Guest $guestId',guestId: guestId).then((value){
                              showLoader(false);
                              if(value.status==true){

                                  LocalStorage().setValue(LocalStorage.USER_ACCESS_TOKEN, value.token.toString());
                                  LocalStorage().setValue(LocalStorage.USER_DATA, jsonEncode(value.data));
                                  AuthData().getLoginData();
                                  Get.to(CustomBottomNav());
                              }
                              else if(value.status==false){
                                showToastError('${value.message}');
                              }
                            });
                          },
                          child: addText600('Use as Guest', fontFamily: 'Manrope',
                              fontSize: 14,
                              color: AppColors.blackColor),
                        )),
                    addHeight(30)
                  ],
                ).marginSymmetric(horizontal: 16,vertical: 30),
              ),
            ),
          )


        ],
      ),
    );
  }
  build_social_button({String? buttonIcon, String? buttonText,void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffD1D1D1)),
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SvgPicture.asset('$buttonIcon', height: 30, width: 30,),
            addWidth(10),
            addText500('$buttonText', fontSize: 14, color: AppColors.blackColor)
          ],
        ),
      ),
    );
  }
}

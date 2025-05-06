import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_set_id/app_set_id.dart';
import 'package:flipzy/Api/repos/guest_login_repo.dart';
import 'package:flipzy/Api/repos/login_repo.dart';
import 'package:flipzy/Api/repos/social_login_repo.dart';
import 'package:flipzy/Screens/abcd.dart';
import 'package:flipzy/Screens/auth_screens/forgot_password_email_screen.dart';
import 'package:flipzy/Screens/auth_screens/signup_screen.dart';
import 'package:flipzy/Screens/custom_bottom_navigation.dart';
import 'package:flipzy/Screens/home_screen.dart';
import 'package:flipzy/Screens/onboarding_screens/onboarding_screens.dart';
import 'package:flipzy/controllers/login_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/main.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_button.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/local_storage.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (logic) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText600("Welcome Back to Flipzy", color: AppColors.blackColor, fontSize: 20)),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            addText500("New to Flipzy?", color: AppColors.blackColor),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoutes.signUpScreen);
                              },
                              child: addText500(
                                  ' Create an account',
                                  // fontSize: 14,
                                  fontFamily: 'Manrope',
                                  color: AppColors.blackColor,decoration: TextDecoration.underline,height: 0),
                            ),
                          ],
                        )),

                    SizedBox(height: 40,),

                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText500("Email", color: AppColors.blackColor, fontSize: 15)),

                    SizedBox(height: 5,),

                    CustomTextField(
                      controller: logic.emailCtrl,
                      fillColor: AppColors.whiteColor,
                     prefixIcon: SvgPicture.asset(AppAssets.textMailIcon,),
                      hintText: "Enter your Email",
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Email is required.'),
                        EmailValidator(errorText: "Please enter valid email")
                      ]),
                    ),

                    SizedBox(height: 20,),

                    Align(
                        alignment: Alignment.centerLeft,
                        child: addText500("Password", color: AppColors.blackColor, fontSize: 15)),

                    SizedBox(height: 10,),

                    CustomTextField(
                      controller: logic.passCtrl,
                      fillColor: AppColors.whiteColor,
                      prefixIcon: SvgPicture.asset(AppAssets.textPasswordIcon,),
                      hintText: "Enter your Password",
                      obscureText: logic.obsurePass,
                      suffixIcon: GestureDetector(
                          onTap: logic.ontapPassSuffix,
                          child: SvgPicture.asset(logic.obsurePass?AppAssets.eyeOnIcon:AppAssets.eyeOffIcon,height: 16,width: 20,)),
                      validator: MultiValidator([
                            RequiredValidator(errorText: 'Password is required.'),
                            MinLengthValidator(6, errorText: 'Password must be at least 6 char/digits long'),
                            PatternValidator(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
                                errorText: 'Password must include an uppercase, number & special character.')
                      ]),

                    ),

                    SizedBox(height: 20),

                //CheckBox
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            logic.isEmployeeAgreed = !logic.isEmployeeAgreed;
                            logic.update();
                          },
                          child: Container(
                            height: 20, width: 20,
                            decoration: BoxDecoration(
                              color: logic.isEmployeeAgreed ?  AppColors.primaryColor : AppColors.greyColor ,
                                borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: logic.isEmployeeAgreed ? AppColors.primaryColor : AppColors.greyColor, width: 2)
                            ),
                            child: logic.isEmployeeAgreed ? Image.asset(AppAssets.checkIC) : IgnorePointer(),
                          ),
                        ),
                        SizedBox(width: 5,),
                        addText400("Remember me", color: AppColors.blackColor, fontSize: 15),

                        Spacer(),

                        GestureDetector(
                            onTap: () {
                              Get.to(ForgotPasswordEmailScreen());
                            },
                            child: addText400("Forgot Password?", color: AppColors.blackColor, fontSize: 15))
                      ],
                    ),

                    SizedBox(height: 20,),
                //LoginBtn
                    AppButton( onButtonTap: () {
                      if(formKey.currentState?.validate()??false){

                        showLoader(true);
                        loginApi(email: logic.emailCtrl.text,password: logic.passCtrl.text).then((value){
                          showLoader(false);
                          if(value.status==true){
                            if(value.data?.email!=null){
                              LocalStorage().setValue(LocalStorage.USER_ACCESS_TOKEN, value.token.toString());
                              LocalStorage().setValue(LocalStorage.USER_DATA, jsonEncode(value.data));
                              if(logic.isEmployeeAgreed==true){
                                LocalStorage().setBoolValue(LocalStorage.REMEMBER_ME, true);
                                LocalStorage().setValue(LocalStorage.REMEMBER_EMAIL, logic.emailCtrl.text);
                                LocalStorage().setValue(LocalStorage.REMEMBER_PASSWORD, logic.passCtrl.text);
                              } else{
                                LocalStorage().setBoolValue(LocalStorage.REMEMBER_ME, false);
                              }
                              AuthData().getLoginData();
                              Future.microtask((){
                                // Get.reset();
                                Get.offAll(() => CustomBottomNav());
                              });
                            } else {
                              Get.offAllNamed(AppRoutes.setupProfileScreen);
                            }

                          }
                          else if(value.status==false){
                            showToastError('${value.message}');
                          }
                        });
                      }
                    } , buttonText: "Login", buttonTxtColor: AppColors.blackColor, ),

                    SizedBox(height: 30,),
                //OrLogin
                    Row(
                      children: [
                        Expanded(child: Image.asset(AppAssets.loginStickL)),
                       SizedBox(width: 10,),
                        addText400("or login with",
                          color: AppColors.blackColor, fontSize: 15,  ),
                        SizedBox(width: 10,),
                        Expanded(child: Image.asset(AppAssets.loginStickR)),
                      ],
                    ),

                    SizedBox(height: 30,),


                    if(Platform.isIOS)
                    GestureDetector( // Social Login Apple
                      onTap: (){
                        showLoader(true);
                        logic.signInWithApple().then((value){
                          showLoader(false);
                          if(value!=null){
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
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Apple Logo
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SvgPicture.asset(
                                AppAssets.appleIcon, // Add your apple logo SVG in assets folder
                                height: 24,
                                width: 24,
                              ),
                            ),
                            // Text
                            Text(
                              "Continue with Apple",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if(Platform.isIOS)
                    SizedBox(height: 10),

                    GestureDetector( // Social Login Google
                      onTap: () {
                        showLoader(true);
                        logic.signInWithGoogle().then((value){
                          showLoader(false);
                          if(value!=null){
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
                          }
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Apple Logo
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SvgPicture.asset(
                                AppAssets.googleIcon, // Add your apple logo SVG in assets folder
                                height: 24,
                                width: 24,
                              ),
                            ),
                            // Text
                            Text(
                              "Continue with Google",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),

                    if(AuthData().userModel?.guestId ==null)
                    GestureDetector(
                        onTap:() async{
                          String? guestId = await AppSetId().getIdentifier();;
                          log('GuestID::::$guestId');

                          showLoader(true);
                          guestLoginApi(
                              firstName: 'Guest $guestId',
                              guestId: guestId).then((value){
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
                        child: addText400("Use as Guest", color: AppColors.blackColor, fontSize: 15)),

                    SizedBox(height: 30)


                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

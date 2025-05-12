import 'package:flipzy/Api/repos/contact_us_repo.dart';
import 'package:flipzy/controllers/help_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController nameLCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController msgCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
        leadingIcon: IconButton(
            onPressed: (){
              Get.back();},
            icon: Row(
              children: [
                Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 14,),
                addText400("Back", color: AppColors.blackColor,fontSize: 12,fontFamily: 'Poppins'),
              ],
            ).marginOnly(left: 12)),
        centerTitle: true,
        titleTxt: "Contact Us",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        bottomLine: true,
      ),

            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: addText700("Send Us a Message",fontFamily: 'Manrope' ,maxLines: 2, color: AppColors.blackColor, fontSize: 20)),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: addText500("We’d love to hear from you! Whether you have questions, feedback, or need assistance, feel free to reach out to us. Our team is here to help", fontFamily: 'Manrope',color: AppColors.textColor1, fontSize: 12)),
                      ),

                      SizedBox(height: 30,),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.greyColor),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [

                            SizedBox(height: 20,),
                                //Name
                            Align(
                                alignment: Alignment.centerLeft,
                                child: addText500("Name", fontFamily: 'Manrope',fontSize: 14,color: AppColors.blackColor)),
                            SizedBox(height: 5,),

                            CustomTextField(
                              controller: nameCtrl,
                              borderRadius: 10000,
                              hintText: 'Enter First Name',
                              validator: MultiValidator([RequiredValidator(errorText: 'Please enter name')]),
                            ),

                            SizedBox(height: 20,),
                                //LastName
                            Align(
                                alignment: Alignment.centerLeft,
                                child: addText500("Last Name", fontFamily: 'Manrope',fontSize: 14, color: AppColors.blackColor)),
                            SizedBox(height: 10,),
                            CustomTextField(
                              controller: nameLCtrl,
                              borderRadius: 10000,
                              hintText: 'Enter Last Name',
                              validator: MultiValidator([RequiredValidator(errorText: 'Please enter last name')]),
                            ),


                            SizedBox(height: 20,),
                                //Email
                            Align(
                                alignment: Alignment.centerLeft,
                                child: addText500("Email", fontFamily: 'Manrope',fontSize: 14, color: AppColors.blackColor)),
                            SizedBox(height: 10,),


                            CustomTextField(
                              controller: emailCtrl,
                              borderRadius: 10000,
                              hintText: 'Enter Email',
                              keyboardType: TextInputType.emailAddress,
                              validator: MultiValidator([RequiredValidator(errorText: 'Please enter email'),EmailValidator(errorText: 'Please enter valid email')]),
                            ),

                            SizedBox(height: 20,),

                                //MobileNum
                            Align(
                                alignment: Alignment.centerLeft,
                                child: addText500("Mobile Number", fontFamily: 'Manrope',fontSize: 14, color: AppColors.blackColor)),

                            SizedBox(height: 10,),


                            CustomTextField(
                              borderRadius: 10000,
                              controller: mobileCtrl,
                              hintText: 'Enter Mobile Number',
                              keyboardType: TextInputType.phone,
                              validator: MultiValidator([RequiredValidator(errorText: 'Please enter mobile number')]),
                            ),

                            SizedBox(height: 20,),

                                //Message
                            Align(
                                alignment: Alignment.centerLeft,
                                child: addText500("Message",  fontFamily: 'Manrope',fontSize: 14,color: AppColors.blackColor)),

                            SizedBox(height: 10,),

                            CustomTextField(
                              borderRadius: 16,
                              controller: msgCtrl,
                              maxLines: 4,
                              hintText: 'Enter Message',
                              keyboardType: TextInputType.text,
                              validator: MultiValidator([RequiredValidator(errorText: 'Please enter message')]),
                            ),


                          ],
                        ),
                      ),

                      SizedBox(height: 30,),

                                //Save
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: AppButton(
                          onButtonTap: () {
                            if(formKey.currentState?.validate()??false){
                              showLoader(true);
                              contactUsApi(
                                  userName: nameCtrl.text,
                                  lastName: nameLCtrl.text,
                                  email: emailCtrl.text,
                                  mobileNumber: mobileCtrl.text,message: msgCtrl.text).then((value){
                                showLoader(false);
                                if(value.status==true){
                                  showToast('${value.message}');
                                }

                              });
                            }

                          },
                          buttonText: 'Send', buttonTxtColor: AppColors.blackColor,).marginSymmetric(horizontal: 4),
                      ),

                      SizedBox(height: 30,),

                      // ListView.builder(itemBuilder: itemBuilder)
                    ],
                  ),
                ),
              ),
            ),
          );

  }
}

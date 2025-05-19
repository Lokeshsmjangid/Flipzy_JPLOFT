import 'package:flipzy/Api/repos/request_withdrawal_repo.dart';
import 'package:flipzy/Screens/business_profile/business_profile.dart';
import 'package:flipzy/controllers/wallet_management_controller.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawalScreen extends StatelessWidget {
  const WithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletManagementController>(
      init: WalletManagementController(),
        builder: (cntrl) {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
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
          titleTxt: "Withdrawal",
          titleColor: AppColors.blackColor,
          titleFontSize: 16,
          bottomLine: true,
        ),
        bottomNavigationBar: BorderedContainer(
            radius: 1000,
            child: AppButton(
                onButtonTap: () {
                  if(cntrl.withdrawalCtrl.text.isNotEmpty){
                      showLoader(true);
                    withdrawalApi(amount: cntrl.withdrawalCtrl.text).then((onValue){
                      showLoader(false);
                      if(onValue.status==true){

                        showToast('${onValue.message}');
                        Get.back();
                      }
                    });
                  }else{
                    showToastError("Please enter some amount for withdrawal request.");
                  }
                },
                buttonText: 'Withdrawal').marginSymmetric(horizontal: 4)
        ).marginSymmetric(horizontal: 12,vertical: 4),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.greyColor),
                  color: AppColors.lightGreyColor,
                ),
                child: Center(
                  child: TextField(
                    controller: cntrl.withdrawalCtrl,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: AppColors.blackColor,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "₦172,000",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 40,fontFamily: '',
                        color: AppColors.blackColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ),


              /*Spacer(),

          //Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: AppButton(
                    onButtonTap: () {
                      Get.to(BusinessProfile());
                    },
                    buttonText: 'Withdrawal').marginSymmetric(horizontal: 4),
              ),*/

              addHeight(24),
            ],
          ),
        ),
      );
    });
  }
}

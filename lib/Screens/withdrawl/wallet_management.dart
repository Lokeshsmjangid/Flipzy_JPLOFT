import 'package:flipzy/Screens/withdrawl/withdrawl_screen.dart';
import 'package:flipzy/controllers/wallet_management_controller.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class WalletManagement extends StatelessWidget {
  const WalletManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletManagementController>(
        init: WalletManagementController(),
        builder: (logic) {
      return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
        appBar: customAppBar(
          backgroundColor: AppColors.bgColor,
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
          titleTxt: "Wallet Management",
          titleColor: AppColors.blackColor,
          titleFontSize: 16,
          bottomLine: true,
        ),
        bottomNavigationBar: BorderedContainer(
            radius: 1000,
            child: AppButton(
                onButtonTap: () {
                  Get.to(WithdrawalScreen());
                },
                buttonText: 'Withdrawal').marginSymmetric(horizontal: 4)
        ).marginSymmetric(horizontal: 12),
        body: logic.isDataLoading
            // ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
            ? Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: 5,
            itemBuilder: (_, __) => Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 100,
            ),
          ),
        )
            : logic.response.data!=null? SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.armyGreenColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [

                          Expanded(child: addText500("Total Earnings", maxLines: 2, color: AppColors.whiteColor, fontSize: 15)),
                          SizedBox(width: 10,),
                          Container(
                            // margin: EdgeInsets.all(5),
                            height: 25, width: 25,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              // border: Border.all(color: AppColors.blackColor, width: 1),
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                                // showPassIc
                              child: SvgPicture.asset(
                                AppAssets.showPassIc,
                                // color: AppColors.whiteColor,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                       addText700("₦${logic.response.data!.summary!.totalEarnings}", maxLines: 2, color: AppColors.whiteColor, fontSize: 40,fontFamily: ''),
                      addText400("Payouts are processed weekly/monthly.", maxLines: 2, color: AppColors.whiteColor, fontSize: 15),

                    ],
                  ),
                ),
            //AvlBal
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: addText500("Available balance", maxLines: 2, color: AppColors.blackColor, fontSize: 15)
                            ),
                            SizedBox(height: 20,),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: addText700("₦${logic.response.data!.summary!.availableBalance}", maxLines: 2, color: AppColors.blackColor, fontSize: 40,fontFamily: '')),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 25, width: 25,
                                // margin: EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  // color: AppColors.greenColor,
                                  shape: BoxShape.circle,
                                ),
                                child:  SvgPicture.asset(
                                  AppAssets.greenDiagonalArrowIc,
                                  // color: AppColors.whiteColor,
                                  width: 15,
                                  height: 15,
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: addText500("Withdrawl Balance", maxLines: 2, color: AppColors.blackColor, fontSize: 15)
                            ),
                            SizedBox(height: 20,),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: addText700("₦${logic.response.data!.summary?.withdrawnBalance}", maxLines: 2, color: AppColors.blackColor, fontSize: 40,fontFamily: '')),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 25, width: 25,
                                // margin: EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  // color: AppColors.greenColor,
                                  shape: BoxShape.circle,
                                ),
                                child:  SvgPicture.asset(
                                  AppAssets.greenDiagonalArrowIc,
                                  // color: AppColors.whiteColor,
                                  width: 15,
                                  height: 15,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),

            //Trans_Histpry
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.greyColor,),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            addText500("Transaction History", maxLines: 2, color: AppColors.blackColor, fontSize: 15),
                            IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),


                      logic.response.data!.transactions!.isNotEmpty
                          ? ListView.builder(
                        shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: logic.response.data!.transactions!.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, item) {
                            return Column(
                              children: [

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10,),
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [

            //ProfilePic
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.15,
                                        padding: EdgeInsets.all( 3),
                                        // margin: EdgeInsets.only(left: 5),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColors.blackColor),
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.asset(AppAssets.brandImage),

                                          // child: Image.network(
                                          //   "https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_640.png",
                                          //   // width: 50, height: 50,
                                          //   fit: BoxFit.contain,
                                          // ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
            //Name-Date
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          addText700("${AuthData().userModel?.firstname?.capitalize} ${AuthData().userModel?.lastname?.capitalize}"), SizedBox(height: 2),
                                          addText500("Transaction: #${logic.response.data!.transactions![item].trackingId}", color: AppColors.txtGreyColor),
                                          // addText500("${logic.response.data!.transactions![item].trackingId}", color: AppColors.txtGreyColor),
                                        ],
                                      ),

                                      Spacer(),
            //NotificationsNumber
                                      addText500("\$${logic.response.data!.transactions![item].price}",
                                          // color: logic.response.data!.transactions![item].type=='Deposit'?AppColors.greenColor:Colors.red ),
                                          color:AppColors.blackColor ),

                                    ],
                                  ),
                                ),

                            SizedBox(height: 10,),
                            // if(item != 5)
                            //     Divider(
                            //       thickness: 1,
                            //     ),

                              ],
                            );
                          })
                          : Center(child: addText600('No Transactions found').marginOnly(bottom: 20)),
                    ],
                  ),
                ),
            /*SizedBox(height: 10,),
            //Button
                BorderedContainer(
                    radius: 1000,
                    child: AppButton(
                        onButtonTap: () {
                          Get.to(WithdrawalScreen());
                        },
                        buttonText: 'Withdrawal').marginSymmetric(horizontal: 4)
                ).marginSymmetric(horizontal: 12),*/

                addHeight(24),
              ],
            ),
          ),
        )
            : Center(child: addText600('No Transactions found')),
      );
    });
  }
}

import 'package:flipzy/Api/repos/clear_all_notification_repo.dart';
import 'package:flipzy/controllers/notification_controller.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(

        builder: (contt) {
      return Scaffold(
        appBar: customAppBar(
          backgroundColor: AppColors.bgColor,
          leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
          leadingIcon: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 14,),
                addText400("Back", color: AppColors.blackColor,fontSize: 12,fontFamily: 'Poppins'),
              ],
            ).marginOnly(left: 12),
          ),
          centerTitle: true,
          titleTxt: "Notification",
          titleColor: AppColors.blackColor,
          titleFontSize: 16,
          bottomLine: false,
        ),
          bottomNavigationBar: contt.modelResponse.data!=null && contt.modelResponse.data!.isNotEmpty?SafeArea(
            child: Container(
              height: 84,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                border: Border.all(
                    color: AppColors.containerBorderColor,
                ),
            
              ),
              child: AppButton(
                onButtonTap: (){
                  showLoader(true);
                  clearAllNotificationsApi().then((value){
                    showLoader(false);
                    if(value.status==true){
                      contt.modelResponse.data!.clear();
                      contt.update();
                    }
                  });
                },

                buttonText: 'Clear All',buttonColor: AppColors.bgColor,).marginSymmetric(horizontal: 16,vertical: 16),
            ).marginSymmetric(horizontal: 10,vertical: 4),
          ):SizedBox.shrink(),

        body: contt.isDataLoading
            ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
            : contt.modelResponse.data!=null && contt.modelResponse.data!.isNotEmpty
            ? ListView.builder(
            // itemCount: 6,
            itemCount: contt.modelResponse.data!.length??0,
            itemBuilder: (context, index) {

          return Slidable(
            endActionPane: ActionPane(motion: ScrollMotion(),
            extentRatio: 0.2,
            children: [
              SlidableAction(
                onPressed: (context) {
                  clearAllNotificationsApi(notificationsID: contt.modelResponse.data![index].id).then((value){
                    showLoader(false);
                    if(value.status==true){
                      contt.modelResponse.data!.removeAt(index);
                      contt.update();
                    }
                  });
                },
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.secondaryColor,
                foregroundColor: Colors.black,
                icon: CupertinoIcons.delete_solid,
                label: 'Delete',
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.sp), bottomLeft: Radius.circular(15.sp),),
              ),
            ],),
            child: Column(
              children: [
            
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
            
            //ProfilePic
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            margin: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              // child: Image.asset(AppAssets.notificationProfileIC),
                               child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedImageCircle2(
                                      height: 38,
                                      width: 38,
                                      imageUrl: '${contt.modelResponse.data![index].image}'),

                                )

                            ),
                          ),
                          Positioned(
                           top: 10, left: 0,
                            child: Container(
                              height: 10, width: 10,
                              decoration: BoxDecoration(
                                color: AppColors.blueColor1,
                                border: Border.all(width: 1, color: AppColors.blueColor),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
            //Name-Date
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addText500("${contt.modelResponse.data![index].title}",fontSize: 14,fontFamily: 'Manrope'),
                          SizedBox(height: 2,),
                          addText500("${formatDateTime('${contt.modelResponse.data![index].createdAt}')}",fontSize: 14,fontFamily: 'Manrope', color: AppColors.txtGreyColor),
                        ],
                      ),
            
                      Spacer(),
            //NotificationsNumber
            //           if(item%3 != 0)
            //           Container(
            //             padding: EdgeInsets.all(5),
            //             decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: AppColors.greenColor,
            //             ),
            //             child: addText500("1", color: AppColors.whiteColor, ),
            //           ),

                      // if(item%3 == 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.greenLightColor,
                        ),
                        child: addText500("${contt.modelResponse.data![index].type?.capitalize}", fontSize: 13,fontFamily: 'Manrope',),
                      )
            
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  height: 0,
                ),
              ],
            ),
          );
        })
            : Center(child: addText500('No Data Found'))
      );
    });
  }
}

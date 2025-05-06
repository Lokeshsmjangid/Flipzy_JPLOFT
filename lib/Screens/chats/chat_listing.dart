import 'package:flipzy/Screens/chats/chating_screen.dart';
import 'package:flipzy/controllers/chat_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatListingScreen extends StatelessWidget {
  ChatListingScreen({super.key});

  // final ctrl = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GetBuilder<ChatController>(builder: (cntrl) {
        return Column(
          children: [
            addHeight(90),
            ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: CustomTextField(
                controller: cntrl.searchCtrl,
                fillColor: AppColors.lightGreyColor,
                hintText: 'Enter Name',
                onChanged: (val){
                  cntrl.deBounce.run(() {
                    // cntrl.fetchUsersList(searchValue: val);
                    cntrl.connectWithThreads(searchTerm: val);
                  });
                },
                suffixIcon: Container(
                  width: 50,
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Icon(Icons.search, color: Colors.black,),
                ).marginOnly(right: 10),
              ),
            ).marginSymmetric(horizontal: 16),

            Expanded(
              child: cntrl.isDataLoading
                  ? Center(
                child: CircularProgressIndicator(color: AppColors.secondaryColor,),
              ) 
                  : cntrl.usersList.isNotEmpty
                  ? ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: cntrl.usersList.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.chattingScreen,arguments: {
                          'socket_instance':cntrl.socketService,
                          'receiver_data':cntrl.usersList[index]});
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: index == 0
                              ? AppColors.lightGreyColor
                              : AppColors.whiteColor,
                          // color: Colors.yellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
//ProfilePic
                            Container(
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 12),
                                    width: 76,
                                    height: 76,
                                    // margin: EdgeInsets.only(left: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: index == 0 ? AppColors
                                              .greenColor : Colors.transparent,
                                          width: index == 0 ? 2 : 0),
                                      shape: BoxShape.circle,

                                      // borderRadius: BorderRadius.circular(100),
                                    ),
                                    // child: Image.asset(cntrl.userList[index].image),
                                    child: CachedImageCircle2(imageUrl: cntrl.usersList[index].profileImage),
                                    // child: CircleAvatar(
                                    //   backgroundImage: NetworkImage(
                                    //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScB_NgZ9sgHcfBKgG6ik1yRrZ9vVsI7b4Oig&s",
                                    //   ),
                                    // ),
                                  ),
                                  Positioned(
                                    bottom: 8, right: 20,
                                    child: Container(
                                      height: 10, width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: cntrl.usersList[index].isOnline==true?AppColors.greenColor:AppColors.blackColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.62,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Name&Time
                                  Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      addText500('${cntrl.usersList[index].firstname?.capitalize??''}',
                                          color: AppColors.blackColor,
                                          fontSize: 16,
                                          fontFamily: 'Poppins'),

                                      Spacer(),
                                      // SizedBox(width: 20,),
                                      Align(alignment: Alignment.centerRight,
                                          child: addText400(
                                              formatTime(cntrl.usersList[index].createdAt.toString()),
                                              color: AppColors
                                                  .textFieldHintColor,
                                              fontSize: 12,
                                              fontFamily: 'Poppins'))
                                    ],
                                  ),

//Message&Number
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: Get.width * 0.55,
                                          child: addText400('${cntrl.usersList[index].lastMessage??'file'}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              color: cntrl.usersList[index].lastMessage == 'Sent you a new chat'
                                                  ? AppColors.greenColor
                                                  : cntrl.usersList[index].lastMessage == 'Typing...'
                                                  ? AppColors.textFieldHintColor
                                                  : AppColors.textColor2,
                                              fontSize: 12,
                                              fontFamily: 'Poppins')),
                                      if(cntrl.usersList[index].unreadCount!=null && cntrl.usersList[index].unreadCount>0)
                                        Container(
                                          // padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.greenColor,
                                          ),
                                          child: addText400(
                                            "${cntrl.usersList[index].unreadCount}", fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: AppColors.whiteColor,)
                                              .marginAll(7),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).marginOnly(bottom: 90)
                  : Center(child: addText600('No chat found'),),
            )
          ],
        );
      }),
    );
  }
}

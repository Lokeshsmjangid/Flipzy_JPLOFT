import 'package:flipzy/Api/chat_with_users_model.dart';
import 'package:flipzy/controllers/chat_controller.dart';
import 'package:flipzy/controllers/chating_controller.dart';
import 'package:flipzy/controllers/makeOffer_chat_controller.dart';
import 'package:flipzy/custom_widgets/appButton.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/app_socket.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MakeOfferChatScreen extends StatelessWidget {
  dynamic price;
  ChatWithUser? receiverData;
   MakeOfferChatScreen({super.key,this.receiverData,this.price});



  @override
  Widget build(BuildContext context) {
    // MakeOfferChatController
    return GetBuilder<MakeOfferChatController>(
        init: MakeOfferChatController(),
        builder: (cntrl) {
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
          titleTxt: "${receiverData?.firstname?.capitalize??""}",
          titleColor: AppColors.blackColor,
          titleFontSize: 16,
          bottomLine: true,
        ),

        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(cntrl.screen != 0)
              Container(
                height: 70,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.greyColor),
                    color: AppColors.whiteColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Enter Message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppColors.whiteColor,
                          ),
                          onChanged: (value) {
                            // Filter chat list based on input
                          },
                        ),
                      ),
                      Container(
                        height: 20, width: 20,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: SvgPicture.asset(
                          AppAssets.emojiIC,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          // border: Border.all(
                          //   // color: AppColors.primaryColor,
                          //   width: 1.5,
                          // ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.send, size: 30,),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      //   decoration: BoxDecoration(
                      //     color: AppColors.greenColor,
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: Icon(Icons.send),
                      // )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  // color: AppColors.greenColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.greyColor)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap : () {
                          cntrl.screen = 0;
                          cntrl.update();
                          // Get.to(MakeOfferChatScreen());
                        },
                        child: Container(

                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          decoration: BoxDecoration(
                            color: cntrl.screen == 0 ? AppColors.primaryColor : AppColors.greyColor,
                            borderRadius: BorderRadius.circular(30),
                            // border: Border.all(color: AppColors.greyColor)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppAssets.makeOfferIC,
                                fit: BoxFit.contain, // Try 'contain' or 'fitWidth' if needed
                              ),
                              SizedBox(width: 10,),
                              addText700('Make Offer',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 14),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // cntrl.screen = 1;
                          // cntrl.update();
                          Get.toNamed(AppRoutes.chattingScreen,arguments: {
                            'socket_instance':Get.find<ChatController>().socketService,
                            'receiver_data':ChatWithUser(
                                rowid: '',
                                isRead: false,
                                session: true,
                                userId: receiverData?.userId,
                                firstname: receiverData?.firstname,
                                profileImage: receiverData?.profileImage,
                                lastMessage: '',
                                createdAt: DateTime.now())});

                        },
                        child: Container(

                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          decoration: BoxDecoration(
                            color: cntrl.screen == 1 ? AppColors.primaryColor : AppColors.greyColor,
                            borderRadius: BorderRadius.circular(30),
                            // border: Border.all(color: AppColors.greyColor)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppAssets.chatIC,
                                fit: BoxFit.contain, // Try 'contain' or 'fitWidth' if needed
                              ),
                              SizedBox(width: 10,),
                              addText700('Chat',fontFamily: 'Manrope',color: AppColors.blackColor,fontSize: 14),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ).marginOnly(bottom: 10, left: 15, right: 15),
            ],
          ),
        ),

        body: cntrl.screen == 1
            ? Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
          height: Get.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.lightGreyColor,
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Row(
                  children: [

                    //ProfilePic
                    GestureDetector(
                      onTap: () {
                        // Get.to(UserProfile());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        height: MediaQuery.of(context).size.height * 0.12,
                        margin: EdgeInsets.only(left: 15),
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: AppColors.greenColor, width: 2),
                        //     shape: BoxShape.circle
                        //   // borderRadius: BorderRadius.circular(100),
                        // ),
                        child: Image.asset(AppAssets.chattingListP2Img),
                        // child: CircleAvatar(
                        //   backgroundImage: NetworkImage(
                        //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScB_NgZ9sgHcfBKgG6ik1yRrZ9vVsI7b4Oig&s",
                        //   ),
                        // ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    addText600("Jelani", color: AppColors.blackColor, fontSize: 15),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.06,
                      height: MediaQuery.of(context).size.height * 0.06,
                      margin: EdgeInsets.only(left: 15),
                      child: Image.asset(AppAssets.chatCallIC,),
                      // child: SvgPicture.asset(
                      //   AppAssets.chatCallIC,
                      //   color: AppColors.blackColor,
                      //   fit: BoxFit.contain,
                      // ),
                    ),

                    SizedBox(width: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.03,
                      height: MediaQuery.of(context).size.height * 0.03,
                      margin: EdgeInsets.only(left: 15, right: 20),
                      child: SvgPicture.asset(
                        AppAssets.threeDotsIc,
                        color: AppColors.blackColor,
                        fit: BoxFit.contain,
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 10,),

                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: index%2 == 0 ? Alignment.centerRight : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: index%2 == 0 ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
                          children: [
                            Container(
                              // width: MediaQuery.of(context).size.width * 0.7,
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              margin: index%2 == 0 ? EdgeInsets.only(right: 10, left: 50) : EdgeInsets.only(left: 10, right: 50),
                              decoration: BoxDecoration(
                                  color: index%2 == 0 ? AppColors.whiteColor : AppColors.blueColor ,
                                  borderRadius: BorderRadius.circular(10)),
                              child: addText400(
                                  "Hello",
                                  // "Run the code in a Flutter emulator or device. The screen should look very close to the image you provided, with a search bar at the top and a scrollable list of chats below it. Tap on a chat tile to add navigation functionality as needed.",
                                  color: AppColors.blackColor, fontSize: 15),
                            ),

                            Container(
                              margin: index%2 == 0 ? EdgeInsets.only(right: 10,) : EdgeInsets.only(left: 10,),
                              child: addText200(
                                  "12:00pm",
                                  // "Run the code in a Flutter emulator or device. The screen should look very close to the image you provided, with a search bar at the top and a scrollable list of chats below it. Tap on a chat tile to add navigation functionality as needed.",
                                  color: AppColors.blackColor, fontSize: 9),
                            ),

                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        )
            : Column(
          children: [
            /*Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.greyColor,),
                color: AppColors.lightGreyColor,
              ),
              child: Center(child: addText700("\$ 172,000", maxLines: 2, color: AppColors.blackColor, fontSize: 40)),
            ),*/
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.greyColor,),
                color: AppColors.lightGreyColor,
              ),
              child: Center(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: cntrl.amountController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                      fontFamily: ''
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '₦0',
                    hintStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: AppColors.greyColor,
                      fontFamily: ''
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),


            Spacer(),

            //Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AppButton(
                  onButtonTap: () {
                    if(cntrl.amountController.text.isEmpty){
                      showToastError('Please enter some amount to make an offer');
                    }else if(int.parse(cntrl.amountController.text) >= int.parse(price)){
                      showToastError('The offer should be less than the product price.');

                    } else{
                      Get.toNamed(AppRoutes.chattingScreen,arguments: {
                        'socket_instance':Get.find<ChatController>().socketService,
                        'receiver_data':ChatWithUser(
                            rowid: '',
                            isRead: false,
                            session: true,
                            userId: receiverData?.userId,
                            firstname: receiverData?.firstname,
                            profileImage: receiverData?.profileImage,
                            lastMessage: '',
                            createdAt: DateTime.now())});
                      Get.find<ChattingCtrl>().sendMessage(attachments: [],
                          message: '₦${cntrl.amountController.text.trim()}',
                          messageType: 'Offer'
                      );
                    }
                  },
                  buttonText: 'Send Offer').marginSymmetric(horizontal: 4),
            ),

            addHeight(24),
          ],
        ),
      );
    });
  }
}

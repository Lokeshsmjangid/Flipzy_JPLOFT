import 'dart:io';

import 'package:flipzy/dialogues/report_chat_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flipzy/controllers/chating_controller.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ChattingScreen extends StatelessWidget {
  ChattingScreen({super.key});

  final logic = Get.find<ChattingCtrl>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(
          backgroundColor: AppColors.whiteColor,
          leadingWidth: MediaQuery.of(context).size.width * 0.3,
          leadingIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                onPressed: () => Get.back(),
                icon: Icon(
                    Icons.arrow_back_ios_outlined, color: AppColors.blackColor,
                    size: 14),
              ),
              CachedImageCircle2(
                isCircular: true,
                height: 40,
                width: 40,
                imageUrl: logic.receiverData?.profileImage,
              )
            ],
          ).marginOnly(left: 12),
          centerTitle: true,
          titleTxt: "${logic.receiverData?.firstname?.capitalize ?? ""}",
          titleColor: AppColors.blackColor,
          titleFontSize: 16,
          bottomLine: true,
          actionItems: [
            GestureDetector(
              onTap: () {
                launchUrlString("tel:${logic.receiverData?.mobileNumber}");
              },
              child: Container(
                height: 40,
                width: 40,
                child: Image.asset(AppAssets.chatCallIC).marginAll(8),
              ),
            ),

            PopupMenuButton<String>(
              offset: Offset(0, 54),
              icon: SvgPicture.asset(
                AppAssets.threeDotsIc,
                color: AppColors.blackColor,
                height: 24,
                width: 24,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              onSelected: (value) {
                if (value == 'Report') {
                  ReportChatDialogue.show(context,msgCtrl: logic.reportCtrl,onTap: (){
                    if(logic.reportCtrl.text.isEmpty){
                      showToastError('Please enter your reason,why are you reporting this person');
                    } else{
                      final request = {
                        "senderId": AuthData().userModel?.id,
                        "reportId":logic.receiverData?.userId,
                        "reportMessage":logic.reportCtrl.text,
                        // "status":logic.isBlock==true?false:true,
                      };
                      flipzyPrint(message: 'reportRequest::${request}');
                      logic.socketService?.socket?.emit('report', request);
                    }
                  });

                  // handle report
                } else if (value == 'Block') {
                  // logic.isBlock = !logic.isBlock;
                  // logic.update();
                  flipzyPrint(message: 'Blocck hai ya nhi ${logic.isBlock==true?"-->haa hai":"-->Nhi hai "}');
                  final request = {
                    "userId": AuthData().userModel?.id,
                    "blockUserId":logic.receiverData?.userId,
                    // "status":logic.isBlock==true?false:true,
                  };
                  flipzyPrint(message: 'blockUser=Request::${request}');
                  logic.socketService?.socket?.emit('blockUser', request);

                  // handle block
                }
                else if (value == 'Clear Chat') {

                  String senderId = '${AuthData().userModel?.id}';
                  String receiverId = '${logic.receiverData?.userId}';

                  flipzyPrint(message: 'senderId::${senderId}');
                  flipzyPrint(message: 'receiverId::${receiverId}');

                  logic.socketService?.socket?.emit('deleteUserChat', {
                        'senderId': senderId,
                        'receiverId': receiverId,
                      });
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 'Clear Chat',
                    child: addText400('Clear Chat', fontSize: 14,
                        color: AppColors.blackColor)),
                PopupMenuItem(value: 'Report',
                    child: addText400(
                        'Report', fontSize: 14, color: AppColors.blackColor)),
                if(logic.senderBlockId==null || logic.senderBlockId==AuthData().userModel?.id)
                PopupMenuItem(value: 'Block',
                    child: addText400(
                        logic.isBlock == true ? 'UnBlock' : 'Block',
                        fontSize: 14, color: AppColors.blackColor)),
              ],
            ),
            addWidth(10)
          ]
      ),
      extendBody: true,
      bottomNavigationBar: GetBuilder<ChattingCtrl>(builder: (logic) {
        return logic.isBlock==true
            ? SizedBox.shrink()
            : SafeArea(
          child: GetBuilder<ChattingCtrl>(builder: (logic) {
            final file = logic.pickedFile;
            final ext = file?.extension?.toLowerCase() ?? '';

            Widget? preview;
            if (file != null) {
              switch (ext) {
                case 'jpg':
                case 'jpeg':
                case 'png':
                case 'gif':
                  preview = Image.file(File(file.path!), height: 80, width: 80, fit: BoxFit.cover);
                  break;
                case 'pdf':
                  preview =
                      Icon(Icons.picture_as_pdf, size: 60, color: Colors.red);
                  break;
                case 'mp4':
                  preview = Icon(Icons.videocam, size: 60, color: Colors.blue);
                  break;
                case 'mp3':
                  preview =
                      Icon(Icons.audiotrack, size: 60, color: Colors.green);
                  break;
                case 'doc':
                case 'docx':
                  preview =
                      Icon(Icons.description, size: 60, color: Colors.white);
                  break;
                case 'xls':
                case 'xlsx':
                  preview =
                      Icon(Icons.grid_on, size: 60, color: Colors.lightGreen);
                  break;
                case 'ppt':
                case 'pptx':
                  preview =
                      Icon(Icons.slideshow, size: 60, color: Colors.orange);
                  break;
                case 'txt':
                  preview = Icon(Icons.notes, size: 60, color: Colors.indigo);
                  break;
                default:
                  preview = Text(file.name);
              }
            }
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom + 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(file != null ? 10 : 1000),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (file != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            preview!,
                            SizedBox(width: 8),
                            Expanded(child: Text(file.name)),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                logic.pickedFile = null;
                                logic.attachments = [];
                                logic.update();
                              },
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: logic.msgCtrl,
                              decoration: InputDecoration(
                                hintText: "Enter Message",
                                suffixIcon: IconButton(
                                  tooltip: 'Attach file',
                                  icon: Icon(Icons.attach_file,
                                      color: AppColors.blackColor),
                                  onPressed: logic.pickFile,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16),
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: IconButton(
                              tooltip: 'Send Message',
                              icon: Icon(
                                  Icons.send, color: AppColors.blackColor),
                              onPressed: () {
                                if (logic.msgCtrl.text.isNotEmpty ||
                                    logic.attachments.isNotEmpty) {
                                  logic.sendMessage(
                                    message: logic.msgCtrl.text,
                                    attachments: file != null ? logic
                                        .attachments : [],
                                  );
                                  logic.msgCtrl.clear();
                                  logic.pickedFile = null;
                                  logic.attachments = [];
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      }),
      body: GetBuilder<ChattingCtrl>(
        builder: (logic) { return Container(
            height: MediaQuery.sizeOf(context).height,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.lightGreyColor,
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              controller: logic.scrollController,
              child: Column(
                children: [
                  if (logic.isDataLoading)
                    Center(child: CircularProgressIndicator(
                        color: AppColors.secondaryColor).marginOnly(top: 20))
                  else
                    if (logic.allMsg.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: logic.allMsg.length,
                        itemBuilder: (context, index) {
                          final msg = logic.allMsg[index];
                          final isMyMessage = msg.senderId == AuthData()
                              .userModel?.id;
                          final alignment = isMyMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft;
                          final color = isMyMessage
                              ? AppColors.whiteColor
                              : AppColors.blueColor;
                          final file = msg.attachments?.isNotEmpty == true ? msg
                              .attachments![0] : null;
                          final ext = file?.fileType?.toLowerCase() ?? '';

                          Widget? preview;
                          if (file != null) {
                            if (ext.startsWith('image') ||
                                ['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
                              preview = ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedImageCircle2(
                                  isCircular: false,
                                  imageUrl: file.url,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else {
                              IconData? icon;
                              Color color = isMyMessage ? Colors.blue : Colors
                                  .white;
                              if (ext.contains('pdf'))
                                icon = Icons.picture_as_pdf;
                              else if (ext.contains('mp4'))
                                icon = Icons.videocam;
                              else if (ext.contains('mp3'))
                                icon = Icons.audiotrack;
                              else if (['doc', 'docx'].contains(ext))
                                icon = Icons.description;
                              else if (['xls', 'xlsx'].contains(ext))
                                icon = Icons.grid_on;
                              else if (['ppt', 'pptx'].contains(ext))
                                icon = Icons.slideshow;
                              else if (ext == 'txt') icon = Icons.notes;
                              if (icon != null) {
                                preview = GestureDetector(
                                  onTap: () =>
                                      logic.openNetworkFile(file.url ?? ''),
                                  child: Icon(icon, size: 60, color: color),
                                );
                              }
                            }
                          }

                          return Column(
                            crossAxisAlignment: isMyMessage ? CrossAxisAlignment
                                .end : CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.7,
                                  ),
                                  child: Column(
                                    children: [
                                      if (preview != null) preview,
                                      if (msg.messageType?.toLowerCase() ==
                                          'offer')
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                                AppAssets.couponAppliedLogo,
                                                height: 20,
                                                width: 20,
                                                color: Colors.deepOrange),
                                            addWidth(6),
                                            Text('Offer', style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.deepOrange)),
                                          ],
                                        ).marginOnly(bottom: 20),
                                      if (msg.message?.isNotEmpty == true)
                                        Text(msg.message!, style: TextStyle(
                                            color: AppColors.blackColor)),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: alignment,
                                child: addText200(
                                  formatDateTime(msg.createdAt.toString()),
                                  color: AppColors.blackColor,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ).marginSymmetric(horizontal: 4);
                        },
                      )
                    else
                      Center(child: addText600('No messages found').marginOnly(
                          top: 20)),
                ],
              ),
            ),
          ); },
      )
    );}}





/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:flipzy/Api/get_all_messages_model.dart';
import 'package:flipzy/Screens/userProfile/user_profile.dart';
import 'package:flipzy/controllers/chat_controller.dart';
import 'package:flipzy/controllers/chating_controller.dart';
import 'package:flipzy/custom_widgets/CustomTextField.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';

class ChattingScreen extends StatelessWidget {
  ChattingScreen({super.key});


  final logic = Get.find<ChattingCtrl>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: MediaQuery
            .of(context)
            .size
            .width * 0.3,
        leadingIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),

              onPressed: () {
                Get.back();
              },
              icon: Icon(
                  Icons.arrow_back_ios_outlined, color: AppColors.blackColor,
                  size: 14),),
            CachedImageCircle2(
              isCircular: true,
              height: 40,width: 40,
              imageUrl: logic.receiverData?.profileImage,
            )
          ],
        ).marginOnly(left: 12),
        centerTitle: true,
        titleTxt: "${logic.receiverData?.firstname?.capitalize ?? ""}",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        bottomLine: true,
        actionItems: [
          Container(
            height: 40,width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // color: Colors.red,
            ),
            child: Image.asset(AppAssets.chatCallIC,
              height: 40,width: 40,).marginAll(8),
          ),

          Container(

            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // color: Colors.red,
            ),
            child: SvgPicture.asset(
              AppAssets.threeDotsIc,
              color: AppColors.blackColor,
            ).marginAll(12),
          ),
          addWidth(10)
        ]
      ),
      extendBody: true,

      bottomNavigationBar: SafeArea(
        child: GetBuilder<ChattingCtrl>(builder: (logic) {
          final file = logic.pickedFile;
          final ext = file?.extension?.toLowerCase() ?? '';

          Widget? preview;

          if (file != null) {
            if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
              preview = Image.file(
                File(file.path!),
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              );
            } else if (ext == 'pdf') {
              preview = Icon(Icons.picture_as_pdf, size: 60, color: Colors.red);
            } else if (ext == 'mp4') {
              preview = Icon(Icons.videocam, size: 60, color: Colors.blue);
            } else if (ext == 'mp3') {
              preview = Icon(Icons.audiotrack, size: 60, color: Colors.green);
            } else if (['doc', 'docx'].contains(ext)) {
              preview = Icon(Icons.description, size: 60, color: Colors.white);
            } else if (['xls', 'xlsx'].contains(ext)) {
              preview = Icon(Icons.grid_on, size: 60, color: Colors.lightGreen);
            } else if (['ppt', 'pptx'].contains(ext)) {
              preview = Icon(Icons.slideshow, size: 60, color: Colors.orange);
            } else if (ext == 'txt') {
              preview = Icon(Icons.notes, size: 60, color: Colors.indigo);
            } else {
              preview = Text(file.name);
            }
          }

          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom + 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(file != null ? 10 : 1000),
                color: AppColors.whiteColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (file != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          preview!,
                          SizedBox(width: 8),
                          Expanded(child: Text(file.name)),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              logic.pickedFile = null;
                              logic.attachments = [];
                              logic.update();
                            },
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: logic.msgCtrl,
                            decoration: InputDecoration(
                              hintText: "Enter Message",
                              suffixIcon: IconButton(
                                tooltip: 'Attach file',
                                icon: Icon(Icons.attach_file,
                                    color: AppColors.blackColor),
                                onPressed: () {
                                  logic.pickFile();
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: IconButton(
                            tooltip: 'Send Message',
                            visualDensity: VisualDensity(
                                horizontal: -4, vertical: -4),
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.send, color: AppColors.blackColor),
                            onPressed: () {
                              if (logic.msgCtrl.text.isNotEmpty ||
                                  logic.attachments.isNotEmpty) {
                                logic.sendMessage(
                                  message: logic.msgCtrl.text,
                                  attachments: file != null
                                      ? logic.attachments
                                      : [],
                                );
                                logic.msgCtrl.clear();
                                logic.pickedFile = null;
                                logic.attachments = [];
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        */
/*child: GetBuilder<ChattingCtrl>(
          builder: (logic) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 10),
              child: Container(
                height: 70,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: AppColors.whiteColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: 4,
                        controller: logic.msgCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: AppColors.whiteColor,
                        ),
                        onFieldSubmitted: (_) => logic.sendMessage(message: logic.msgCtrl.text),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(AppAssets.emojiIC, height: 20, width: 20),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => logic.sendMessage(message: logic.msgCtrl.text),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.send, size: 30),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),*/ /*

      ),

      body: GetBuilder<ChattingCtrl>(
        builder: (logic) {
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.lightGreyColor,
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              controller: logic.scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  */
/*Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => UserProfile()),
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.12,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.12,
                          margin: const EdgeInsets.only(left: 15),
                          child: CachedImageCircle2(
                            imageUrl: logic.receiverData?.profileImage,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      addText600(
                          "${logic.receiverData?.firstname?.capitalize ?? ""}",
                          color: AppColors.blackColor, fontSize: 15),
                      const Spacer(),
                      Image.asset(AppAssets.chatCallIC,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.06,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.06),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        AppAssets.threeDotsIc,
                        color: AppColors.blackColor,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.03,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03,
                      ).marginOnly(right: 20),
                    ],
                  ),
                  const SizedBox(height: 10),*/ /*

                  logic.isDataLoading
                      ? const Center(child: CircularProgressIndicator(
                      color: AppColors.secondaryColor))
                      : logic.allMsg.isNotEmpty
                      ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: logic.allMsg.length,
                    itemBuilder: (context, index) {
                      final isMyMessage = logic.allMsg[index].senderId ==
                          AuthData().userModel?.id;
                      final alignment = isMyMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft;
                      final color = isMyMessage
                          ? AppColors.whiteColor
                          : AppColors.blueColor;
                      final msg = logic.allMsg[index];
                      final file = msg.attachments != null && msg.attachments!
                          .isNotEmpty ? msg.attachments![0] : null;
                      final ext = file?.fileType?.toLowerCase() ?? '';

                      Widget? preview;

                      if (file != null) {
                        // if (['jpg','svg', 'jpeg', 'png', 'gif'].contains(ext)) {
                        if (ext.startsWith('image') || [
                          'jpg',
                          'svg',
                          'jpeg',
                          'png',
                          'gif'
                        ].contains(ext)) {
                          preview = ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedImageCircle2(isCircular: false,
                                imageUrl: file.url,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover),
                          );
                        } else if (ext.contains('pdf')) {
                          preview = GestureDetector(
                              onTap: () {
                                logic.openNetworkFile('${file.url}');
                              },
                              child: Icon(Icons.picture_as_pdf, size: 60,
                                  color: Colors.red));
                        } else if (ext.contains('mp4')) {
                          preview = GestureDetector(
                              onTap: () {
                                logic.openNetworkFile('${file.url}');
                              },
                              child: Icon(Icons.videocam, size: 60,
                                  color: isMyMessage ? Colors.blue : Colors
                                      .white));
                        } else if (ext.contains('mp3')) {
                          preview = GestureDetector(
                              onTap: () {
                                logic.openNetworkFile('${file.url}');
                              },
                              child: Icon(Icons.audiotrack, size: 60,
                                  color: isMyMessage ? Colors.blue : Colors
                                      .white));
                        } else if (ext.contains('.document') ||
                            ['doc', 'docx'].contains(ext)) {
                          preview = GestureDetector(
                            onTap: () {
                              logic.openNetworkFile('${file.url}');
                            },
                            child: Icon(Icons.description, size: 60,
                                color: isMyMessage ? Colors.blue : Colors
                                    .white),
                          );
                        } else if (['xls', 'xlsx'].contains(ext)) {
                          preview = GestureDetector(
                            onTap: () {
                              logic.openNetworkFile('${file.url}');
                            },
                            child: Icon(Icons.grid_on, size: 60,
                                color: isMyMessage ? Colors.blue : Colors
                                    .white),
                          );
                        } else if (['ppt', 'pptx'].contains(ext)) {
                          preview = GestureDetector(
                            onTap: () {
                              logic.openNetworkFile('${file.url}');
                            },
                            child: Icon(Icons.slideshow, size: 60,
                                color: isMyMessage ? Colors.blue : Colors
                                    .white),
                          );
                        } else if (ext == 'txt') {
                          preview = GestureDetector(
                            onTap: () {
                              logic.openNetworkFile('${file.url}');
                            },
                            child: Icon(Icons.notes, size: 60,
                                color: isMyMessage ? Colors.blue : Colors
                                    .white),
                          );
                        }
                        // else {
                        //   preview = Text(file.url!);
                        // }
                      }
                      return Column(
                        crossAxisAlignment: isMyMessage
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.7, // Limit width if text is long
                              ),
                              child: Column(
                                children: [
                                  if(msg.attachments != null &&
                                      msg.attachments!.isNotEmpty)
                                    preview ?? SizedBox(),

                                  if(msg.messageType?.toLowerCase() == 'offer')
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(AppAssets.couponAppliedLogo,
                                            height: 20,
                                            width: 20,
                                            color: Colors.deepOrange),
                                        addWidth(6),
                                        Text(
                                          'Offer',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.deepOrange
                                          ),
                                        ),
                                      ],
                                    ).marginOnly(bottom: 20),

                                  if(msg.message!.isNotEmpty)
                                    Text(
                                      '${msg.message}',
                                      style: TextStyle(
                                          color: AppColors.blackColor,
                                          fontFamily: ''
                                      ),
                                    ),
                                  */
/*addText400(
                                    logic.allMsg[index].message ?? "",
                                    textAlign: TextAlign.left,
                                    color: AppColors.blackColor,
                                    fontSize: 15,
                                  ),*/ /*

                                ],
                              ),
                            ),
                          ),

                          Align(
                            alignment: alignment,
                            child: addText200(
                              formatTime(
                                  logic.allMsg[index].createdAt.toString()),
                              color: AppColors.blackColor,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ).marginSymmetric(horizontal: 4);
                    },
                  )
                      : Center(child: addText600('No messages found')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
*/

import 'dart:io';

import 'package:flipzy/Api/support_all_msg_model.dart';
import 'package:flipzy/controllers/support_controller.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportChatScreen extends StatelessWidget {
  final SupportController controller = Get.put(SupportController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.blackColor,
              )),
          title: addText500('Support Chat',
              color: AppColors.blackColor,
              fontSize: 18,
              fontFamily: 'Manrope')),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<SupportController>(builder: (logic) {
              return logic.isDataLoading
                  ? Center(
                  child: CircularProgressIndicator(
                      color: AppColors.secondaryColor))
                  : logic.allMsg.isNotEmpty
                  ? ListView.builder(
                padding: EdgeInsets.all(10),
                controller:
                controller.scrollController, // MUST be set!
                itemCount: logic.allMsg.length,
                itemBuilder: (context, index) {
                  final msg = logic.allMsg[index];
                  final isMyMessage = logic.allMsg[index].senderId == AuthData().userModel?.id;
                  final file = msg.attachments!=null && msg.attachments!.isNotEmpty?msg.attachments![0]:null;
                  final ext = file?.fileType?.toLowerCase() ?? '';

                  Widget? preview;

                  if (file != null) {
                    // if (['jpg','svg', 'jpeg', 'png', 'gif'].contains(ext)) {
                    if (ext.startsWith('image') || ['jpg','svg', 'jpeg', 'png', 'gif'].contains(ext)) {
                      preview = ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedImageCircle2(isCircular: false,imageUrl: file.url,height: 80,
                          width: 80,
                          fit: BoxFit.cover),
                      );
                    } else if (ext.contains('pdf') ) {
                      preview = GestureDetector(
                          onTap: (){
                            logic.openNetworkFile('${file.url}');
                          },
                          child: Icon(Icons.picture_as_pdf, size: 60, color: Colors.red));
                    } else if (ext.contains('mp4') || ext=='mp4') {
                      preview = GestureDetector(
                          onTap: (){
                            logic.openNetworkFile('${file.url}');
                          },
                          child: Icon(Icons.videocam, size: 60, color: isMyMessage? Colors.white:Colors.blue));
                    } else if (ext.contains('mp3')) {
                      preview = GestureDetector(
                          onTap: (){
                            logic.openNetworkFile('${file.url}');
                          },
                          child: Icon(Icons.audiotrack, size: 60, color: Colors.green));
                    } else if (ext.contains('.document') || ['doc', 'docx'].contains(ext)) {
                      preview = GestureDetector(
                        onTap: () {
                          logic.openNetworkFile('${file.url}');
                        },
                        child: Icon(Icons.description, size: 60, color: isMyMessage? Colors.white:Colors.blue),
                      );
                    } else if (['xls', 'xlsx'].contains(ext)) {
                      preview = GestureDetector(
                        onTap: () {
                          logic.openNetworkFile('${file.url}');
                        },
                        child: Icon(Icons.grid_on, size: 60, color: Colors.lightGreen),
                      );
                    } else if (['ppt', 'pptx'].contains(ext)) {
                      preview = GestureDetector(
                        onTap: () {
                          logic.openNetworkFile('${file.url}');
                        },
                        child: Icon(Icons.slideshow, size: 60, color: Colors.orange),
                      );
                    } else if (ext == 'txt') {
                      preview = GestureDetector(
                        onTap: () {
                          logic.openNetworkFile('${file.url}');
                        },
                        child: Icon(Icons.notes, size: 60, color: Colors.indigo),
                      );
                    }
                    // else {
                    //   preview = Text(file.url!);
                    // }
                  }



                  return Column(
                    crossAxisAlignment:
                    msg.senderId == AuthData().userModel?.id
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(12),
                        constraints: BoxConstraints(
                            maxWidth:
                            MediaQuery
                                .of(context)
                                .size
                                .width *
                                0.7),
                        decoration: BoxDecoration(
                          color:
                          msg.senderId == AuthData().userModel?.id
                              ? Colors.blue
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          msg.senderId == AuthData().userModel?.id
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if(msg.attachments!=null && msg.attachments!.isNotEmpty)
                              preview??SizedBox(),
                            if(msg.message!.isNotEmpty)
                            Text(
                              '${msg.message}',
                              style: TextStyle(
                                color: msg.senderId ==
                                    AuthData().userModel?.id
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      addText400(formatTime('${msg.createdAt}'),
                          fontSize: 10),
                      if (msg.session == false)
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.all(12),
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.7),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Session Expired',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              )
                  : Center(child: addText600('No messages found'));
            }),
          ),
          Divider(height: 1),
          GetBuilder<SupportController>(builder: (logic) {
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
                preview = Icon(Icons.description, size: 60, color: Colors.blueGrey);
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

            return Column(
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
                            logic.pickedFile=null;
                            logic.attachments = [];
                            logic.update();
                          },
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.msgCtrl,
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            suffixIcon: IconButton(
                              tooltip: 'Attach file',
                              icon: Icon(Icons.attach_file, color: AppColors.blackColor),
                              onPressed: () {
                                controller.pickFile();
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      IconButton(
                        tooltip: 'Send Message',
                        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.send, color: AppColors.primaryColor),
                        onPressed: () {
                          print('hitted0');
                          if(controller.msgCtrl.text.isNotEmpty || logic.attachments.isNotEmpty){
                            print('hitted34');
                            controller.sendMessage(
                              message: controller.msgCtrl.text,
                              attachments: file != null ? logic.attachments : [],
                            );
                            controller.msgCtrl.clear();
                            controller.pickedFile=null;
                            controller.attachments = [];
                          }else{
                            print('hitted12 ${logic.attachments.isNotEmpty}');

                            print('hitted123 ${logic.attachments.isNotEmpty}');
                            print('hitted123 ${logic.attachments.length}');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),



          /*   GetBuilder<SupportController>(builder: (logic) {
            // final file = logic.pickedFile;
            // if (file == null) return SizedBox();
            //
            // final ext = file.extension?.toLowerCase() ?? '';
            //
            //
            // Widget preview;
            // if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
            //   preview = Image.file(
            //     File(file.path!),
            //     height: 100,
            //     width: 100,
            //     fit: BoxFit.cover,
            //   );
            // } else if (ext == 'pdf') {
            //   preview = Icon(Icons.picture_as_pdf, size: 60, color: Colors.red);
            // } else if (ext == 'mp4') {
            //   preview = Icon(Icons.videocam, size: 60, color: Colors.blue);
            // } else if (ext == 'mp3') {
            //   preview = Icon(Icons.audiotrack, size: 60, color: Colors.green);
            // } else {
            //   preview = Text(file.name);
            // }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  // preview,
                  // SizedBox(width: 4),
                  Expanded(
                    child: TextField(
                      controller: controller.msgCtrl,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        suffixIcon: IconButton(
                          tooltip: 'Attach file',

                          icon: Icon(
                              Icons.attach_file, color: AppColors.blackColor),
                          onPressed: () {
                            controller.pickFile();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  IconButton(
                    tooltip: 'Send Message',
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.send, color: AppColors.primaryColor),
                    onPressed: () {
                      // Toggle true/false to simulate "me" or "other"
                      controller.sendMessage(message: controller.msgCtrl.text,
                          attachments: []);
                      // controller.sendMessage(_textController.text, isMe: false);
                      _textController.clear();
                    },
                  ),
                ],
              ),
            );
          }),*/
        ],
      ),
    );
  }
}
/*if (msg.fileType == 'pdf') {
  return InkWell(
    onTap: () => openFile(msg.filePath), // Implement this
    child: Text("📄 ${msg.message}", style: TextStyle(color: Colors.blue)),
  );
} else if (msg.fileType == 'mp4') {
  return InkWell(
    onTap: () => openFile(msg.filePath),
    child: Text("🎥 Video: ${msg.message}", style: TextStyle(color: Colors.blue)),
  );
} else if (msg.fileType == 'mp3') {
  return InkWell(
    onTap: () => openFile(msg.filePath),
    child: Text("🎵 Audio: ${msg.message}", style: TextStyle(color: Colors.blue)),
  );
} else {
  return Text(msg.message ?? '');
}*/
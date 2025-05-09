import 'dart:developer' as developer;
import 'dart:io';
import 'package:flipzy/Api/chat_with_users_model.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flipzy/Api/api_models/support_file_upload_model.dart';
import 'package:flipzy/Api/repos/support_upload_file_repo.dart';
import 'package:flipzy/Api/support_all_msg_model.dart';
import 'package:flipzy/Api/support_msg_receive_model.dart';
import 'package:flipzy/resources/app_socket.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'chat_controller.dart';

class ChattingCtrl extends GetxController{
  List<SupportAllMsgChatModel> allMsg = [];

  final ScrollController scrollController = ScrollController();
  TextEditingController msgCtrl = TextEditingController();
  // final SocketService socketService = SocketService();
  SocketService? socketService;
  bool isDataLoading = false;
  bool endReceiveMsg = false;
  ChatWithUser? receiverData;




  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    if(Get.arguments!=null){
      receiverData = Get.arguments['receiver_data'];
      socketService = Get.arguments['socket_instance'];
      // socketService?.connect();
      if(receiverData!=null){
        connectWithSupport();
      }
    }
  }


  connectWithSupport({senderId}){
    developer.log('lokesh:::chat:::::$socketService');
    developer.log('lokesh:::chat:::::${AuthData().userModel?.id}');
    String? userID = AuthData().userModel?.id;
    isDataLoading = true;
    final requestData = {
      'userId': userID,
      'reciverid': receiverData?.userId,
    };
    developer.log('Requesting threads list with data: $requestData');

    socketService?.socket?.emit("CONNECT",{"loginId": senderId} );
    socketService?.socket?.emit('joinRoom', requestData);
    socketService?.socket?.emit('markRead', {
      "receiverId":receiverData?.userId,
      "senderId": userID
    });
    listenReceiveMessage(msgCtrl.text);
    socketService?.socket?.emit('getAllMessages', {
      'sender_id': userID,
      'receiver_id':  receiverData?.userId,
    });
    // socketService.socket?.on('connect_error', (error) {
    //   developer.log('Connection Error inside support: $error');
    //    showToastError('$error');
    //    isDataLoading = false;
    //    allMsg = [];
    //    update();
    // });

    socketService?.socket?.on('getAllMessages', (data) {
      developer.log('GET-ALL-MESSAGES START:\n$data\n::END');

      if (data != null && data is List) {
        allMsg = data.map((item) => SupportAllMsgChatModel.fromJson(item)).toList();

        if (allMsg.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollDown();
          });
        }
        developer.log('GET-ALL-MESSAGES MODEL-START:\n${allMsg.length}\n::MODEL-END');
      } else {
        developer.log('Data is null or not a List');
      }

      isDataLoading = false;
      update();
    });
  }
  List<SupportReceiveMsgModel> addToMsg = [];

  sendMessage({String? message,List? attachments, String? messageType}){
    final requestData = {
      'sender_id': AuthData().userModel?.id,
      'receiver_id':  receiverData?.userId,
      'message': message,
      'messageType': messageType, // for make offer
      'attachments': attachments !=null && attachments.isNotEmpty ? attachments : [],

    };
    developer.log('Requesting Send-Message with data: $requestData');


    socketService?.socket?.emit('sendMessage', requestData);
    developer.log('EndReceiveMsg: Outer::$endReceiveMsg');
    /*if(endReceiveMsg==true){
      developer.log('if case endReceiveMsg::$endReceiveMsg');
      print('if case endReceiveMsg::$endReceiveMsg');
      allMsg.add(SupportAllMsgChatModel(
        id: '',
        chatRoomId: '',
        senderId: AuthData().userModel?.id,
        receiverId: '',
        message: message,
        messageType: 'Text',
        session: true,
        isRead: false,
        attachments: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
      update();
      WidgetsBinding.instance.addPostFrameCallback((_) {scrollDown();});
    } else {

      socketService.socket?.on('receiveMessage', (data) {
        developer.log('else case endReceiveMsg::$endReceiveMsg');
        print('else case endReceiveMsg::$endReceiveMsg');
        developer.log('receiveMessage-MESSAGES START:\n$data\n::END');
        if (data != null) {
          endReceiveMsg = true;
          developer.log('kyu nhi aaya uiop');
          print('kyu nhi aaya uiop');
          SupportReceiveMsgModel addMsg = SupportReceiveMsgModel.fromJson(data);
          developer.log('addMsg-START:\n${addMsg}\n::MODEL-END');
          allMsg.add(SupportAllMsgChatModel(
            id: addMsg.id,
            chatRoomId: addMsg.chatRoomId,
            senderId: addMsg.senderId,
            receiverId: addMsg.receiverId,
            message: addMsg.message,
            messageType: addMsg.messageType,
            session: addMsg.session,
            isRead: addMsg.isRead,
            attachments: addMsg.attachments,
            createdAt: addMsg.createdAt,
            updatedAt: addMsg.updatedAt,
          ));
          update();
          developer.log('reeive-MESSAGES MODEL-START:\n${allMsg.length}\n::MODEL-END');
          WidgetsBinding.instance.addPostFrameCallback((_) {scrollDown();});
        } else {
          developer.log('Data is null or not a List');
        }
        isDataLoading = false;
        update();
      });
    }*/

    update();
    msgCtrl.clear();
  }

  listenReceiveMessage(String? message){
    if(endReceiveMsg==true){
      developer.log('if case endReceiveMsg::$endReceiveMsg');
      print('if case endReceiveMsg::$endReceiveMsg');
      allMsg.add(SupportAllMsgChatModel(
        id: '',
        chatRoomId: '',
        senderId: AuthData().userModel?.id,
        receiverId: '',
        message: message,
        messageType: 'Text',
        session: true,
        isRead: false,
        attachments: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
      update();
      WidgetsBinding.instance.addPostFrameCallback((_) {scrollDown();});
    }
    else { socketService?.socket?.on('receiveMessage', (data) {
      developer.log('else case endReceiveMsg::$endReceiveMsg');
      print('else case endReceiveMsg::$endReceiveMsg');
      developer.log('receiveMessage-MESSAGES START:\n$data\n::END');
      if (data != null) {
        endReceiveMsg = true;
        developer.log('kyu nhi aaya uiop');
        print('kyu nhi aaya uiop');
        SupportReceiveMsgModel addMsg = SupportReceiveMsgModel.fromJson(data);
        developer.log('addMsg-START:\n${addMsg}\n::MODEL-END');
        allMsg.add(SupportAllMsgChatModel(
          id: addMsg.id,
          chatRoomId: addMsg.chatRoomId,
          senderId: addMsg.senderId,
          receiverId: addMsg.receiverId,
          message: addMsg.message,
          messageType: addMsg.messageType,
          session: addMsg.session,
          isRead: addMsg.isRead,
          attachments: addMsg.attachments,
          createdAt: addMsg.createdAt,
          updatedAt: addMsg.updatedAt,
        ));
        update();
        developer.log('reeive-MESSAGES MODEL-START:\n${allMsg.length}\n::MODEL-END');
        WidgetsBinding.instance.addPostFrameCallback((_) {scrollDown();});
      } else {
        developer.log('Data is null or not a List');
      }
      isDataLoading = false;
      update();
    }); }
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  PlatformFile? pickedFile;
  List<SupportUpload> attachments = [];
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'mp3', 'pdf', 'jpg', 'jpeg', 'png', 'gif', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt'],
    );

    if (result != null && result.files.isNotEmpty) {
      // final file = result.files.first;
      // sendFile(file);
      pickedFile = result.files.first;


      print('object::::${result.files.first.extension}');

      List<PlatformFile> supportFile = [];
      supportFile.add(pickedFile!);
      update();
      showLoader(true);
      supportUploadApi(file_type: pickedFile?.extension,supportFile: supportFile).then((value){
        showLoader(false);
        if(value.status==true){
          attachments.add(value.data!);
          update();
        }
      });
    }
  }

  Future<void> openNetworkFile(String url) async {
    // Download the file
    showLoader(true);
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    // Get a local path
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/tempfile.mp4');

    // Write the file
    await file.writeAsBytes(bytes);

    showLoader(false);
    // Open the file
    OpenFile.open(file.path);
  }

  void sendFile(PlatformFile file) {
    // Send the file to the backend or socket
    // You may also need to upload and get a URL

    allMsg.add(SupportAllMsgChatModel(
      message: file.name,
      // fileType: file.extension,
      // filePath: file.path
      senderId: AuthData().userModel?.id,
      createdAt: DateTime.now(),
      session: true,
    ));
    update();
  }

}
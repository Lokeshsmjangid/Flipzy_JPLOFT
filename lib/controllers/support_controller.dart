import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flipzy/Api/api_models/support_file_upload_model.dart';
import 'package:flipzy/Api/repos/support_upload_file_repo.dart';
import 'package:flipzy/Api/support_all_msg_model.dart';
import 'package:flipzy/Api/support_msg_receive_model.dart';
import 'package:flipzy/resources/app_socket.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportController extends GetxController {
  List<SupportAllMsgChatModel> allMsg = [];

  final ScrollController scrollController = ScrollController();
  TextEditingController msgCtrl = TextEditingController();
  final SocketService socketService = SocketService();
  bool isDataLoading = false;
  bool endReceiveMsg = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    socketService.connect();
    connectWithSupport();
  }


  connectWithSupport({senderId}){
    developer.log('lokesh:::chat:::::$socketService');
    developer.log('lokesh:::chat:::::${AuthData().userModel?.id}');
    String? userID = AuthData().userModel?.id;
    isDataLoading = true;
    final requestData = {
      'userId': userID,
      'reciverid': receiver_id,
    };
    developer.log('Requesting threads list with data: $requestData');

    socketService.socket?.emit("CONNECT",{"loginId": senderId} );
    socketService.socket?.emit('joinRoom', requestData);
    listenReceiveMessage(msgCtrl.text);
    socketService.socket?.emit('getAllMessages', {
      'sender_id': userID,
      'receiver_id': receiver_id,
    });

    socketService.socket?.on('getAllMessages', (data) {
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
  String receiver_id = 'Admin';
  sendMessage({String? message,List? attachments}){
    final requestData = {
      'sender_id': AuthData().userModel?.id,
      'receiver_id': receiver_id,
      'message': message,
      'attachments': attachments !=null && attachments.isNotEmpty ? attachments : [],

    };
    developer.log('Requesting Send-Message with data: $requestData');


    socketService.socket?.emit('sendMessage', requestData);
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
    else { socketService.socket?.on('receiveMessage', (data) {
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
    }}


  void scrollDown() {
    if (scrollController.hasClients) // to remove _positions.isNotEmpty console error
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

  /*Future<void> openNetworkFile(String url) async { // working code
    // Download the file
    showLoader(true);
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;



    // Get a local path
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/tempfile.mp4');

    // Write the file
    await file.writeAsBytes(bytes);

    // Open the file
    showLoader(false);
    OpenFile.open(file.path);
  }*/

  Future<void> openNetworkFile(String url) async {
    showLoader(true);

    try {
      final uri = Uri.parse(url);
      String fileName = p.basename(uri.path);
      String extension = p.extension(fileName).replaceFirst('.', '').toLowerCase();

      // File types to redirect to browser
      final browserExtensions = [
        'pdf', 'jpg', 'jpeg', 'png', 'gif',
        'doc', 'docx', 'xls', 'xlsx',
        'ppt', 'pptx', 'txt'
      ];

      // If the extension matches, launch in browser
      if (browserExtensions.contains(extension)) {
        showLoader(false);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          flipzyPrint(message: 'Could not launch $url');
        }
        return;
      }

      // Otherwise, proceed to download and open locally
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        showLoader(false);
        flipzyPrint(message: 'Failed to download file. Status code: ${response.statusCode}');
        return;
      }

      final bytes = response.bodyBytes;

      if (fileName.isEmpty || !fileName.contains('.')) {
        fileName = 'downloaded_file';
        final contentType = response.headers['content-type'];
        if (contentType != null && contentType.contains('/')) {
          final ext = contentType.split('/').last;
          fileName += '.$ext';
        } else {
          fileName += '.tmp';
        }
      }

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes);

      final result = await OpenFile.open(file.path);
      flipzyPrint(message: 'OpenFile result: ${result.message}');
    } catch (e) {
      flipzyPrint(message: 'Error: $e');
    } finally {
      showLoader(false);
    }
  }

  void sendFile(PlatformFile file) {


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

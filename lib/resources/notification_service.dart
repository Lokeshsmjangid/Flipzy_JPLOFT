
import 'dart:convert';
import 'dart:io';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'auth_data.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

void initMessaging() async {
  // Android Initialization Settings
  var initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_launcher');

  // iOS Initialization Settings (Updated to DarwinInitializationSettings)
  var initializationSettingsDarwin = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    // onDidReceiveLocalNotification: onDidReceiveLocalNotification,

  );

  // Combine Android and iOS initialization settings
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  // Initialize the plugin
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    // onSelectNotification: onSelectNotification,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      onSelectNotification(response.payload);
      if (response.payload != null) {
        // Navigate to a new route
        // Navigator.pushNamed(context, notificationResponse.payload!);
        print("Payload: ${response.payload}");
      }
    },
  );

  // Set iOS foreground notification presentation options
  if (Platform.isIOS) {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }



  // Listen for foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {

    flipzyPrint(message: 'Message data onMessage.listen: ${remoteMessage.data}');
    flipzyPrint(message: ' ${remoteMessage.notification?.body}');

    String notificationTitle = remoteMessage.notification?.title ?? "";
    String notificationBody = remoteMessage.notification?.body ?? "";

    showNotification(notificationTitle, notificationBody, remoteMessage.data);
    // print("Received a message in foreground!");
    //
    // final data = remoteMessage.data;
    // leviconPrint(message: 'Notification payload data:\n $data \n');
    // leviconPrint(message: 'Notification payload data:\n ${data.runtimeType} \n');
    //
    // if (data['click_action'] == 'ride_book') {
    //   Get.toNamed(AppRoutes.rideDetailScreen, arguments: {'screen': 'all_ride', 'ride_id': 24});
    // }


  });

  // Listen for messages when the app is opened from the background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("A new onMessageOpenedApp event was published!");
    // final notificationType = json.decode(message.data["notification_type"]);
    // final data = json.decode(message.data["data"]);
    final data = message.data;
    // Handle the notification type and data as needed


    flipzyPrint(message: 'Notification payload data:\n ${data} \n');
    flipzyPrint(message: 'Notification payload data:\n ${data.runtimeType} \n');

    handleNavigationBasedOnData(message.data);

  });

  // Register the background handler
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  print('Message data onMessage.listen: ${message.data}');
  print('Message notification: ${message.notification?.body}');
}

void showNotification(String title, String body, Map<String, dynamic> data) async {
  var androidChannel = AndroidNotificationChannel(
    'firebase-push-notification',
    'firebase-push-notification-channel',
    description: 'Channel Description',
    importance: Importance.high,
  );

  // Create the notification channel (for Android)
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidChannel);

  var notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      channelDescription: androidChannel.description,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@drawable/ic_launcher',
    ),
    iOS: DarwinNotificationDetails(),
  );


  // Define the data you want to pass

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
    payload: jsonEncode(data),
  );
}

// Handle when a local notification is selected (optional)
// Future onSelectNotification(String? payload) async {
//   print('Notification clicked with payload: $payload');
// }
Future onSelectNotification(String? payload) async {
  if (payload != null) {
    Map<String, dynamic> data = jsonDecode(payload);
    handleNavigationBasedOnData(data);
  }
}

void handleNavigationBasedOnData(Map<String, dynamic> data) {

  flipzyPrint(message: 'ddffdfdf ${data}');

  /*if (data['click_action'] == 'ride_book') {
    Get.toNamed(AppRoutes.rideDetailScreen, arguments: {'screen': 'all_ride', 'ride_id': int.parse('${data['id']}')});
  }
  else if(data['click_action'] =='chat_screen'){
    final logic = Get.find<InboxController>();
    Map<String, dynamic>? driverList;
    if(data['id']!=null){
      driverList = jsonDecode('${data['id']}');
    }
    Get.toNamed(AppRoutes.chatDetailScreen,
        arguments: {
          'trip_from':'${driverList!['ride_source_city']}',
          'trip_to':'${driverList['ride_destination_city']}',
          'trip_date':'${driverList['created_at']}',
          'driver_name':driverList['is_driver']==false?'${driverList['driver_name']}':'${driverList['user_name']}',
          'driver_id':driverList['is_driver']==false?driverList['driver_id']:driverList['user_id'],
          'request_id': driverList['id'],
          'room_id': driverList['room_id'],
          'mobile_number': driverList['is_driver']==false?driverList['driver_phone_number']:driverList['user_phone_number'],
          'soket_object': logic.socketService
        })?.then((value){
      logic.isLoading = false;
      logic.getChatUsers(senderId: AuthData().userModel?.id);
      logic.socketService.socket?.emit('READ_MESSAGE', {"receiver_id":driverList!['is_driver']==true?driverList['driver_id']:driverList['user_id'],"room_id":"${driverList['room_id']}"});
    });
  }*/
}

// iOS-specific function for handling local notifications while the app is in the foreground
void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
  print('Local notification received: $title, $body');
}

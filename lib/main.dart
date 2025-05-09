

import 'dart:io';


import 'package:flipzy/resources/notification_service.dart';
import 'package:get/get.dart';
import 'resources/app_color.dart';
import 'resources/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'resources/dependencies.dart' as de;
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async{

  await GetStorage.init();
  await de.init();
  if(Platform.isIOS){ await Firebase.initializeApp();}
  else { await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: 'AIzaSyAVPBSJcYdsTmeJbZ4-1dkgOIiFZcxGB4M',
      appId: '1:2439299823:android:52a7b92e98b26c5e51d11a',
      messagingSenderId: '2439299823',
      projectId: 'flipzy-nigeria-c6cb8'));}
  initMessaging();
  runApp(const MyApp());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GestureDetector(
          onTap: () {
            if (FocusManager.instance.primaryFocus!.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: GetMaterialApp(
            title: 'Flipzy',
            locale: Get.deviceLocale,
            getPages: AppRoutes.getRoute,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splashScreen,
            defaultTransition: Transition.noTransition,
            theme: ThemeData(
                primarySwatch: primaryColorShades,
                fontFamily: 'OpenSans',
                useMaterial3: false
            ),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Set the desired text scaling factor here
                child: child!,
              );
            },
          ),
        );
      },
    );
  }
}


// command to generate SHA key
// keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
// firebase hosting for dynamic link---> levicon-carpooling-32563.web.app



// latest code

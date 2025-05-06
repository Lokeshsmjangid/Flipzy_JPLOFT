import 'package:flipzy/Screens/auth_screens/login_screen.dart';
import 'package:flipzy/Screens/chats/chat_listing.dart';
import 'package:flipzy/Screens/complete_seller_info.dart';
import 'package:flipzy/Screens/custom_drawer.dart';
import 'package:flipzy/Screens/favourite_screen.dart';
import 'package:flipzy/Screens/manage_business.dart';
import 'package:flipzy/Screens/order_management_screens/order_history_screen.dart';
import 'package:flipzy/Screens/order_management_screens/order_list_screen.dart';
import 'package:flipzy/Screens/product_management.dart';
import 'package:flipzy/Screens/userProfile/user_profile.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/home_screen.dart';

class BottomBarController extends GetxController{

  final GlobalKey<ScaffoldState> key = GlobalKey();// for app drawer



  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    // OrderListScreen(),
    HomeScreen(),
    ChatListingScreen(),
    CompleteSellerInfo(fromScreen: "DashBoard"),
    FavouriteScreen(),
    UserProfile(fromScreen: "DashBoard",),
  ];
  void onItemTapped(int index) {
      selectedIndex = index;
      update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}
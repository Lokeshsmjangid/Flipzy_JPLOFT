import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'app_color.dart';
import 'text_utility.dart';

backButton({void Function()? onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          // color: Colors.red,
            shape: BoxShape.circle
        ),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.arrow_back,color: AppColors.blackColor))),
  );
}

backAppBar({void Function()? onTapBack,String? title}){
  return Column(
    children: [
      Row(
        children: [
          InkWell(
            onTap: onTapBack,
            child: Row(

              children: [
                Icon(Icons.arrow_back_ios_new,size: 16),
                addWidth(4),
                addText400('Back',fontFamily: 'Poppins',fontSize: 12),
              ],
            ),
          ),
          addWidth(54),
          addText700(title??'Order Management',fontFamily: 'Manrope',fontSize: 16),
        ],
      ).marginSymmetric(horizontal: 16),
      addHeight(20),
      Divider(height: 0),
    ],
  );
}


Widget BorderedContainer({double padding = 10,double radius = 18, bool isBorder = true,
  Color bGColor = AppColors.whiteColor,Color borderColor= AppColors.containerBorderColor1,Widget? child}){ return Container(
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
        color: bGColor,
        border: isBorder?Border.all(color: borderColor):null,
        borderRadius: BorderRadius.circular(radius)
    ),
    child: child,
  );}


// cahed network image
Widget CachedImageCircle2({String? imageUrl, double? height, double? width, bool isCircular = true,BoxFit fit = BoxFit.cover}) {
  return Container(
    height: height ?? 150,
    width: width ?? 150,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
      shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
    ),
    child: imageUrl != null && imageUrl.toLowerCase().endsWith('.svg')
        ? SvgPicture.network(
      imageUrl,
      height: height ?? kMinInteractiveDimension,
      width: width ?? kMinInteractiveDimension,
      fit: BoxFit.cover,
      placeholderBuilder: (context) => Center(
        child: CircularProgressIndicator(color: Colors.blue.withOpacity(0.20)),
      ),
    )
        : Image.network(
      imageUrl ?? '',
      fit: fit,
      height: height ?? kMinInteractiveDimension,
      width: width ?? kMinInteractiveDimension,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.secondaryColor.withOpacity(0.20),
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        return const Center(
          child: Icon(Icons.error, color: Colors.red),
        );
      },
    ),
  );
}

// Print
flipzyPrint({required String message}){
  return log('$message');
}

// toast
showToast(String msg){ return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0
);}

showToastError(String msg){ return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
);}


String formatDateTime(String dateTimeString) { // Last Today at 9:42 AM
  DateTime dateTime = DateTime.parse(dateTimeString).toLocal(); // Convert to local time
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = today.subtract(Duration(days: 1));

  String formattedTime = DateFormat.jm().format(dateTime); // e.g., "9:42 AM"

  if (dateTime.isAfter(today)) {
    return "Today at $formattedTime";
  } else if (dateTime.isAfter(yesterday)) {
    return "Yesterday at $formattedTime";
  } else {
    return DateFormat('MMM d, yyyy \'at\' h:mm a').format(dateTime); // e.g., "Mar 17, 2025 at 9:42 AM"
  }
}

String formatDate({String? dateTimeString}) {


  if(dateTimeString!=null){
    // String isoDate = "2025-03-31T09:04:26.502Z";
    DateTime dateTime = DateTime.parse(dateTimeString.toString());
    String formattedDate = DateFormat("dd/MM/yyyy").format(dateTime);
    return formattedDate;
  } else {
    return '';
  } // Output: 31/03/2025
}

String formatTime(String isoString) {
  DateTime dateTime = DateTime.parse(isoString).toLocal(); // toLocal() for local timezone
  String formattedTime = DateFormat.jm().format(dateTime); // e.g., 10:48 AM
  return formattedTime;
}

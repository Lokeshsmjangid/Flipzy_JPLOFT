import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/app_color.dart';


PreferredSizeWidget customAppBar({double? leadingWidth , Widget? leadingIcon, Color? backgroundColor, String? titleTxt , Color? titleColor, double? titleFontSize,
  FontWeight? titleFontWeigth, bool? centerTitle, List<Widget>? actionItems, bool? bottomLine,
})
{
  return AppBar(
    leadingWidth: leadingWidth ?? 0,
    leading: leadingIcon ?? const IgnorePointer(),
    backgroundColor: backgroundColor ?? AppColors.whiteColor,
    title: Text(
      titleTxt ?? "",
      style: TextStyle(
        color: titleColor ?? Color(0xFF241F1F),
        fontSize: titleFontSize ?? 16,
        fontFamily: 'Manrope',
        fontWeight: titleFontWeigth ?? FontWeight.w700,
        letterSpacing: -1,
      ),
    ),
    centerTitle: centerTitle ?? false,
    actions: actionItems,
    shadowColor: Colors.transparent,
    // clipBehavior: Clip.none,
    bottom: bottomLine ?? true ? PreferredSize(
      preferredSize: const Size.fromHeight(-2.0), // Height of the line
      child: Container(
        color: AppColors.greyColor, // Line color
        height: 1.0, // Line thickness
      ),
    ) : PreferredSize(
      preferredSize: const Size.fromHeight(1.0), // Height of the line
      child: Container(),
    ),
  );
}
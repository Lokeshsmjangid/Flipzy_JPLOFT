import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';

class CustomBackAppBar extends StatelessWidget implements PreferredSizeWidget{
  void Function()? onTapBack;
  String? title;
  CustomBackAppBar({super.key,this.onTapBack,this.title});



  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(48),
      child: AppBar(
        /*leading: Row(
          children: [
            GestureDetector(
              onTap: onTapBack,
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new,size: 16),
                  addWidth(4),
                  addText400('Back',fontFamily: 'Poppins',fontSize: 14),
                ],
              ),
            ),
            // addWidth(54),
      
          ],
        ),*/
        title: addText700(title??'',fontFamily: 'Manrope'),
        centerTitle: true,
      
      ),
    );
  }
}

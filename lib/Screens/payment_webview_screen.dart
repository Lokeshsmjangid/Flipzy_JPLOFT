import 'dart:developer';
import 'package:flipzy/controllers/payment_controller.dart';
import 'package:flipzy/custom_widgets/customAppBar.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {

  PaymentWebView({super.key,});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {

  final ctrl = Get.find<PaymentController>();

  @override
  void initState() {
    super.initState();
  }

  onPageFinished(url) {
    log('Finished Url:==>$url');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(
        backgroundColor: AppColors.bgColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.3 ,
        leadingIcon: IconButton(
            onPressed: (){
              Get.back();},
            icon: Row(
              children: [
                Icon(Icons.arrow_back_ios_outlined, color: AppColors.blackColor,size: 14,),
                addText400("Back", color: AppColors.blackColor,fontSize: 12,fontFamily: 'Poppins'),
              ],
            ).marginOnly(left: 12)),
        centerTitle: true,
        titleTxt: "Pay here",
        titleColor: AppColors.blackColor,
        titleFontSize: 16,
        bottomLine: true,
      ),
      body: Column(
        children: [
          Obx(() {
            return Expanded(
                child: ctrl.isLoading.value
                    ? Center(child: CircularProgressIndicator(color: AppColors.secondaryColor))
                    : WebViewWidget(controller: ctrl.webViewController)
            );
          })


        ],
      ),

    );
  }
}

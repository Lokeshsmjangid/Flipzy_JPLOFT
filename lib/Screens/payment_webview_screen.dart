import 'dart:developer';
import 'package:flipzy/controllers/payment_controller.dart';
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
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: addText600('Pay here',color: AppColors.blackColor),automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: AppColors.blackColor,),
          onPressed: () { Get.back(); },),
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

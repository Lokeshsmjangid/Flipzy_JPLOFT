import 'dart:developer';

import 'package:flipzy/Api/repos/verify_payment_repo.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentController extends GetxController{
  late final WebViewController webViewController;

  String? initialUrl;
  String? productId;
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    if(Get.arguments!=null){
      initialUrl = Get.arguments['initial_url'];
      productId = Get.arguments['product_id'];
      log('initial_url:$initialUrl');
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              isLoading.value = true;
            },
            onPageFinished: (String url) {
              isLoading.value = false;
              final finalUri = Uri.parse(url);
              var status = finalUri.queryParameters['status'];
              var tx_ref = finalUri.queryParameters['tx_ref'];
              log('status:$status');
              log('tx_ref url:$tx_ref');

              if(url.contains('successful')){
                Get.back(result: {'status': status,'tx_ref':tx_ref});

              }
            },
          ),
        );

      // Set the initial URL here or pass it dynamically
      webViewController.loadRequest(Uri.parse(initialUrl!));
    };
  }


  onPageFinished(url){}




  paymentSuccess(){
    return showDialog(
      context: Get.context!,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
                Text("Payment Successful"),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
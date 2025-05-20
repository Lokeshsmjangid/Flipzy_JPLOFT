import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flipzy/resources/app_routers.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/local_storage.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiUrls{
  static const String googleApiKey = 'AIzaSyD0nHOa2gwnhvIY5NSWK5DNU7Rp72ocfO0'; // AIzaSyCej2svCH9KHHIuSUJVyHKWp7RJRi7M4_8
/*--------------------------------------------Google Api Key-----------------------------------------------------*/

  static const String domain = 'http://v4.checkprojectstatus.com:5000/';
  static const String baseUrl = '${domain}api/';
  static const String productEmptyImgUrl = 'https://www.feed-image-editor.com/sites/default/files/perm/wysiwyg/image_not_available.png';

/*--------------------------------------------Api EndPoints-----------------------------------------------------*/

  static const String registerPhoneUrl = '${baseUrl}phone/send-otp';
  static const String verifyMobileOtpUrl = '${baseUrl}verify-MobileOtp';
  static const String resendMobileOtpUrl = '${baseUrl}resend';
  static const String profileSetUpUrl = '${baseUrl}profile-setUp';
  static const String fetchProfileUrl = '${baseUrl}fetch-profile';
  static const String loginUrl = '${baseUrl}login';
  static const String guestLoginUrl = '${baseUrl}guestUserLogin';
  static const String socialLoginUrl = '${baseUrl}socialLogin';

  // fg password
  static const String fgPassReqOtpUrl = '${baseUrl}send-otp';
  static const String verifyFgPassOtpUrl = '${baseUrl}verify-otp';
  static const String resetPasswordUrl = '${baseUrl}reset-password';

  // home
  static const String homePageUrl = '${baseUrl}homeList';
  static const String addToFavUrl = '${baseUrl}addfavicon';
  static const String wishlistUrl = '${baseUrl}getfav';

  static const String addSellerUrl = '${baseUrl}seller-info';
  static const String addProductUrl = '${baseUrl}addProduct';
  static const String editProductUrl = '${baseUrl}product-update';

  static const String applyProductReturnUrl = '${baseUrl}order/apply-return';
  static const String acceptDeclineProductReturnUrl = '${baseUrl}order/return-request-respond';

  // Boost Product List
  static const String boostProductsUrl = '${baseUrl}getboostProducts';
  static const String allProductsUrl = '${baseUrl}getAllProduct';
  static const String notificationsUrl = '${baseUrl}getNotification';
  static const String clearAllNotificationsUrl = '${baseUrl}notifications/clearAll';
  static const String fetchReviewUrl = '${baseUrl}fetchReview';

  static const String orderListUrl = '${baseUrl}orderManagement';  // order management list and order history
  static const String userCartsUrl = '${baseUrl}usercarts'; // cart api
  static const String cartDeleteUrl = '${baseUrl}cartDelete'; // cart api
  static const String cartAddUrl = '${baseUrl}cartadd'; // cart api
  static const String contactUsUrl = '${baseUrl}contactUs'; // cart api

  // static const String allTransactionsUrl = '${baseUrl}transactionHistory'; // transactions ashendra
  static const String allTransactionsUrl = '${baseUrl}getUserBalance'; // transactions Ankit
  static const String addReviewUrl = '${baseUrl}addReview'; // addReview done

  static const String productDetailUrl = '${baseUrl}detailProduct'; // detailProduct api pending
  static const String orderDetailUrl = '${baseUrl}orderDetail'; // orderDetail api  done
  static const String feedBackUrl = '${baseUrl}feedBack'; // feedBackUrl api done
  static const String getBoostProductsUrl = '${baseUrl}getboostProducts'; // getboostProducts api  partially

  static const String makeProductBoostUrl = '${baseUrl}boostProduct'; // boostProduct api done
  static const String deleteProductUrl = '${baseUrl}deleteProduct'; // deleteProduct api done
  static const String changeOrderStatusUrl = '${baseUrl}changeOrderStatus'; // changeOrderStatus api done
  static const String bussinessProfileUrl = '${baseUrl}bussinessProfile'; // bussinessProfile api done

  static const String declineOrderUrl = '${baseUrl}declineReason'; // bussinessProfile api done
  static const String deleteAccountUrl = '${baseUrl}deleteAccount'; // bussinessProfile api done
  static const String sellerProductUrl = '${baseUrl}sellerProduct'; // bussinessProfile api done

  static const String buyProductUrl = '${baseUrl}orderProduct'; // bussinessProfile api done
  static const String reportProductUrl = '${baseUrl}productReport'; // bussinessProfile api done

  static const String categoriesListUrl = '${baseUrl}getCategories'; // bussinessProfile api done
  static const String productByCategoryUrl = '${baseUrl}getProductByCategory'; // bussinessProfile api done
  static const String boostPlaneUrl = '${baseUrl}boostPlane'; // bussinessProfile api done
  static const String addFriendUrl = '${baseUrl}addFriend'; // bussinessProfile api done

 // get payment url
  static const String initiatePaymentUrl = '${baseUrl}initiatePayment'; // bussinessProfile api done
  static const String verifyPaymentUrl = '${baseUrl}verifyPayment'; // bussinessProfile api done
  static const String verifyBoostPaymentUrl = '${baseUrl}verifyBoostPayment';


  static const String getSupportUsersListUrl = '${baseUrl}getSupportMessages';


  // Checkout
  static const String checkoutDetailsUrl = '${baseUrl}checkoutDetails';
  static const String allCouponsUrl = '${baseUrl}getAllAvlilableCoupons';
  static const String applyCouponUrl = '${baseUrl}applyCoupon';

  // bussinessProfile api done
  static const String supportFileUploadUrl = '${baseUrl}/upload/files'; // support file upload

  // Address
  static const String getAllAddressUrl = '${baseUrl}address/getAll'; // done
  static const String addAddressUrl = '${baseUrl}address/add'; // done
  static const String editAddressUrl = '${baseUrl}address/edit'; // done
  static const String defaultAddressUrl = '${baseUrl}address/default';
  static const String deleteAddressUrl = '${baseUrl}address/delete';


  // refund
  static const String refundInitiateUrl = '${baseUrl}refund/initiate'; // implemented
  static const String refundRespondUrl = '${baseUrl}refund/respond';
  static const String refundPickUpUrl = '${baseUrl}refund/pickup';
  static const String sendRefundUrl = '${baseUrl}order/refundSend';
  static const String withdrawalUrl = '${baseUrl}requestWithdrawal';

  // Shipping Api ShipBubble
  static const String shipBubbleUrl = '${baseUrl}calculateShippingFromShipbubble';



  // CMS pages
  static const String faqUrl = '${baseUrl}getfaq';
}


/*--------------------------------------------api call methods-----------------------------------------------------*/

Future<http.Response> performGetRequest(String url) async {
  final headers = {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${AuthData().userToken}'
  };



  return await http.get(
    Uri.parse(url),
    headers: headers,
  );
}

Future<http.Response> performPostRequest(String url, Map<String, dynamic> map) async {
  log('${AuthData().userToken}');
  final headers = {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${AuthData().userToken}'
  };
  return await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(map),
  );
}

void handleErrorCases(http.Response response, dynamic data, String apiName) {

  if (response.statusCode == 400 || response.statusCode == 208 ) {
    log('response.statusCode===>${response.statusCode}');
    showToastError(data['message']);
  }
  else if (response.statusCode == 422 || data['message'] == "Unauthenticated.") {
    print('coming in 400 or Unauthenticated in $apiName');
    LocalStorage().clearLocalStorage();
    Get.offAllNamed(AppRoutes.loginScreen);
  }
  else {
    log('Yahaa aaya ApisUrl me');
    log('response.statusCode===>${response.statusCode}');
    showToastError(data['message']);
    // showLoader(false);
    throw Exception(response.body);
  }
}
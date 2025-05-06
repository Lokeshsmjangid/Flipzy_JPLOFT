import 'package:flipzy/Screens/onboarding_screens/onboarding_controller.dart';
import 'package:flipzy/controllers/addProduct_controller.dart';
import 'package:flipzy/controllers/add_or_edit_address_ctrl.dart';
import 'package:flipzy/controllers/all_coupon_ctrl.dart';
import 'package:flipzy/controllers/all_products_controller.dart';
import 'package:flipzy/controllers/bottom_bar_controller.dart';
import 'package:flipzy/controllers/category_controller.dart';
import 'package:flipzy/controllers/chat_controller.dart';
import 'package:flipzy/controllers/chating_controller.dart';
import 'package:flipzy/controllers/checkOut_controller.dart';
import 'package:flipzy/controllers/edit_business_profile_controller.dart';
import 'package:flipzy/controllers/edit_product_controller.dart';
import 'package:flipzy/controllers/forgot_password_email_controller.dart';
import 'package:flipzy/controllers/forgot_password_otp_controller.dart';
import 'package:flipzy/controllers/get_all_address_ctrl.dart';
import 'package:flipzy/controllers/get_product_by_cat_id_controller.dart';
import 'package:flipzy/controllers/login_controller.dart';
import 'package:flipzy/controllers/my_products_controller.dart';
import 'package:flipzy/controllers/notification_controller.dart';
import 'package:flipzy/controllers/order_history_controller.dart';
import 'package:flipzy/controllers/order_list_controller.dart';
import 'package:flipzy/controllers/payment_controller.dart';
import 'package:flipzy/controllers/rating_review_controller.dart';
import 'package:flipzy/controllers/set_new_password_controller.dart';
import 'package:flipzy/controllers/setup_profile_ctrl.dart';
import 'package:flipzy/controllers/splash_controller.dart';
import 'package:flipzy/controllers/verify_phone_otp_controller.dart';
import 'package:flipzy/controllers/wishlist_controller.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.lazyPut<BottomBarController>(() => BottomBarController(), fenix: true);
  Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
  Get.lazyPut<OnboardingController>(() => OnboardingController(), fenix: true);
  Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
  Get.lazyPut<ForgotPasswordEmailController>(() => ForgotPasswordEmailController(), fenix: true);
  Get.lazyPut<ForgotPasswordOtpController>(() => ForgotPasswordOtpController(), fenix: true);
  Get.lazyPut<SetNewPasswordController>(() => SetNewPasswordController(), fenix: true);
  Get.lazyPut<VerifyPhoneOtpController>(() => VerifyPhoneOtpController(), fenix: true);
  Get.lazyPut<SetUpProfileCtrl>(() => SetUpProfileCtrl(), fenix: true);


  // new
  Get.lazyPut<WishListController>(() => WishListController(), fenix: true);
  Get.lazyPut<MyProductsController>(() => MyProductsController(), fenix: true);
  Get.lazyPut<EditProductController>(() => EditProductController(), fenix: true);
  Get.lazyPut<NotificationController>(() => NotificationController(), fenix: true);
  Get.lazyPut<RatingReviewsController>(() => RatingReviewsController(), fenix: true);
  Get.lazyPut<OrderHistoryController>(() => OrderHistoryController(), fenix: true);
  Get.lazyPut<AddProductController>(() => AddProductController(), fenix: true);
  Get.lazyPut<OrderListController>(() => OrderListController(), fenix: true);
  Get.lazyPut<EditBusinessProfileController>(() => EditBusinessProfileController(), fenix: true);
  Get.lazyPut<ProductByCategoryController>(() => ProductByCategoryController(), fenix: true);
  Get.lazyPut<CategoryController>(() => CategoryController(), fenix: true);
  Get.lazyPut<ChatController>(() => ChatController(), fenix: true);
  Get.lazyPut<ChattingCtrl>(() => ChattingCtrl(), fenix: true);
  Get.lazyPut<PaymentController>(() => PaymentController(), fenix: true);
  Get.lazyPut<AllProductsController>(() => AllProductsController(), fenix: true);
  Get.lazyPut<CheckOutController>(() => CheckOutController(), fenix: true);
  Get.lazyPut<GetAllAddressCtrl>(() => GetAllAddressCtrl(), fenix: true);
  Get.lazyPut<AddOrEditAddressCtrl>(() => AddOrEditAddressCtrl(), fenix: true);
  Get.lazyPut<AllCouponCtrl>(() => AllCouponCtrl(), fenix: true);



}
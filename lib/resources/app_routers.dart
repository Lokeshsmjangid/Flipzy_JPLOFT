import 'package:flipzy/Screens/Coupon/all_coupon_screen.dart';
import 'package:flipzy/Screens/all_categories_screen.dart';
import 'package:flipzy/Screens/auth_screens/forgot_password_email_screen.dart';
import 'package:flipzy/Screens/auth_screens/forgot_password_otp_screen.dart';
import 'package:flipzy/Screens/auth_screens/register_mobile_number_screen.dart';
import 'package:flipzy/Screens/auth_screens/setup_profile_sreen.dart';
import 'package:flipzy/Screens/auth_screens/signup_screen.dart';
import 'package:flipzy/Screens/auth_screens/set_new_password_screen.dart';
import 'package:flipzy/Screens/auth_screens/verify_phone_otp_screen.dart';
import 'package:flipzy/Screens/boost_product.dart';
import 'package:flipzy/Screens/boost_product_screen.dart';
import 'package:flipzy/Screens/business_profile/business_profile.dart';
import 'package:flipzy/Screens/cart_screen.dart';
import 'package:flipzy/Screens/chats/chating_screen.dart';
import 'package:flipzy/Screens/chats/support_chat.dart';
import 'package:flipzy/Screens/checkout_screen.dart';
import 'package:flipzy/Screens/help/contact_us.dart';
import 'package:flipzy/Screens/home_screen.dart';
import 'package:flipzy/Screens/auth_screens/login_screen.dart';
import 'package:flipzy/Screens/manage_address/add_address_screen.dart';
import 'package:flipzy/Screens/manage_address/all_address_screen.dart';
import 'package:flipzy/Screens/notification_screen.dart';
import 'package:flipzy/Screens/onboarding_screens/onboarding_screens.dart';
import 'package:flipzy/Screens/order_management_screens/order_confirm_screen.dart';
import 'package:flipzy/Screens/order_management_screens/order_detail_refunds_screen.dart';
import 'package:flipzy/Screens/order_management_screens/order_detail_screen.dart';
import 'package:flipzy/Screens/order_management_screens/order_history_screen.dart';
import 'package:flipzy/Screens/order_management_screens/order_list_screen.dart';
import 'package:flipzy/Screens/order_management_screens/order_mark_ship_screen.dart';
import 'package:flipzy/Screens/payment_webview_screen.dart';
import 'package:flipzy/Screens/products/all_products.dart';
import 'package:flipzy/Screens/products/product_detail_screen.dart';
import 'package:flipzy/Screens/products/add_product.dart';
import 'package:flipzy/Screens/products/edit_products.dart';
import 'package:flipzy/Screens/products/my_products.dart';
import 'package:flipzy/Screens/products/products_two_screen.dart';
import 'package:flipzy/Screens/review_rating.dart';
import 'package:flipzy/Screens/splash_screen.dart';
import 'package:flipzy/Screens/userProfile/edit_profile.dart';
import 'package:get/get.dart';

class AppRoutes {
  static String splashScreen = '/splashScreen';
  static String homeScreen = '/homeScreen';
  static String onboardingScreen = '/onboardingScreen';
  static String loginScreen = '/loginScreen';
  static String forgotPasswordEmailScreen = '/forgotPasswordEmailScreen';
  static String forgotPasswordOtpScreen = '/forgotPasswordOtpScreen';
  static String setNewPasswordScreen = '/setNewPasswordScreen';
  static String signUpScreen = '/signUpScreen';
  static String registerMobileNumberScreen = '/registerMobileNumberScreen';
  static String verifyPhoneOtpScreen = '/verifyPhoneOtpScreen';
  static String setupProfileScreen = '/setupProfileScreen';
  static String myProductsScreen = '/myProductsScreen';
  static String addProductScreen = '/addProductScreen';
  static String editProductScreen = '/editProductScreen';
  static String notificationScreen = '/notificationScreen';
  static String reviewsRatingScreen = '/reviewsRatingScreen';
  static String orderHistoryScreen = '/orderHistoryScreen';
  static String orderListScreen = '/orderListScreen';
  static String cartScreen = '/cartScreen';
  static String contactUsScreen = '/contactUsScreen';
  static String businessProfileScreen = '/businessProfileScreen';
  static String orderDetailScreen = '/orderDetailScreen';
  static String boostProductScreen = '/boostProductScreen';
  static String editProfileScreen = '/editProfileScreen';
  static String orderConfirmScreen = '/orderConfirmScreen';
  static String orderDetailRefundsScreen = '/orderDetailRefundsScreen';
  static String orderMarkShipScreen = '/orderMarkShipScreen';
  static String productDetailScreen = '/productDetailScreen';
  static String allBoostProduct = '/allBoostProduct';
  static String productsTwoScreen = '/productsTwoScreen';
  static String allCategoriesScreen = '/allCategoriesScreen';
  static String chattingScreen = '/chattingScreen';
  static String paymentWebView = '/paymentWebView';
  static String allProductsScreen = '/allProductsScreen';
  static String supportScreen = '/supportScreen';
  static String checkOutScreen = '/checkOutScreen';
  static String allAddressScreen = '/allAddressScreen';
  static String addAddressScreen = '/addAddressScreen';
  static String allCouponScreen = '/allCouponScreen';

  static final getRoute = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.onboardingScreen,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.signUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: AppRoutes.registerMobileNumberScreen,
      page: () => RegisterMobileNumberScreen(),
    ),
    GetPage(
      name: AppRoutes.verifyPhoneOtpScreen,
      page: () => VerifyPhoneOtpScreen(),
    ),
    GetPage(
      name: AppRoutes.setupProfileScreen,
      page: () => SetupProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordEmailScreen,
      page: () => ForgotPasswordEmailScreen(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordOtpScreen,
      page: () => ForgotPasswordOtpScreen(),
    ),
    GetPage(
      name: AppRoutes.setNewPasswordScreen,
      page: () => SetNewPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.myProductsScreen,
      page: () => MyProductsScreen(),
    ),
    GetPage(
      name: AppRoutes.addProductScreen,
      page: () => AddProduct(),
    ),
    GetPage(
      name: AppRoutes.editProductScreen,
      page: () => EditProducts(),
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => NotificationScreen(),
    ),
    GetPage(
      name: AppRoutes.reviewsRatingScreen,
      page: () => ReviewsRatingScreen(),
    ),
    GetPage(
      name: AppRoutes.orderHistoryScreen,
      page: () => OrderHistoryScreen(),
    ),
    GetPage(
      name: AppRoutes.orderListScreen,
      page: () => OrderListScreen(),
    ),
    GetPage(
      name: AppRoutes.cartScreen,
      page: () => CartScreen(),
    ),
    GetPage(
      name: AppRoutes.contactUsScreen,
      page: () => ContactUs(),
    ),
    GetPage(
      name: AppRoutes.businessProfileScreen,
      page: () => BusinessProfile(),
    ),
    GetPage(
      name: AppRoutes.orderDetailScreen,
      page: () => OrderDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.boostProductScreen,
      page: () => BoostProductScreen(),
    ),
    GetPage(
      name: AppRoutes.editProfileScreen,
      page: () => EditProfile(),
    ),
    GetPage(
      name: AppRoutes.orderConfirmScreen,
      page: () => OrderConfirmScreen(),
    ),
    GetPage(
      name: AppRoutes.orderMarkShipScreen,
      page: () => OrderMarkShipScreen(),
    ),
    GetPage(
      name: AppRoutes.orderDetailRefundsScreen,
      page: () => OrderDetailRefundsScreen(),
    ),
    GetPage(
      name: AppRoutes.productDetailScreen,
      page: () => ProductDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.allBoostProduct,
      page: () => AllBoostProduct(),
    ),
    GetPage(
      name: AppRoutes.productsTwoScreen, // for categories
      page: () => ProductsTwoScreen(),
    ),
    GetPage(
      name: AppRoutes.allCategoriesScreen, // for categories
      page: () => AllCategoriesScreen(categoryList: [],),
    ),
    GetPage(
      name: AppRoutes.chattingScreen, // for categories
      page: () => ChattingScreen(),
    ),
    GetPage(
      name: AppRoutes.paymentWebView,
      page: () => PaymentWebView(),
    ),
    GetPage(
      name: AppRoutes.allProductsScreen,
      page: () => AllProductsScreen(),
    ),
    GetPage(
      name: AppRoutes.supportScreen,
      page: () => SupportChatScreen(),
    ),
    GetPage(
      name: AppRoutes.checkOutScreen,
      page: () => CheckOutScreen(),
    ),
    GetPage(
      name: AppRoutes.allAddressScreen,
      page: () => AllAddressScreen(),
    ),
    GetPage(
      name: AppRoutes.addAddressScreen,
      page: () => AddAddressScreen(),
    ),
    GetPage(
      name: AppRoutes.allCouponScreen,
      page: () => CouponScreen(),
    ),
  ];
}
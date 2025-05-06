import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipzy/resources/auth_data.dart';
import 'package:flipzy/resources/local_storage.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController{

  bool isEmployeeAgreed = false;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  bool obsurePass = true;
  ontapPassSuffix(){
    obsurePass = !obsurePass;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(LocalStorage().getBoolValue(LocalStorage.REMEMBER_ME)==true){
      isEmployeeAgreed = true;
      emailCtrl.text = LocalStorage().getValue(LocalStorage.REMEMBER_EMAIL);
      passCtrl.text = LocalStorage().getValue(LocalStorage.REMEMBER_PASSWORD);
    };

  }



// Social Login
final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<User?> signInWithGoogle() async {
    try {
      // Sign out if a user is already signed in
      await _googleSignIn.signOut();
      await _auth.signOut();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null; // If the user cancels the login process
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Google login error::$e:::');
      showToastError('Google login error: $e');
      // showSnackBar(subtitle: 'Google login error: $e');
      return null;
    }
  }

  Future<AuthorizationCredentialAppleID?> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // print('User ID: ${credential.userIdentifier}');
      // print('Email: ${credential.email}');
      // print('Full Name: ${credential.givenName} ${credential.familyName}');

      return credential;
    } catch (e) {
      print('Apple login error::$e:::');
      showToastError('Apple login error: $e');
      return null;
    }
  }



}
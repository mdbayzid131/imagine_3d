// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide Response;
//
// import '../../core/utils/app_constants.dart';
// import '../../core/utils/app_dialog.dart';
// import '../../core/utils/custom_snackbar.dart';
// import '../../data/helper/prefs_helper.dart';
// import '../../data/repo/auth_repo.dart';
// import '../../data/services/api_checker.dart';
// import '../../routes/routes.dart';
// import '../screens/auth_screen/otp_verification_screen.dart';
// import '../screens/auth_screen/verify_email.dart';
// import '../widgets/email_verify_popup.dart';
//
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../../routes/routes.dart';
import '../../services/auth_service.dart';
import '../screens/buttomNabBar_screen/bottom_nab_bar_screen.dart';
import '../widgets/custom_snackbar.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  RxBool isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      UserCredential userCredential = await _authService.login(
        email.trim(),
        password.trim(),
      );

      // ✅ User ID পাওয়া গেল
      String uid = userCredential.user!.uid;
      // লোকালি সেভ করো (SharedPreferences বা GetStorage)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.userId, uid);

      Get.offAll(BottomNavView());
      CustomSnackbar.showSuccess('Success', 'Login successful');
    } catch (e) {
      CustomSnackbar.showError('Login Failed', 'Invalid email or password');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      isLoading.value = true;
      await _authService.resetPassword(email.trim());
      CustomSnackbar.showSuccess(
        'Success',
        'Password reset email sent. Check your inbox.',
      );
    } catch (e) {
      CustomSnackbar.showError(
        'Failed',
        'Failed to send password reset email.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null || user.email == null) {
        throw FirebaseAuthException(
          code: 'no-user',
          message: 'No logged in user',
        );
      }

      // 🔑 Re-authenticate
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);
      CustomSnackbar.showSuccess('Success', 'Password updated successfully');
      Navigator.pop(Get.context!);


      // 🔁 Update password
      await user.updatePassword(newPassword);

    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        CustomSnackbar.showError('Error', 'Invalid old password');
      } else if (e.code == 'weak-password') {
        CustomSnackbar.showError('Error', 'Password is too weak');
      } else {
        CustomSnackbar.showError('Error', 'Failed to update password');
      }
    }
  }

  void logout() async {
    await _authService.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.userId);
    Get.offAllNamed(RoutePages.loginScreen);
  }

  RxBool isPasswordVisible = true.obs;
  RxBool isNewPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;

  void toggle(RxBool value) {
    value.value = !value.value;
  }

  // ------------------------------------------------------------------
  // 🔥 NAME VALIDATION
  // ------------------------------------------------------------------
  String? validName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter your name";
    }
    if (value.trim().length < 3) {
      return "Name must be at least 3 characters";
    }
    return null;
  }

  // ------------------------------------------------------------------
  // 🔥 PHONE VALIDATION
  // ------------------------------------------------------------------
  String? validAccountNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter Account number";
    }
    return null;
  }

  // ------------------------------------------------------------------
  // 🔥 EMAIL VALIDATION
  // ------------------------------------------------------------------
  String? validEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter your email";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email";
    }
    return null;
  }

  // ------------------------------------------------------------------
  // 🔥 PASSWORD VALIDATION
  // ------------------------------------------------------------------
  String? validPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter password";
    }

    String password = value.trim();

    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null; // ✅ Valid password
  }

  String? validDOB(String? value) {
    if (value == null || value.isEmpty) {
      return "Date of Birth is required";
    }
    return null;
  }

  String? amountValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }

    final cleaned = value.trim();

    // only number with optional 2 decimal
    final regex = RegExp(r'^\d+(\.\d{1,2})?$');

    if (!regex.hasMatch(cleaned)) {
      return 'Enter a valid amount';
    }

    final amount = double.tryParse(cleaned);

    if (amount == null) {
      return 'Invalid number format';
    }

    if (amount <= 0) {
      return 'Amount must be greater than 0';
    }

    return null; // ✅ valid
  }

  //
  //   // ------------------------------------------------------------------
  //   // SIGNUP FUNCTION (You can replace API here)
  //   // ------------------------------------------------------------------
  //   Future<void> signUp1({
  //     required String name,
  //     required String email,
  //     required String phone,
  //     required String country,
  //     required String password,
  //   }) async {
  //     // USE THIS FOR API CALL
  //     print("Name: $name");
  //     print("Email: $email");
  //     print("Phone: $phone");
  //     print("Country: $country");
  //     print("Password: $password");
  //
  //     // TODO: call API here...
  //   }
  //
  //   /// <===============================Validation =============================> ///
  //
  String? validUser(String? value) {
    if (value == null || value.isEmpty) return "Please enter your UserName";
    return null;
  }

  String? validOtp(String? value) {
    if (value == null || value.length < 6) {
      return 'OTP must be 6 characters';
    }
    return null;
  }

  // Future<void> fakeLogout() async {
  //   try {
  //     // Clear tokens from PrefsHelper
  //     await PrefsHelper.setString(AppConstants.bearerToken, "");
  //     await PrefsHelper.setString(AppConstants.refreshToken, "");
  //
  //     // Optional: Clear other user-related data if needed
  //     // await PrefsHelper.clearAll();
  //
  //     // Show success message
  //     showCustomSnackBar("Logout successful!", isError: false);
  //
  //     // Navigate to login screen
  //     Get.offAllNamed(RoutePages.loginScreen);
  //   } catch (e) {
  //     showCustomSnackBar("Logout failed: $e", isError: true);
  //   }
  // }
}

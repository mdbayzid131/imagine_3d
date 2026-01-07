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
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
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
      CustomSnackbar.showSuccess('Success', 'Password reset email sent. Check your inbox.');
    } catch (e) {
      CustomSnackbar.showError('Failed', 'Failed to send password reset email.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true;
      await _authService.register(email.trim(), password.trim());
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Signup Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    await _authService.logout();
    Get.offAllNamed('/login');
  }

  //   final AuthRepo authRepo;
  //
  //   AuthController(this.authRepo);
  //
  //   RxBool isLoading = RxBool(false);
  //
  //   /// ===================== SIGNUP =====================
  //
  //   Future<void> signup({
  //     required String name,
  //     required String email,
  //     required String password,
  //     required String phone,
  //     required String country,
  //   }) async {
  //     try {
  //       isLoading(true);
  //
  //       Response response = await authRepo.signup(
  //         name: name,
  //         email: email,
  //         password: password,
  //         phone: phone,
  //         country: country,
  //       );
  //
  //       // ApiChecker response validate
  //       ApiChecker.checkApi(response);
  //
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         await sentOtp(email: email);
  //
  //         Get.to(() => VerifyEmail(email: email), transition: transition);
  //         showCustomSnackBar(
  //           "Signup successful!, Verify your email",
  //           isError: false,
  //         );
  //       }else{
  //         showCustomSnackBar(
  //           "Server is not responding",
  //           isError: true,
  //         );
  //       }
  //     } catch (e) {
  //       if (e is DioException) {
  //         ApiChecker.handleError(e);
  //       } else {
  //         showCustomSnackBar("Failed to connect to server ", isError: true);
  //       }
  //     } finally {
  //       isLoading(false);
  //     }
  //   }
  //
  //   /// ===================== LOGIN =====================
  //
  //   Future<void> login({
  //     required String email,
  //     required String password,
  //     required BuildContext context,
  //   }) async {
  //     try {
  //       isLoading(true);
  //
  //       final Response response = await authRepo.login(
  //         email: email,
  //         password: password,
  //       );
  //
  //       // ApiChecker response validate
  //       ApiChecker.checkApi(response);
  //
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         final data = response.data['data'];
  //         final accessToken = data?['accessToken'] ?? "";
  //         final refreshToken = data?['refreshToken'] ?? "";
  //
  //         if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
  //           await PrefsHelper.setString(AppConstants.bearerToken, accessToken);
  //           await PrefsHelper.setString(AppConstants.refreshToken, refreshToken);
  //
  //           if (context.mounted) {
  //             showCustomSnackBar("Login successful!", isError: false);
  //             Get.offAllNamed(RoutePages.bottomNabBarScreen);
  //           }
  //         } else {
  //           if (context.mounted) {
  //             showCustomSnackBar("Login failed: token missing", isError: true);
  //           }
  //         }
  //       } else if (response.statusCode == 400) {
  //         final message = response.data?["message"] ?? "Bad request";
  //
  //         if (message == 'Please verify your account, then try to login again') {
  //           if (context.mounted) {
  //             AppDialog.show(
  //               context: context,
  //               child: EmailVerifyPopup(email: email),
  //               animation: DialogAnimation.fade,
  //             );
  //           }
  //         }
  //       }
  //     } catch (e) {
  //       if (e is DioException) {
  //         ApiChecker.handleError(e);
  //       } else {
  //         if (context.mounted) {
  //           showCustomSnackBar("Error: $e", isError: true);
  //         }
  //       }
  //     } finally {
  //       isLoading(false);
  //     }
  //   }
  //
  //   /// ===================== FORGOT PASSWORD =====================
  //
  //   Future<void> forgotPassword({required String email}) async {
  //     try {
  //       isLoading(true);
  //
  //       Response response = await authRepo.forgotPassword(email: email);
  //
  //       // ApiChecker response validate
  //       ApiChecker.checkApi(response);
  //
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         showCustomSnackBar("Please check your email", isError: false);
  //         Get.to(
  //           () => OtpVerificationScreen(email: email),
  //           transition: transition,
  //         );
  //       }
  //     } catch (e) {
  //       if (e is DioException) {
  //         ApiChecker.handleError(e);
  //       } else {
  //         showCustomSnackBar("Error: $e", isError: true);
  //       }
  //     } finally {
  //       isLoading(false);
  //     }
  //   }
  //
  //   /// ===================== resentOtp =====================
  //
  //   Future<void> resentOtp({required String email}) async {
  //     try {
  //       isLoading(true);
  //
  //       Response response = await authRepo.resentOtp(email: email);
  //
  //       // ApiChecker response validate
  //       ApiChecker.checkApi(response);
  //
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         showCustomSnackBar("OTP sent successfully", isError: false);
  //       }
  //     } catch (e) {
  //       if (e is DioException) {
  //         ApiChecker.handleError(e);
  //       } else {
  //         showCustomSnackBar("Error: $e", isError: true);
  //       }
  //     } finally {
  //       isLoading(false);
  //     }
  //   }
  //
  //   /// ===================== sentOTp =====================
  //
  //   Future<void> sentOtp({required String email}) async {
  //     try {
  //       isLoading(true);
  //
  //       Response response = await authRepo.resentOtp(email: email);
  //
  //       // ApiChecker response validate
  //       ApiChecker.checkApi(response);
  //
  //       if (response.statusCode == 200 || response.statusCode == 201) {}
  //     } catch (e) {
  //       if (e is DioException) {
  //         ApiChecker.handleError(e);
  //       } else {
  //         showCustomSnackBar("Error: $e", isError: true);
  //       }
  //     } finally {
  //       isLoading(false);
  //     }
  //   }
  //
  //   /// ===================== verifyEmail =====================
  //
  //   Future<void> verifyEmail({
  //     required String email,
  //     required int oneTimeCode,
  //   }) async {
  //     try {
  //       isLoading(true);
  //
  //       Response response = await authRepo.otpVerify(
  //         email: email,
  //         oneTimeCode: oneTimeCode,
  //       );
  //
  //       // ApiChecker response validate
  //       ApiChecker.checkApi(response);
  //
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         showCustomSnackBar(
  //           "Email verified successfully. Please login",
  //           isError: false,
  //         );
  //         Get.offAllNamed(RoutePages.loginScreen);
  //       }
  //     } catch (e) {
  //       if (e is DioException) {
  //         ApiChecker.handleError(e);
  //       } else {
  //         showCustomSnackBar("Error: $e", isError: true);
  //       }
  //     } finally {
  //       isLoading(false);
  //     }
  //   }
  //
  //   /// ===================== verifyEmail =====================
  //
  //   Future<void> verifyEmailForForgotPassword({
  //     required String email,
  //     required int oneTimeCode,
  //   }) async {
  //     try {
  //       isLoading(true);
  //
  //       Response response = await authRepo.otpVerify(
  //         email: email,
  //         oneTimeCode: oneTimeCode,
  //       );
  //
  //       // ApiChecker response validate
  //       ApiChecker.checkApi(response);
  //
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         showCustomSnackBar(
  //           "Email verified successfully, Please reset your password",
  //           isError: false,
  //         );
  //         Get.toNamed(RoutePages.newPassword);
  //       }
  //     } catch (e) {
  //       if (e is DioException) {
  //         ApiChecker.handleError(e);
  //       } else {
  //         showCustomSnackBar("Error: $e", isError: true);
  //       }
  //     } finally {
  //       isLoading(false);
  //     }
  //   }
  //
  //   /// ===================== verifyEmail =====================
  //
  //   Future<void> newPassword({
  //     required String newPassword,
  //     required String confirmPassword,
  //   }) async {
  //     try {
  //       isLoading(true);
  //
  //       Response response = await authRepo.resetPassword(
  //         newPassword: newPassword,
  //         confirmPassword: confirmPassword,
  //       );
  //
  //       // ApiChecker response validate
  //       ApiChecker.checkApi(response);
  //
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         showCustomSnackBar(
  //           "Password reset successfully. Please login",
  //           isError: false,
  //         );
  //         Get.offAllNamed(RoutePages.loginScreen);
  //       }
  //     } catch (e) {
  //       if (e is DioException) {
  //         ApiChecker.handleError(e);
  //       } else {
  //         showCustomSnackBar("Error: $e", isError: true);
  //       }
  //     } finally {
  //       isLoading(false);
  //     }
  //   }
  //
  //   /// <=============================== Logout=============================> ///
  //   Future<void> logout() async {
  //     try {
  //       isLoading(true);
  //
  //       Response response = await authRepo.logout();
  //
  //       // ApiChecker response validate
  //       print(response.data);
  //       ApiChecker.checkApi(response);
  //
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         // Get.offAllNamed(RoutePages.loginScreen);
  //       }
  //     } catch (e) {
  //       if (e is DioException) {
  //         ApiChecker.handleError(e);
  //       } else {
  //         showCustomSnackBar("Error: $e", isError: true);
  //       }
  //     } finally {
  //       isLoading(false);
  //     }
  //   }
  //
  //   /// <===============================    =============================> ///
  //
  //   RxInt secondsRemaining = 180.obs;
  //   RxBool enableResent = false.obs;
  //
  //   Timer? timer;
  //
  //   void dispostTimer() {
  //     timer?.cancel();
  //     secondsRemaining.value = 180;
  //     enableResent.value = false;
  //   }
  //
  //   void startTimer() {
  //     timer?.cancel();
  //     secondsRemaining.value = 180;
  //     enableResent.value = false;
  //     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //       if (secondsRemaining.value > 0) {
  //         secondsRemaining.value--;
  //       } else {
  //         enableResent.value = true;
  //         timer.cancel();
  //       }
  //     });
  //   }
  //
  // -------------------------
  // OBSERVABLES (for password)
  // -------------------------
  RxBool isPasswordVisible = true.obs;
  RxBool isNewPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  //
  //   // -------------------------
  //   // COUNTRY
  //   // -------------------------
  //   RxString selectedCountry = ''.obs;
  //
  //   // Example country list
  //   final List<String> countries = [
  //     "Afghanistan",
  //     "Albania",
  //     "Algeria",
  //     "Andorra",
  //     "Angola",
  //     "Antigua and Barbuda",
  //     "Argentina",
  //     "Armenia",
  //     "Australia",
  //     "Austria",
  //     "Azerbaijan",
  //     "Bahamas",
  //     "Bahrain",
  //     "Bangladesh",
  //     "Barbados",
  //     "Belarus",
  //     "Belgium",
  //     "Belize",
  //     "Benin",
  //     "Bhutan",
  //     "Bolivia",
  //     "Bosnia and Herzegovina",
  //     "Botswana",
  //     "Brazil",
  //     "Brunei",
  //     "Bulgaria",
  //     "Burkina Faso",
  //     "Burundi",
  //     "Cambodia",
  //     "Cameroon",
  //     "Canada",
  //     "Cape Verde",
  //     "Central African Republic",
  //     "Chad",
  //     "Chile",
  //     "China",
  //     "Colombia",
  //     "Comoros",
  //     "Congo",
  //     "Costa Rica",
  //     "Croatia",
  //     "Cuba",
  //     "Cyprus",
  //     "Czech Republic",
  //     "Denmark",
  //     "Djibouti",
  //     "Dominica",
  //     "Dominican Republic",
  //     "Ecuador",
  //     "Egypt",
  //     "El Salvador",
  //     "Equatorial Guinea",
  //     "Eritrea",
  //     "Estonia",
  //     "Eswatini",
  //     "Ethiopia",
  //     "Fiji",
  //     "Finland",
  //     "France",
  //     "Gabon",
  //     "Gambia",
  //     "Georgia",
  //     "Germany",
  //     "Ghana",
  //     "Greece",
  //     "Grenada",
  //     "Guatemala",
  //     "Guinea",
  //     "Guinea-Bissau",
  //     "Guyana",
  //     "Haiti",
  //     "Honduras",
  //     "Hungary",
  //     "Iceland",
  //     "India",
  //     "Indonesia",
  //     "Iran",
  //     "Iraq",
  //     "Ireland",
  //     "Israel",
  //     "Italy",
  //     "Jamaica",
  //     "Japan",
  //     "Jordan",
  //     "Kazakhstan",
  //     "Kenya",
  //     "Kiribati",
  //     "Kuwait",
  //     "Kyrgyzstan",
  //     "Laos",
  //     "Latvia",
  //     "Lebanon",
  //     "Lesotho",
  //     "Liberia",
  //     "Libya",
  //     "Liechtenstein",
  //     "Lithuania",
  //     "Luxembourg",
  //     "Madagascar",
  //     "Malawi",
  //     "Malaysia",
  //     "Maldives",
  //     "Mali",
  //     "Malta",
  //     "Marshall Islands",
  //     "Mauritania",
  //     "Mauritius",
  //     "Mexico",
  //     "Micronesia",
  //     "Moldova",
  //     "Monaco",
  //     "Mongolia",
  //     "Montenegro",
  //     "Morocco",
  //     "Mozambique",
  //     "Myanmar",
  //     "Namibia",
  //     "Nauru",
  //     "Nepal",
  //     "Netherlands",
  //     "New Zealand",
  //     "Nicaragua",
  //     "Niger",
  //     "Nigeria",
  //     "North Korea",
  //     "North Macedonia",
  //     "Norway",
  //     "Oman",
  //     "Pakistan",
  //     "Palau",
  //     "Panama",
  //     "Papua New Guinea",
  //     "Paraguay",
  //     "Peru",
  //     "Philippines",
  //     "Poland",
  //     "Portugal",
  //     "Qatar",
  //     "Romania",
  //     "Russia",
  //     "Rwanda",
  //     "Saint Kitts and Nevis",
  //     "Saint Lucia",
  //     "Saint Vincent and the Grenadines",
  //     "Samoa",
  //     "San Marino",
  //     "Sao Tome and Principe",
  //     "Saudi Arabia",
  //     "Senegal",
  //     "Serbia",
  //     "Seychelles",
  //     "Sierra Leone",
  //     "Singapore",
  //     "Slovakia",
  //     "Slovenia",
  //     "Solomon Islands",
  //     "Somalia",
  //     "South Africa",
  //     "South Korea",
  //     "South Sudan",
  //     "Spain",
  //     "Sri Lanka",
  //     "Sudan",
  //     "Suriname",
  //     "Sweden",
  //     "Switzerland",
  //     "Syria",
  //     "Taiwan",
  //     "Tajikistan",
  //     "Tanzania",
  //     "Thailand",
  //     "Timor-Leste",
  //     "Togo",
  //     "Tonga",
  //     "Trinidad and Tobago",
  //     "Tunisia",
  //     "Turkey",
  //     "Turkmenistan",
  //     "Tuvalu",
  //     "Uganda",
  //     "Ukraine",
  //     "United Arab Emirates",
  //     "United Kingdom",
  //     "United States",
  //     "Uruguay",
  //     "Uzbekistan",
  //     "Vanuatu",
  //     "Vatican City",
  //     "Venezuela",
  //     "Vietnam",
  //     "Yemen",
  //     "Zambia",
  //     "Zimbabwe",
  //   ];
  //
  // ------------------------------------------------------------------
  // 🔥 COMMON TOGGLE FUNCTION (Use this anywhere)
  // ------------------------------------------------------------------

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

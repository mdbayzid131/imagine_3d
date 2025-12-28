import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../routes/routes.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/image_paths.dart';
import '../../../data/helper/time_formater.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import 'new_password.dart';
class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}
class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  final _authController = Get.find<AuthController>();

  // @override
  // void initState() {
  //   _authController.startTimer();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _authController.dispostTimer();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [

              SizedBox(height: 20.h),

              ///================= App Logo =========================///
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image.asset(
              //       ImagePaths.giftZees,
              //       width: 218.w,
              //     ),
              //   ],
              // ),

              SizedBox(height: 24.h),

              ///================= OTP Illustration =========================///
              // Image.asset(
              //   ImagePaths.otpVerify,
              //   height: 124.h,
              //   width: 124.w,
              // ),

              SizedBox(height: 24.h),

              ///================= Title =========================///
              Text(
                'One-Time Password Verification',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff1D1D1D),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 15.h),

              ///================= Description =========================///
              Text(
                'A verification code has been sent to\nyour registered email/phone. Enter\nbelow to proceed.',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff525050),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24.h),


              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ///<================= Email Text Field =========================>///
                    CustomTextField(
                      validator: _authController.validEmail,
                      hintText: 'Enter your OTP',
                      label: 'OTP',

                    ),

                    SizedBox(height: 32.h),

                    ///<================= Submit Button =========================>///
                    CustomElevatedButton(
                      label: 'Send',
                      onPressed: () {
                        Get.to(() => const NewPassword());

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_color.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/Custom_back_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import 'otp_verification_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: CustomBackButton(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 20.h),

              ///<================= App Logo =========================>///

              ///<================= Illustration Image =========================>///
              SizedBox(height: 24.h),

              ///<================= Title =========================>///
              Text(
                'Forgot Password',
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff333333),
                  height: 1.3,
                ),
              ),

              SizedBox(height: 15.h),

              ///<================= Description =========================>///
              Text(
                'Enter the email or phone your account and we’ll send \n a code to reset your password.',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff525050),
                  height: 1.4,
                ),
              ),

              SizedBox(height: 24.h),

              ///<================= Form =========================>///
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ///<================= Email Text Field =========================>///
                    CustomTextField(
                      validator: _authController.validEmail,
                      hintText: 'Enter your email',
                      label: 'Email',
                      controller: emailController,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.caption,
                        size: 20.sp,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    ///<================= Submit Button =========================>///
                    CustomElevatedButton(
                      label: 'Send',
                      onPressed: () {
                        Get.to(
                          () => OtpVerificationScreen(
                            email: emailController.text,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

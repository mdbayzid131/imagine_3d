import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/Custom_back_button.dart';
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
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: CustomBackButton(),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 25.h),
              ///<================= Title =========================>///
              Text(
                'Check your Email',
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
                'we send a verification code Please Check your e-mail.',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff525050),
                  height: 1.4,
                ),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagine_3d/core/constants/image_paths.dart';
import 'package:imagine_3d/presentation/screens/home/home_screen.dart';
import '../../../core/constants/app_color.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import '../buttomNabBar_screen/bottom_nab_bar_screen.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80.h),

              ///================= App Logo =========================///
              Container(
                height: 124.w,
                width: 132.w,
                decoration: BoxDecoration(color: const Color(0xff42B02B)),
                child: Image.asset(
                  ImagePaths.appLogo,
                  height: 98.h,
                  width: 112.w,
                ),
              ),
              SizedBox(height: 24.h),

              ///================= Welcome Text =========================///
              Text(
                "Good morning",
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),

              SizedBox(height: 32.h),

              ///================= Login Form =========================///
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ///================= Email Field =========================///
                    CustomTextField(
                      validator: _authController.validEmail,
                      hintText: 'Enter your email',
                      label: 'Email',
                      controller: emailController,
                    ),

                    SizedBox(height: 16.h),

                    ///================= Password Field =========================///
                    Obx(
                      () => CustomTextField(
                        validator: _authController.validPassword,
                        obscureText: _authController.isPasswordVisible.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _authController.isPasswordVisible.value =
                                !_authController.isPasswordVisible.value;
                          },
                          icon: Icon(
                            _authController.isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xff909090),
                            size: 18.sp,
                          ),
                        ),
                        hintText: 'Enter your password',
                        label: 'Password',
                        controller: passwordController,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    ///================= Forgot Password =========================///
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => const ForgetPassword());
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffFD7839),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    ///================= Login Button =========================///
                    CustomElevatedButton(
                        label: 'Login',
                        onPressed: () {
                          Get.to(() =>  BottomNavView());
                        },
                      ),


                    SizedBox(height: 16.h),

                    ///================= Sign Up Redirect =========================///
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Don’t have an account?",
                    //       style: TextStyle(
                    //         fontSize: 12.sp,
                    //         fontWeight: FontWeight.w400,
                    //         color: const Color(0xff333333),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //
                    //       },
                    //       child: Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 4.w),
                    //         child: Text(
                    //           "Sign Up",
                    //           style: TextStyle(
                    //             fontSize: 14.sp,
                    //             fontWeight: FontWeight.w600,
                    //             color: const Color(0xffFD7839),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //
                    // SizedBox(height: 30.h),
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

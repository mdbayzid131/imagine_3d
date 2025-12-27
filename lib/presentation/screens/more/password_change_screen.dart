import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:imagine_3d/presentation/widgets/custom_elevated_button.dart';
import 'package:imagine_3d/presentation/widgets/custom_text_field.dart';

import '../../../core/constants/app_color.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_appbar.dart';

class PasswordChangeScreen extends StatelessWidget {
  PasswordChangeScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.customAppBar(title: 'User Information'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Obx(
            () => Column(
              children: [
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: 'Enter current password',
                  label: 'Current Password',
                  controller: _currentPassController,
                  validator: authController.validPassword,
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    size: 20.sp,
                    color: AppColors.caption,
                  ),
                  obscureText: authController.isPasswordVisible.value,
                  suffixIcon: IconButton(
                    icon: authController.isPasswordVisible.value
                        ? Icon(
                            Icons.visibility_outlined,
                            size: 20.sp,
                            color: AppColors.caption,
                          )
                        : Icon(
                            Icons.visibility_off_outlined,
                            size: 20.sp,
                            color: AppColors.caption,
                          ),
                    onPressed: () {
                      authController.toggle(authController.isPasswordVisible);
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    size: 20.sp,
                    color: AppColors.caption,
                  ),
                  hintText: 'Enter new password',
                  label: 'New Password',
                  controller: _newPassController,
                  validator: authController.validPassword,
                  obscureText: authController.isNewPasswordVisible.value,
                  suffixIcon: IconButton(
                    icon: authController.isNewPasswordVisible.value
                        ? Icon(
                            Icons.visibility_outlined,
                            size: 20.sp,
                            color: AppColors.caption,
                          )
                        : Icon(
                            Icons.visibility_off_outlined,
                            size: 20.sp,
                            color: AppColors.caption,
                          ),
                    onPressed: () {
                      authController.toggle(
                        authController.isNewPasswordVisible,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    size: 20.sp,
                    color: AppColors.caption,
                  ),
                  hintText: 'Enter Confirm password',
                  label: 'Confirm Password',
                  controller: _confirmPassController,
                  validator: authController.validPassword,
                  obscureText: authController.isConfirmPasswordVisible.value,
                  suffixIcon: IconButton(
                    icon: authController.isConfirmPasswordVisible.value
                        ? Icon(
                            Icons.visibility_outlined,
                            size: 20.sp,
                            color: AppColors.caption,
                          )
                        : Icon(
                            Icons.visibility_off_outlined,
                            size: 20.sp,
                            color: AppColors.caption,
                          ),
                    onPressed: () {
                      authController.toggle(
                        authController.isConfirmPasswordVisible,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                CustomElevatedButton(
                  label: 'Save Changes',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

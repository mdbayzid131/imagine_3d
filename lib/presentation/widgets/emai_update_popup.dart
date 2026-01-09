import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagine_3d/presentation/widgets/custom_text_field.dart';
import '../../core/constants/app_color.dart';
import '../controllers/profile_controller.dart';

void showUpdateEmailDialog(BuildContext context, ProfileController controller) {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final isSubmitted = false.obs;

  bool validateFields() {
    final email = emailCtrl.text.trim();
    final pass = passCtrl.text.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email) && pass.isNotEmpty;
  }

  showDialog(
    context: context,
    builder: (_) => Obx(
      () => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        titlePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        actionsPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),

        title: Text(
          'Change Email',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: emailCtrl,
              hintText: 'Enter new email',
              label: 'New email',
              errorText: isSubmitted.value && emailCtrl.text.trim().isEmpty
                  ? 'Email cannot be empty'
                  : isSubmitted.value &&
                        !RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(emailCtrl.text.trim())
                  ? 'Enter a valid email'
                  : null,
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              controller: passCtrl,
              obscureText: true,
              errorText: isSubmitted.value && passCtrl.text.trim().isEmpty
                  ? 'Password cannot be empty'
                  : null,

              hintText: 'Enter password',
              label: 'Password',
            ),
          ],
        ),
        actions: [
          ActionButtons(
            onCancel: () => Get.back(),

            /// 🔥 FIX HERE
            onSave: controller.isLoading.value
                ? null
                : () {
                    isSubmitted.value = true;

                    if (!validateFields()) return;

                    controller.updateEmail(
                      newEmail: emailCtrl.text.trim(),
                      password: passCtrl.text.trim(),
                    );
                  },

            saveChild: controller.isLoading.value
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Save',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
          ),
        ],
      ),
    ),
  );
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback? onSave;
  final Widget saveChild;

  const ActionButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
    required this.saveChild,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffF3F4F6),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onSave, // ✅ now works
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: saveChild,
          ),
        ),
      ],
    );
  }
}

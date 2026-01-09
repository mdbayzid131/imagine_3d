import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagine_3d/presentation/widgets/custom_text_field.dart';
import '../../core/constants/app_color.dart';
import '../controllers/profile_controller.dart';

void showUpdateNameDialog(BuildContext context, ProfileController controller) {
  final nameCtrl = TextEditingController(text: controller.name.value);
  final showError = false.obs;

  showDialog(
    context: context,
    builder: (_) => Obx(
      () => AlertDialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ), // 🔥 tighter width
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        titlePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        actionsPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),

        title: Text(
          'Update Name',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),

        /// 🔥 FIX HERE
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: nameCtrl,
              errorText: showError.value && nameCtrl.text.trim().length < 2
                  ? 'Name must be at least 2 characters'
                  : null,
              hintText: 'Enter name',
              label: 'Name',
            ),
          ],
        ),

        actions: [
          ActionButtons(
            onCancel: () => Get.back(),
            onSave: controller.isLoading.value
                ? null
                : () {
                    if (nameCtrl.text.trim().length < 2) {
                      showError.value = true;
                      return;
                    }
                    controller.updateName(nameCtrl.text.trim());
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
        /// Cancel
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

        /// Save
        Expanded(
          child: ElevatedButton(
            onPressed: onSave, // 🔥 now works
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

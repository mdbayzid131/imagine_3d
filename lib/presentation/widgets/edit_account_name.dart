import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_cancle_buttom.dart';
import 'custom_text_field.dart';

class EditAccountName {
  /// Static method to trigger the popup correctly
  static Future<void> showPopup(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const DialogBody(),
    );
  }
}

class DialogBody extends StatelessWidget {
  const DialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text(
              " Edit Account Name",
              style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16.h),

            /// Bank Name
            CustomTextField(hintText: "Chase Checking", label: 'Account Name'),
            SizedBox(height: 10.h),
            Text(
              'Optional: Name of your bank or financial institution',
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            SizedBox(height: 10.h),

            /// Buttons
            AddCancelButton(
              cancelText: 'Cancel',
              addText: 'Update Details',
              cancelOnTap: () {
                Navigator.pop(context);
              },
              addOnTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_cancle_buttom.dart';
import 'custom_text_field.dart';

class UpdateAccountDetails {
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
              "Update Account Details",
              style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16.h),

            /// Bank Name
            CustomTextField(hintText: "Type...", label: 'Account Type'),

            SizedBox(height: 12.h),
            CustomTextField(hintText: "****4521", label: 'Account Number'),

            SizedBox(height: 5.h),
            Text(
              'Your full account number (will be masked for security)',
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),

            /// Amount
            SizedBox(height: 12.h),

            CustomTextField(hintText: "021000021", label: 'Routing Number'),
            SizedBox(height: 5.h),
            Text(
              '9-digit bank routing number (ABA number))',
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),

            /// Account Number
            SizedBox(height: 20.h),
            CustomTextField(hintText: "Enter bank name", label: 'Bank Name'),

            SizedBox(height: 5.h),
            Text(
              'Optional: Name of your bank or financial institution',
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),

            /// Account Number
            SizedBox(height: 20.h),

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

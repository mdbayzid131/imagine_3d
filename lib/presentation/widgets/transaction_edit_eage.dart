import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_cancle_buttom.dart';
import 'custom_text_field.dart';


class TransactionEditEage{
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
              "Transaction Edit Page",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16.h),

            /// Bank Name

            CustomTextField(hintText: "Type...", label: 'Tittle',),

            SizedBox(height: 12.h),
            CustomTextField(hintText: "Type...", label: 'Amount',),

            /// Amount

            SizedBox(height: 12.h),

            CustomTextField(hintText: "Type...", label: 'Date',),
            /// Account Number

            SizedBox(height: 20.h),

            /// Buttons
            AddCancelButton(cancelText: 'Cancel', addText: 'Update Details', cancelOnTap: () { Navigator.pop(context); }, addOnTap: () { Navigator.pop(context); },),
          ],
        ),
      ),
    );
  }
}

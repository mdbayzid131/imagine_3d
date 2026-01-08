import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_controller.dart';
import '../controllers/homepgeController.dart';
import 'add_cancle_buttom.dart';
import 'custom_text_field.dart';

class UpdateAccountDetails {
  /// Static method to trigger the popup correctly
  static Future<void> showPopup({
    required BuildContext context,
    required String groupId,
    required int accountIndex,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => DialogBody(groupId: groupId, accountIndex: accountIndex),
    );
  }
}

class DialogBody extends StatelessWidget {
  final String groupId;
  final int accountIndex;
  DialogBody({super.key, required this.groupId, required this.accountIndex});
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _newBalanceController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();
  final controller = Get.put(AccountController());

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
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16.h),
            CustomTextField(
              hintText: "****4521",
              label: 'Account Number',
              validator: _authController.validAccountNumber,
              controller: _accountNumberController,
            ),
            SizedBox(height: 5.h),
            Text(
              'Your full account number (will be masked for security)',
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              hintText: "\$000",
              label: 'Balance',
              validator: _authController.amountValidator,
              controller: _newBalanceController,
            ),
            SizedBox(height: 20.h),
            AddCancelButton(
              cancelText: 'Cancel',
              addText: 'Update Details',
              cancelOnTap: () {
                Navigator.pop(context);
              },
              addOnTap: () {
                Navigator.pop(context);
                controller.updateAccountInfo(
                  groupId: groupId,
                  accountIndex: accountIndex,
                  balance: double.parse(_newBalanceController.text),
                  number: _accountNumberController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

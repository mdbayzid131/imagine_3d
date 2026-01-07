import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_controller.dart';
import '../controllers/homepgeController.dart';
import 'add_cancle_buttom.dart';
import 'custom_text_field.dart';

class AddAccountPopup {
  /// Static method to trigger the popup correctly
  static Future<void> showPopup({
    required BuildContext context,
    required String accountType,
    required int accountIndex,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => DialogBody(accountType: accountType, accountIndex: accountIndex,),
    );
  }
}

class DialogBody extends StatelessWidget {
  final String accountType;
  final int accountIndex;

  DialogBody({super.key, required this.accountType, required this.accountIndex});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accountTypeController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final AccountController _accountController = Get.find<AccountController>();
  final AuthController _authController = Get.find<AuthController>();

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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  "Add Account",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 16.h),

                /// Account Type
                CustomTextField(
                  readOnly: true,
                  controller: _accountTypeController,

                  hintText: accountType,
                  label: 'Account Type',
                ),

                SizedBox(height: 12.h),

                /// Bank Name
                CustomTextField(
                  controller: _bankNameController,
                  validator: _authController.validName,
                  hintText: "Enter your bank name",
                  label: 'Bank Name',
                ),

                SizedBox(height: 12.h),
                CustomTextField(
                  hintText: "Type...",
                  label: 'Amount',
                  controller: _amountController,
                  validator: _authController.amountValidator,
                ),

                /// Amount
                SizedBox(height: 12.h),

                CustomTextField(
                  hintText: "Type...",
                  label: 'Account Number',
                  controller: _accountNumberController,
                  validator: _authController.validAccountNumber,
                ),

                /// Account Number
                SizedBox(height: 20.h),

                /// Buttons
                AddCancelButton(
                  cancelText: 'Cancel',
                  addText: 'Add',
                  cancelOnTap: () {
                    Navigator.pop(context);
                  },
                  addOnTap: () {
                    if (_formKey.currentState!.validate()) {
                      _accountController.addNewAccount(
                        groupIndex: accountIndex,
                        name: _bankNameController.text,
                        number: _accountNumberController.text,
                        amount: double.parse(_amountController.text),
                      );
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

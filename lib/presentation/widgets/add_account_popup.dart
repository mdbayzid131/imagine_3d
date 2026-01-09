import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_controller.dart';
import '../controllers/homepgeController.dart';
import 'add_cancle_buttom.dart';
import 'custom_text_field.dart';

class AddAccountPopup {
  static Future<void> showPopup({
    required BuildContext context,
    required String accountType,
    required int accountIndex,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          DialogBody(accountType: accountType, accountIndex: accountIndex),
    );
  }
}

class DialogBody extends StatelessWidget {
  final String accountType;
  final int accountIndex;

  DialogBody({
    super.key,
    required this.accountType,
    required this.accountIndex,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
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
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 16.h),

                /// Account Type Card (NOT TextField)
                _AccountTypeCard(type: accountType),

                SizedBox(height: 16.h),

                /// Bank Name
                CustomTextField(
                  controller: _bankNameController,
                  validator: _authController.validName,
                  hintText: "Enter bank name",
                  label: 'Bank Name',
                ),

                SizedBox(height: 12.h),

                /// Amount
                CustomTextField(
                  hintText: "Enter amount",
                  label: 'Amount',
                  controller: _amountController,
                  validator: _authController.amountValidator,
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 12.h),

                /// Account Number
                CustomTextField(
                  hintText: "Enter account number",
                  label: 'Account Number',
                  controller: _accountNumberController,
                  validator: _authController.validAccountNumber,
                ),

                SizedBox(height: 24.h),

                /// Buttons
                AddCancelButton(
                  cancelText: 'Cancel',
                  addText: 'Add',
                  cancelOnTap: () => Navigator.pop(context),
                  addOnTap: () {
                    if (_formKey.currentState!.validate()) {
                      _accountController.addNewAccount(
                        groupIndex: accountIndex,
                        name: _bankNameController.text.trim(),
                        number: _accountNumberController.text.trim(),
                        amount: double.parse(_amountController.text.trim()),
                      );
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

/// ================= Account Type UI =================
class _AccountTypeCard extends StatelessWidget {
  final String type;

  const _AccountTypeCard({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.blue.withOpacity(.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.account_balance_wallet_rounded,
            color: Colors.blue,
            size: 22.sp,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account Type",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                type,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

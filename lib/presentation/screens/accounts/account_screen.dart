import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_color.dart';
import '../../../data/models/account_group_model.dart';
import '../../controllers/homepgeController.dart';
import '../../widgets/balance_card.dart';

class AccountsScreen extends StatelessWidget {
  AccountsScreen({super.key});

  // ✅ already created controller reuse
  final AccountController controller = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        children: [
          SizedBox(height: 12.h),

          /// ===== TITLE =====
          Text(
            "Accounts",
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),

          SizedBox(height: 20.h),

          /// ===== LIST =====
          Expanded(
            child: Obx(() {
              final accounts = controller.allAccountsWithGroup;

              if (accounts.isEmpty) {
                return const Center(child: Text("No accounts found"));
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  final item = account['account'] as AccountItem;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: SavingsCard(
                      title: item.name,
                      accountNumber: item.number,
                      balance: item.amount,
                      balanceTitle: account['group'],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

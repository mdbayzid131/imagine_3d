import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_color.dart';
import '../../../controllers/account_details_controller.dart';
import '../../../widgets/add_trensection_popup.dart';
import '../../../widgets/trensection_tapa_and_hold_popup.dart';

class ActivityTabs extends StatelessWidget {
  final String groupId;
  final int accountIndex;
  final String accountName;

  ActivityTabs({
    super.key,
    required this.groupId,
    required this.accountIndex,
    required this.accountName,
  });
  final controller = Get.find<CardDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transactions",
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  AddTrensectionPopup.showPopup(
                    context,
                    onSubmit: (title, amount, date) {
                      controller.addTransaction(
                        title: title,
                        amount: amount,
                        date: date,
                      );
                    },
                  );
                },
                child: Text(
                  "+ Add",
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// Transaction List
          Expanded(
            child: Obx(() {
              if (controller.transactions.isEmpty) {
                return Center(
                  child: Text(
                    'No transactions found.',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  final tx = controller.transactions[index];

                  return _transactionTile(
                    title: tx.title,
                    amount: tx.amount,
                    balance: "\$${tx.nowBalance.toStringAsFixed(2)}",
                    date: tx.date.toDate(),
                    context: context,
                    groupId: groupId,
                    index: accountIndex,
                    accountName: accountName,
                    newBalance: tx.nowBalance,
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

Widget _dateLabel(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Text(
      text,
      style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
    ),
  );
}

Widget _transactionTile({
  required String groupId,
  required String title,
  required double amount,
  required double newBalance,
  required String balance,
  required DateTime date,
  required BuildContext context,
  required int index,
  required String accountName,
}) {
  final isExpense = amount < 0;
  return GestureDetector(
    onLongPress: () {
      TrensectionTapaAndHoldPopup.showPopup(
        context: context,
        title: title,
        balance: amount,
        date: _formatDate(date),
        groupId: groupId,
        index: index,
        accountName: accountName, // Pass the index of transaction
      );
    },
    child: Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r), // Responsive radius
        side: BorderSide(
          color: Colors.black12,
          width: 1.w, // Responsive border width
        ),
      ),
      margin: EdgeInsets.only(bottom: 10.h), // Responsive margin
      child: ListTile(
        // Leading icon with responsive size
        leading: CircleAvatar(
          radius: 20.r, // Responsive radius
          backgroundColor: isExpense
              ? Colors.red.shade100
              : Colors.green.shade100,
          child: Icon(
            isExpense ? Icons.arrow_upward : Icons.arrow_downward,
            color: isExpense ? Colors.red : Colors.green,
            size: 22.sp, // Responsive icon
          ),
        ),

        /// Transaction Title
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp, // Responsive font
          ),
        ),

        /// Subtitle: Account Name + Date
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h), // Responsive spacing
            Text(
              _formatDate(date),
              style: TextStyle(fontSize: 12.sp), // Responsive font
            ),
          ],
        ),

        /// Trailing: Amount
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "\$${isExpense ? '-' : ''}${amount.abs()}",
              style: GoogleFonts.poppins(
                color: isExpense ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp, // Responsive font
              ),
            ),
            SizedBox(height: 2.h), // Responsive spacing
            Text(
              "\$$newBalance",
              style: GoogleFonts.poppins(fontSize: 12.sp),
            ), // Responsive")
          ],
        ),
      ),
    ),
  );
}

/// Format date to DD-MM-YYYY
String _formatDate(DateTime date) {
  return "${date.day}-${date.month}-${date.year}";
}

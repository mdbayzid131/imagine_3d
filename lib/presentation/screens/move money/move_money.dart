import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_color.dart';
import '../../../data/models/unified_transaction_model.dart';
import '../../controllers/all_transaction_controller.dart';
import '../../widgets/custom_appbar.dart';

class MoveMoneyScreen extends StatelessWidget {
  MoveMoneyScreen({super.key});

  // Controller to manage transactions
  final controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Move Money",
          style: GoogleFonts.poppins(
            fontSize: 20.sp, // Responsive font size
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h), // Responsive spacing

            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Transactions",
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp, // Responsive font
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h), // Responsive spacing

            /// Transaction List
            Obx(() {
              // Show placeholder if no transactions
              if (controller.transactions.isEmpty) {
                return Center(
                  child: Text(
                    "No transactions",
                    style: TextStyle(fontSize: 14.sp), // Responsive text
                  ),
                );
              }

              // List of all transactions
              return Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.transactions.length,
                    itemBuilder: (context, index) {
                      final tx = controller.transactions[index];
                      return _TransactionTile(tx: tx);
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final AllTransactionModel tx;

  const _TransactionTile({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isExpense = tx.amount < 0;

    return Card(
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
          backgroundColor:
          isExpense ? Colors.red.shade100 : Colors.green.shade100,
          child: Icon(
            isExpense ? Icons.arrow_upward : Icons.arrow_downward,
            color: isExpense ? Colors.red : Colors.green,
            size: 22.sp, // Responsive icon
          ),
        ),

        /// Transaction Title
        title: Text(
          tx.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp, // Responsive font
          ),
        ),

        /// Subtitle: Account Name + Date
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tx.accountName,
              style: TextStyle(fontSize: 12.sp), // Responsive font
            ),
            SizedBox(height: 2.h), // Responsive spacing
            Text(
              _formatDate(tx.date),
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
              "${isExpense ? '-' : '+'}${tx.amount.abs()}",
              style: TextStyle(
                color: isExpense ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp, // Responsive font
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Format date to DD-MM-YYYY
  String _formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_color.dart';
import '../../controllers/all_transaction_controller.dart';
import '../../widgets/custom_appbar.dart';
class MoveMoneyScreen extends StatelessWidget {
   MoveMoneyScreen({super.key});
  final controller = Get.put(AllTransactionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Move Money",
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h,),
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Transactions",
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            /// Transaction List
            _dateLabel("Monday December 22, 2025"),
            _transactionTile(
              title: "SAVE ON FOODS#_F",
              amount: "-\$15.00",
              balance: "Chase Checking",
            ),
        Obx(() {
          final grouped =
          groupByDate(controller.allTransactions);

          if (grouped.isEmpty) {
            return const Center(child: Text("No transactions"));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: grouped.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 📅 Date Header
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),

                  /// Transactions
                  ...entry.value.map((tx) {


                    return ListTile(
                      title: Text(tx.title),
                      subtitle:
                      Text("${tx.accountName} • ${tx.groupTitle}"),
                      trailing: Text(
                        tx.amount < 0
                            ? "-\$${tx.amount.abs()}"
                            : "+\$${tx.amount}",
                        style: TextStyle(
                          color: tx.amount < 0
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                    );

                    // _transactionTile(
                    //   title: "SAVE ON FOODS#_F",
                    //   amount: "-\$15.00",
                    //   balance: "Chase Checking",
                    // );



                  }).toList(),

                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
          );
        })



          ],
        ),
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
  required String title,
  required String amount,
  required String balance,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.h),
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: Colors.black12),
    ),
    child: Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                balance,
                style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

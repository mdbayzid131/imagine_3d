import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_color.dart';
import '../../../controllers/account_details_controller.dart';
import '../../../widgets/add_trensection_popup.dart';
import '../../../widgets/trensection_tapa_and_hold_popup.dart';

class ActivityTabs extends StatelessWidget {
  ActivityTabs({super.key});
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
                    amount: tx.amount < 0
                        ? "-\$${tx.amount.abs().toStringAsFixed(2)}"
                        : "+\$${tx.amount.toStringAsFixed(2)}",
                    balance: "\$${tx.nowBalance.toStringAsFixed(2)}",
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

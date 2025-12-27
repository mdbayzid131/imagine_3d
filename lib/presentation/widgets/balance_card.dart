import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_color.dart';
import '../screens/accounts/custom_account_details.dart';

class SavingsCard extends StatelessWidget {
  final String title;
  final String balanceTitle;
  final String accountNumber;
  final double balance;
  final Color iconColor;

  const SavingsCard({
    super.key,
    required this.title,
    required this.accountNumber,
    required this.balance,
    this.iconColor = Colors.green,
    required this.balanceTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row
          GestureDetector(
            onTap: (){
              Get.to(() => CustomAccountDetails(
                accountName: title,
                accountNumber: accountNumber,
                balance: balance,
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, size: 22.sp, color: Colors.grey),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          /// Account Number
          Text(
            "****$accountNumber",
            style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey,fontWeight: FontWeight.w400),
          ),


          SizedBox(height: 16.h),

          /// Balance
          Text(
            balanceTitle,
            style: GoogleFonts.poppins(fontSize: 12.sp, color: AppColors.caption,fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 4.h),
          Text(
            "\$${balance.toStringAsFixed(2)}",
            style: GoogleFonts.poppins(fontSize: 24.sp, fontWeight: FontWeight.w400,color:AppColors.textColor),),

        ],
      ),
    );
  }
}

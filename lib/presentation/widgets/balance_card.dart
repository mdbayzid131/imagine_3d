import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "****$accountNumber",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey,fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 22.sp, color: Colors.grey),
            ],
          ),

          SizedBox(height: 16.h),

          /// Balance
          Text(
            balanceTitle,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 4.h),
          Text(
            "\$${balance.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

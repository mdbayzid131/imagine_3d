import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_color.dart';
import '../../widgets/custom_appbar.dart';

class MoveMoneyScreen extends StatelessWidget {
  const MoveMoneyScreen({super.key});

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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
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
            _transactionTile(
              title: "TESORO ITALIAN _ F",
              amount: "-\$6.00",
              balance: "Chase Checking",
            ),

            _dateLabel("Friday December 19, 2025"),
            _transactionTile(
              title: "STARBUCKS COFFE_F",
              amount: "-\$15.00",
              balance: "Chase Checking",
            ),

            _dateLabel("Thursday December 18, 2025"),
            _transactionTile(
              title: "SAVE ON FOODS#_F",
              amount: "-\$15.00",
              balance: "Chase Checking",
            ),
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

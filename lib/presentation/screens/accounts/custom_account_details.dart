import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/image_paths.dart';
import '../../widgets/custom_appbar.dart';

class CustomAccountDetails extends StatelessWidget {
  final String accountName;

  final String accountNumber;
  final double balance;

  const CustomAccountDetails({
    super.key,
    required this.accountName,
    required this.accountNumber,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomWidgets.customAppBar(title: 'Account',),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: 20
          ),
          child: Column(
              children: [
          Container(
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
                SvgPicture.asset(
                  ImagePaths.accountditails,
                  width: 20.w,
                  height: 20.w,
                ),
                SizedBox(width: 10.w),

                Text(
                  'Account Details',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  ImagePaths.accountName,
                  width: 20.w,
                  height: 20.w,
                ),
                SizedBox(width: 10.w),

                Text(
                  'Account Name : ',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                Text(
                  accountName,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.caption,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  ImagePaths.accountNumber,
                  width: 20.w,
                  height: 20.w,
                ),
                SizedBox(width: 10.w),

                Text(
                  'Account Number : ',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                Text(
                  accountNumber,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.caption,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  ImagePaths.currentBlance,
                  width: 20.w,
                  height: 20.w,
                ),
                SizedBox(width: 10.w),

                Text(
                  'Current Balance : ',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                Text(
                  "\$${balance.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.caption,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

              ])
      ),
    );
  }
}

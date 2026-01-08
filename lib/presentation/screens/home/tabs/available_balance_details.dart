import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/custom_appbar.dart';

class AvailableBalanceDetails extends StatelessWidget {
  final String currentBalance;
  final String availableBalance;
  final String overdraftLimit;
  const AvailableBalanceDetails({
    super.key,
    required this.currentBalance,
    required this.overdraftLimit,
    required this.availableBalance,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.customAppBar(title: 'Available Balance Details'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Available Balance Details',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 20.h),

            _infoRow(
              label: 'Current Balance :',
              value: currentBalance,
              valueColor: Color(0xff363636),
            ),

            SizedBox(height: 10.h),

            _infoRow(
              label: 'Overdraft Limit :',
              value: overdraftLimit,
              valueColor: Colors.green,
            ),

            SizedBox(height: 14.h),

            Divider(color: Colors.grey.shade300),
            _infoRow(
              label: 'Available :',
              value: availableBalance,
              valueColor: Colors.green,
            ),

            SizedBox(height: 16.h),

            SizedBox(height: 16.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFfEFF6FF),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(width: 1, color: Color(0xffCFD8E9)),
              ),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(
                      text: 'Note: ',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: Color(0xff6C28A8A),
                      ),
                    ),
                    TextSpan(
                      text:
                          'OvYour available balance represents the amount you can currently spend,including your overdraft limit, minus pending transactions.',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3A3793),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _infoRow({
  required String label,
  required String value,
  required Color valueColor,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 16.sp,
          color: Color(0xff363636),
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        value,
        style: GoogleFonts.poppins(fontSize: 16.sp, color: valueColor),
      ),
    ],
  );
}

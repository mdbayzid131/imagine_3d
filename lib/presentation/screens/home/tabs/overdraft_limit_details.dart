import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/custom_appbar.dart';

class OverdraftLimitDetails extends StatelessWidget {
  const OverdraftLimitDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.customAppBar(title: 'Overdraft Limit Details'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Overdraft Limit Details',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 20.h),

            _infoRow(
              label: 'Current Limit :',
              value: '\$300.00',
              valueColor: Color(0xff363636),
            ),

            SizedBox(height: 10.h),

            _infoRow(
              label: 'Used :',
              value: '\$0.00',
              valueColor: Color(0xff363636),
            ),

            SizedBox(height: 10.h),

            _infoRow(
              label: 'Available :',
              value: '\$300.00',
              valueColor: Colors.green,
            ),

            SizedBox(height: 14.h),

            Divider(color: Colors.grey.shade300),

            SizedBox(height: 16.h),

            Text(
              'About Overdraft Protection',
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'Your overdraft limit allows you to make transaction even when your account balance is insufficient. Interest will be charged on any overdraft balance at the agreed rate.',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Color(0xff363636),
                height: 1.5,
              ),
            ),

            SizedBox(height: 16.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEA),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(width: 1, color: Color(0xffF3E6C0)),
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
                        color: Color(0xff96690A),
                      ),
                    ),
                    TextSpan(
                      text:
                          'Overdraft fees may apply. Please refer to your account agreement for details.',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Color(0xff65870A),
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

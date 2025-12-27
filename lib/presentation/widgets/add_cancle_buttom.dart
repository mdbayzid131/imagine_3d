import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_color.dart';

class AddCancelButton extends StatelessWidget {
  /// Add Cancel Button
  final String cancelText;
  final String addText;
  final VoidCallback cancelOnTap;
  final VoidCallback addOnTap;

  const AddCancelButton({super.key, required this.cancelText, required this.addText, required this.cancelOnTap, required this.addOnTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Cancel
        Expanded(
          child: GestureDetector(
            onTap: cancelOnTap,
            child: Container(
              height: 44.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                cancelText,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 12.w),

        /// Add
        Expanded(
          child: GestureDetector(
            onTap: addOnTap,
            child: Container(
              height: 44.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:  AppColors.primary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                addText,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Color(0xffF3F4F6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}





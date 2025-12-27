import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_color.dart';

class CustomWidgets{
  static AppBar customAppBar({required String title, Widget? leading, List<Widget>? action}) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: AppColors.textColor
        ),
      ),
      iconTheme: IconThemeData(
        color: AppColors.caption,
        size: 20.sp,
      ),
      leading: leading,

      actions: action,
    );
  }

}

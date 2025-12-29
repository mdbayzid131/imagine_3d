import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../core/constants/app_color.dart';

class CustomWidgets {
  static AppBar customAppBar({
    required String title,
    VoidCallback? onBack,
    List<Widget>? actions,
    IconData backIcon = Icons.arrow_back_ios_new, // <-- new optional parameter
  }) {
    return AppBar(
      centerTitle: true,

      // LEFT BACK BUTTON
      leading: GestureDetector(
        onTap: onBack ?? () => Get.back(),
        child: SizedBox(
          height: 40.w,
          width: 40.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xffF5F5F5),
              child: Icon(
                backIcon, // <-- dynamic icon used here
                size: 18.r,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ),
      ),

      // TITLE
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          height: 1.4,
          color: AppColors.textColor,
        ),
      ),

      // RIGHT ACTIONS
      actions: actions,
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../core/constants/app_color.dart';
//
// class CustomWidgets{
//   static AppBar customAppBar({required String title, Widget? leading, List<Widget>? action}) {
//     return AppBar(
//       centerTitle: true,
//       title: Text(
//         title,
//         style: GoogleFonts.poppins(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w500,
//             height: 1.4,
//             color: AppColors.textColor
//         ),
//       ),
//       iconTheme: IconThemeData(
//         color: AppColors.caption,
//         size: 20.sp,
//       ),
//       leading: leading,
//
//       actions: action,
//     );
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagine_3d/presentation/widgets/transaction_edit_eage.dart';

import 'add_cancle_buttom.dart';
import 'custom_text_field.dart';

class TrensectionTapaAndHoldPopup {
  /// Static method to trigger the popup correctly
  static Future<void> showPopup(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const DialogBody(),
    );
  }
}

class DialogBody extends StatelessWidget {
  const DialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    'Monday December 22, 2025',
                    style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
                  ),
                ),



                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, size: 20.sp),
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),

                  itemBuilder: (context) => [
                    const PopupMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Delete'),
                    ),
                  ],
                  onSelected: (String value) {
                    if (value == 'Edit') {

                      TransactionEditEage.showPopup(context);
                    } else if (value == 'Delete') {
                    }
                  },
                ),

              ],
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SAVE ON FOODS#_F',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '-\$15.00',
                        style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Text(
                  '\$6,488.32',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

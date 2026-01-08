import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RemoveAccountPopup {
  static Future<void> show({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _RemoveAccountDialog(onConfirm: onConfirm),
    );
  }
}

class _RemoveAccountDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const _RemoveAccountDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Icon
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50.sp),

            SizedBox(height: 12.h),

            /// Title
            Text(
              "Remove Account?",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 8.h),

            /// Description
            Text(
              "This account and all its transactions will be permanently deleted. This action cannot be undone.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
            ),

            SizedBox(height: 20.h),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    child:  Text("Remove",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutPopup {
  static Future<void> show({
    required BuildContext context,
    required VoidCallback onLogout,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _LogoutDialog(onLogout: onLogout),
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;

  const _LogoutDialog({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.logout, size: 48.sp, color: Colors.orange),

            SizedBox(height: 12.h),

            Text(
              "Logout",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              "Are you sure you want to logout from this account?",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
            ),

            SizedBox(height: 20.h),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onLogout();
                    },
                    child: const Text("Logout"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

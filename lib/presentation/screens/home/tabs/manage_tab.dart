import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/account_details_controller.dart';
import '../../../controllers/homepgeController.dart';
import '../../../widgets/edit_account_name.dart';
import '../../../widgets/remove_account_popup.dart';
import '../../../widgets/update_account_details.dart';

class ManageAccountBody extends StatelessWidget {
  final String groupID;
  final int accountIndex;
  ManageAccountBody({
    super.key,
    required this.groupID,
    required this.accountIndex,
  });
  final controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text(
              "Manage Account",
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 20.h),

            /// Edit Account Name
            _settingsTile(
              icon: Icons.edit_outlined,
              title: "Edit Account Name",
              subtitle: "Change your account display name",
              onTap: () {
                EditAccountName.showPopup(
                  context: context, groupID: groupID, accountIndex: accountIndex,
                );
              },
            ),

            SizedBox(height: 12.h),

            /// Update Account Details
            _settingsTile(
              icon: Icons.edit_outlined,
              title: "Update Account Details",
              subtitle: "Modify routing or account number",
              onTap: () {
                UpdateAccountDetails.showPopup(context: context, groupId: groupID, accountIndex: accountIndex);
              },
            ),

            SizedBox(height: 24.h),

            /// Danger Zone
            Text(
              "DANGER ZONE",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.grey,
                letterSpacing: 0.8,
              ),
            ),

            SizedBox(height: 12.h),

            /// Remove Account
            _settingsTile(
              icon: Icons.delete_outline,
              title: "Remove Account",
              subtitle: "Permanently delete this account",
              titleColor: Colors.red,
              iconColor: Colors.red,
              onTap: () {
                RemoveAccountPopup.show(
                  context: context,
                  onConfirm: () {
                    controller.deleteAccount(
                      groupId: groupID,
                      accountIndex: accountIndex,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Color titleColor = const Color(0xff1E1E1E),
    Color iconColor = const Color(0xff1E1E1E),
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 1.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

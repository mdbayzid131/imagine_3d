import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagine_3d/presentation/screens/more/password_change_screen.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/image_paths.dart';
import '../../../routes/routes.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/custom_profile.dart';
import '../../widgets/logout_popup.dart';
import 'change_name_screen.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({super.key});
  final AuthController controller = Get.find<AuthController>();
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Information",
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            /*            Center(child: CustomProfile(imagePath: ImagePaths.appLogo)),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30.h,
                  width: 168.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Color(0xffC4BDBD), width: 1.w),
                  ),

                  child: Center(
                    child: Text(
                      'jhon@gmail.com',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB7A9A9),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),*/
            Row(
              children: [
                Icon(Icons.person_outline, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'User Information',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Text(
                        'Name :',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        profileController.name.value,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),

                  Row(
                    children: [
                      Text(
                        'Email :',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        profileController.email.value,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            _SettingsTile(
              icon: Icons.person_outline,
              title: 'Change User Information',
              onTap: () {
                Get.to(() => ChangeNameScreen());
              },
            ),

            SizedBox(height: 14.h),

            _SettingsTile(
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: () {
                // navigate to change password
                Get.to(() => PasswordChangeScreen());
              },
            ),
            SizedBox(height: 14.h),

            GestureDetector(
              onTap: () {
                LogoutPopup.show(
                  context: context,
                  onLogout: () {
                    controller.logout();
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: Color(0xFFE5DBDB)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Color(0xffff0000)),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xffff0000),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xffff0000),
                      size: 20.sp,
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

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Color(0xFFE5DBDB)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.caption),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 14.sp, color: AppColors.textColor),
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.caption, size: 20.sp),
          ],
        ),
      ),
    );
  }
}

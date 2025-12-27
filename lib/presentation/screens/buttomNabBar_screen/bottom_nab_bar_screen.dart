import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_color.dart';
import '../../controllers/bottom_nab_bar_controller.dart';

class BottomNavView extends StatelessWidget {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavController());

    return Scaffold(
      body: Obx(
            () => controller.screens[controller.currentIndex.value]
      ),

      bottomNavigationBar: Obx(
            () => Container(
          height: 72.h,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.r,
              ),
            ],
          ),

          ///<================================== BOTTOM NAV BAR ========================>///
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(
                icon: Icons.home_outlined,
                label: "Home",
                index: 0,
                controller: controller,
              ),
              _navItem(
                icon: Icons.credit_card_outlined,
                label: "Accounts",
                index: 1,
                controller: controller,
              ),
              _navItem(
                icon: Icons.swap_horiz,
                label: "Move Money",
                index: 2,
                controller: controller,
              ),
              _navItem(
                icon: Icons.menu,
                label: "More",
                index: 3,
                controller: controller,
              ),
            ],
          ),
          ///<================================== END NAV BAR ========================>///
        ),
      ),
    );
  }

  ///<================================== SINGLE NAV ITEM ========================>///
  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
    required BottomNavController controller,
  }) {
    bool isActive = controller.currentIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24.sp,
            color: isActive ? AppColors.primary : Color(0xff616161),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: isActive ? AppColors.primary : Color(0xff616161),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
///<================================== END ITEM ========================>///
}

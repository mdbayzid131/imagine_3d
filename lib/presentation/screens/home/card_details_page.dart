import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagine_3d/core/constants/app_color.dart';
import 'package:imagine_3d/presentation/screens/home/tabs/activity_tabs.dart';

import '../../widgets/add_trensection_popup.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/edit_account_name.dart';
import '../../widgets/trensection_tapa_and_hold_popup.dart';
import 'tabs/details_tab.dart';
import 'tabs/manage_tab.dart';

class CardDetailsPage extends StatelessWidget {
  const CardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomWidgets.customAppBar(title: "Banking"),
        body: Column(
          children: [
            SizedBox(height: 12.h),

            /// Account Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEA),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primary, width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '6644129',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      'TD All- Inclusive Banking Plan',
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      '\$6,733.32',
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// Tab Bar
            TabBar(
              labelColor: AppColors.primary,
              unselectedLabelColor: Color(0xff363636),
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2,
              dividerColor: Colors.transparent,
              labelStyle: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: "Activity"),
                Tab(text: "Details"),
                Tab(text: "Manage"),
              ],
            ),

            /// Tab Views
            Expanded(
              child: TabBarView(
                children: [ActivityTabs(), DetailsTab(), ManageAccountBody()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

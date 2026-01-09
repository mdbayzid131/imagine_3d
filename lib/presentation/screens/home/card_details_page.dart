import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagine_3d/core/constants/app_color.dart';
import 'package:imagine_3d/presentation/screens/home/tabs/activity_tabs.dart';

import '../../controllers/account_details_controller.dart';
import '../../widgets/add_trensection_popup.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/edit_account_name.dart';
import '../../widgets/trensection_tapa_and_hold_popup.dart';
import 'tabs/details_tab.dart';
import 'tabs/manage_tab.dart';

class CardDetailsPage extends StatelessWidget {
  CardDetailsPage({super.key});
  final controller = Get.put(CardDetailsController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final groupId = args['groupId'];
    final accountName = args['accountName'];
    final accountIndex = args['accountIndex'];
    print('====================');
    print(groupId);
    print(accountName);
    print(accountIndex);
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
                    Obx(
                      () => Text(
                        controller.account.value.number,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Obx(
                      () => Text(
                        controller.account.value.name,
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Obx(
                      () => Text(
                        "\$${controller.account.value.amount.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
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
                children: [
                  ActivityTabs(
                    groupId: groupId,
                    accountIndex: accountIndex,
                    accountName: accountName,
                  ),
                  DetailsTab(),
                  ManageAccountBody(
                    groupID: groupId,
                    accountIndex: accountIndex,
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

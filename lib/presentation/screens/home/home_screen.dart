import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_color.dart';
import '../../../data/models/account_group_model.dart';
import '../../../routes/routes.dart';
import '../../controllers/homepgeController.dart';
import '../../widgets/add_account_popup.dart';
import '../../widgets/custom_elevated_button.dart';
import 'card_details_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AccountController controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(color: AppColors.primary),
          padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 20.w),
          child: headerArea(),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Text(
                "My Accounts",
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: Colors.white,
              strokeWidth: 2.w,
              onRefresh: () async {
                controller.fetchAccountGroups();
              },
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: controller.accountGroups.length,
                itemBuilder: (context, index) {
                  final group = controller.accountGroups[index];
                  return Column(
                    children: [
                      _accountCard(group, index, context),
                      SizedBox(height: 20.h),
                    ],
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  SafeArea headerArea() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Balance",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Obx(
            () => Text(
              "\$${controller.totalBalance.obs.toStringAsFixed(2)}",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 30.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Color(0xFF099D09),
                  border: Border.all(color: Color(0xFF64D021), width: 1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Obx(
                    () => Text(
                      "${controller.totalAccounts.obs} Accounts",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
            ],
          ),
        ],
      ),
    );
  }

  ///================ ACCOUNT CARD =================///
  Widget _accountCard(AccountGroup group, int index, BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final isExpanded = controller.expandedIndex.value == index;
      final int accountCount = group.accounts.length;
      final double totalAmount = group.accounts.fold(
        0.0,
        (sum, item) => sum + item.amount,
      );

      return Container(
        decoration: cardDecoration(),
        child: Column(
          children: [
            ListTile(
              title: Text(
                group.title,
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(
                "$accountCount accounts",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.caption,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "\$${totalAmount.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
              onTap: () => controller.toggleExpand(index),
            ),

            ///<================================== EXPANDED CONTENT ========================>///
            if (isExpanded) ...[
              Divider(height: .5.h, color: Colors.black12),

              ...group.accounts.asMap().entries.map((entry) {
                final accIndex = entry.key;
                final accItem = entry.value;
                final accName = accItem.name;

                return InkWell(
                  onTap: () {
                    Get.to(
                      () => CardDetailsPage(),
                      arguments: {
                        'groupId': group.id,
                        'accountIndex': accIndex,
                        'accountName': accName,
                      },
                    );
                  },
                  child: accountInnerCard(accItem),
                );
              }),

              Divider(height: .5.h, color: Colors.black12),
              GestureDetector(
                onTap: () {
                  AddAccountPopup.showPopup(
                    context: context,
                    accountType: group.title,
                    accountIndex: index,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.green,
                        size: 22.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Add Accounts",
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            ///<================================== END EXPANDED ========================>///
          ],
        ),
      );
    });
  }

  ///<================================== INNER DROPDOWN CARD ========================>///
  Widget accountInnerCard(AccountItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                item.number,
                style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "\$${item.amount.toStringAsFixed(2)}",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  ///<================================== CARD DECORATION ========================>///
  BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: Colors.black12),
    );
  }
}

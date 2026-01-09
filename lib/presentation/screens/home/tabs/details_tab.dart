import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/account_details_controller.dart';
import 'available_balance_details.dart';
import 'overdraft_limit_details.dart';

class DetailsTab extends StatelessWidget {
  DetailsTab({super.key});
  final controller = Get.put(CardDetailsController());
  final double overdraftLimit = 300.0;
  final double currentLimit = 300.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            "Account Information",
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 16.h),

          /// Info Card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 1.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Column(
              children: [
                _infoRow(
                  label: "Account Name",
                  value: controller.account.value.name,
                ),
                _divider(),
                _infoRow(
                  label: "Account Number",
                  value: controller.account.value.number,
                ),
                _divider(),
                _infoRow(
                  label: "Account Balance",
                  value:
                      "\$${controller.account.value.amount.toStringAsFixed(2)}",
                ),
                _divider(),
                _infoRowWithAction(
                  label: "Overdraft Limit",
                  value: "\$300.00",
                  actionText: "View Details",
                  onTap: () {
                    Get.to(
                      () => OverdraftLimitDetails(
                        currentBalance:
                            "\$${controller.account.value.amount.toStringAsFixed(2)}",
                        used: "00.00",
                        availableBalance:
                            "\$${controller.account.value.amount.toStringAsFixed(2)}",
                      ),
                    );
                  },
                ),
                _divider(),
                _infoRowWithAction(
                  label: "Available Balance",
                  value:
                      "\$${controller.account.value.amount.toStringAsFixed(2)}",
                  actionText: "View Details",
                  onTap: () {
                    Get.to(
                      () => AvailableBalanceDetails(
                        currentBalance:
                            "\$${controller.account.value.amount.toStringAsFixed(2)}",
                        overdraftLimit: overdraftLimit.toStringAsFixed(2),
                        availableBalance:
                            "\$${controller.account.value.amount.toStringAsFixed(2)}",
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _infoRow({required String label, required String value}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black87),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          value,
          textAlign: TextAlign.right,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _infoRowWithAction({
  required String label,
  required String value,
  required String actionText,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(label, style: GoogleFonts.poppins(fontSize: 14.sp)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: onTap,
              child: Text(
                actionText,
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _divider() {
  return Divider(height: 1, thickness: 0.8, color: Colors.grey.shade200);
}

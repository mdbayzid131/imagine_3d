import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_color.dart';
import '../../../routes/routes.dart';
import '../../widgets/add_account_popup.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final RxBool isExpanded = false.obs;
  final RxBool isExpanded2 = false.obs;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.primary),
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
            child: SafeArea(
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
                  Text(
                    "\$24,567.83",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF099D09),
                          border: Border.all(
                            color: Color(0xFF64D021),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            "4 Accounts",
                            style: GoogleFonts.poppins(
                              color: Color(0xFF88ED0D),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "My Accounts",
                      style: GoogleFonts.poppins(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                ///<================================== CARD 1 ========================>///
                accountCard(
                  title: "Banking",
                  name: "TD All-Inclusive\nBanking Plan",
                  number: "6644129",
                  amount: "\$6,441.29",
                  isGreen: true,
                ),
                SizedBox(height: 12.h),

                ///<================================== CARD 2 ========================>///
                accountCard(
                  title: "Loans & Mortgages",
                  name: "Mortgages",
                  number: "6644129",
                  amount: "\$6,441.29",
                  isGreen: true,
                ),
                SizedBox(height: 12.h),

                ///<================================== DROPDOWN CARD ========================>///
                Obx(
                  () => Container(
                    decoration: cardDecoration(),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Credit Cards",
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor,
                            ),
                          ),
                          subtitle: Text(
                            "2 accounts",
                            style: GoogleFonts.poppins(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.caption,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$6,441.29",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(
                                isExpanded.value
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 25.sp,
                              ),
                            ],
                          ),
                          onTap: () {
                            isExpanded.value = !isExpanded.value;
                          },
                        ),

                        ///<================================== EXPANDED CONTENT ========================>///
                        if (isExpanded.value) ...[
                          Divider(height: 1.h),

                          accountInnerCard(
                            name: "Visa Platinum",
                            number: "6644129",
                            amount: "\$3,200.00",
                          ),
                          accountInnerCard(
                            name: "Mastercard Gold",
                            number: "6644130",
                            amount: "\$3,241.29",
                          ),
                        ],

                        ///<================================== END EXPANDED ========================>///
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Obx(
                  () => Container(
                    decoration: cardDecoration(),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Direct Investing",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor,
                            ),
                          ),
                          subtitle: Text(
                            "7 accounts",
                            style: GoogleFonts.poppins(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.caption,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$6,441.29",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(
                                isExpanded2.value
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 25.sp,
                              ),
                            ],
                          ),
                          onTap: () {
                            isExpanded2.value = !isExpanded2.value;
                          },
                        ),

                        ///<================================== EXPANDED CONTENT ========================>///
                        if (isExpanded2.value) ...[
                          Divider(height: 1.h),

                          accountInnerCard(
                            name: "Visa Platinum",
                            number: "6644129",
                            amount: "\$3,200.00",
                          ),
                          accountInnerCard(
                            name: "Mastercard Gold",
                            number: "6644130",
                            amount: "\$3,241.29",
                          ),
                          accountInnerCard(
                            name: "Mastercard Gold",
                            number: "6644130",
                            amount: "\$3,241.29",
                          ),
                          accountInnerCard(
                            name: "Mastercard Gold",
                            number: "6644130",
                            amount: "\$3,241.29",
                          ),
                          accountInnerCard(
                            name: "Mastercard Gold",
                            number: "6644130",
                            amount: "\$3,241.29",
                          ),
                          accountInnerCard(
                            name: "Mastercard Gold",
                            number: "6644130",
                            amount: "\$3,241.29",
                          ),
                          accountInnerCard(
                            name: "Mastercard Gold",
                            number: "6644130",
                            amount: "\$3,241.29",
                          ),
                        ],

                        ///<================================== END EXPANDED ========================>///
                      ],
                    ),
                  ),
                ),


                SizedBox(height: 12.h),          ///<================ ADD ACCOUNTS & SERVICES =================>///
                GestureDetector(
                  onTap: () {
                    AddAccountPopup.showPopup(context);
                  },
                  child: Container(
                    height: 52.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline,
                            color: Colors.green, size: 22.sp),
                        SizedBox(width: 8.w),
                        Text(
                          "Add Accounts and services",
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15.h),

                ///<================ TD MYSPEND TITLE =================>///
                Row(
                  children: [
                    Text(
                      "TD MySpend",
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(Icons.chevron_right,
                        color: Colors.green, size: 26.sp),
                  ],
                ),

                SizedBox(height: 20.h),

                ///<================ MYSPEND INFO =================>///
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFBEAEA),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 44.h,
                        width: 44.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.green,
                          size: 28.sp,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Text(
                          "Get TD MySpend For Your\nHomepage & stay on top of TD\naccount spending.",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                ///<================ EDIT HOME SCREEN BUTTON =================>///
                Container(
                  height: 52.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Edit Home Screen",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///<================================== MAIN CARD ========================>///
  Widget accountCard({
    required String title,
    required String name,
    required String number,
    required String amount,
    bool isGreen = false,
  }) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(RoutePages.cardDetailsPage);

      },
      child: Container(
        decoration: cardDecoration(),
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: Row(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                   Icon(Icons.more_vert,size: 22.sp,),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Divider(height: 1.h),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Text(
                        amount,
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Text(
                        number,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Color(0xff616161),
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///<================================== INNER DROPDOWN CARD ========================>///
  Widget accountInnerCard({
    required String name,
    required String number,
    required String amount,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                number,
                style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Text(
            amount,
            style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w600),
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

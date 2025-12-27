import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagine_3d/core/constants/app_color.dart';

import '../../widgets/add_trensection_popup.dart';
import '../../widgets/edit_account_name.dart';
import '../../widgets/trensection_tapa_and_hold_popup.dart';
import 'details_tab.dart';
import 'manage_tab.dart';

class CardDetailsPage extends StatelessWidget {
  const CardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,

          title: Text(
            "Banking",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

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
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1.2,
                  ),
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
                        color:AppColors.textColor,
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
                  _activityTab(context),
                  DetailsTab(),
                  ManageAccountBody(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityTab(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transactions",
                style: GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  AddTrensectionPopup.showPopup(context);
                },
                child: Text(
                  "+ Add",
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// Transaction List
          Expanded(
            child: ListView(
              children: [
                _dateLabel("Monday December 22, 2025"),
                GestureDetector(
                  onLongPress: () {
                    TrensectionTapaAndHoldPopup.showPopup(context);
                  },
                  child: _transactionTile(
                    title: "SAVE ON FOODS#_F",
                    amount: "-\$15.00",
                    balance: "\$6,488.32",
                  ),
                ),
                _transactionTile(
                  title: "TESORO ITALIAN _ F",
                  amount: "-\$6.00",
                  balance: "\$6,488.32",
                ),

                _dateLabel("Friday December 19, 2025"),
                _transactionTile(
                  title: "STARBUCKS COFFE_F",
                  amount: "-\$15.00",
                  balance: "\$6,488.32",
                ),

                _dateLabel("Thursday December 18, 2025"),
                _transactionTile(
                  title: "SAVE ON FOODS#_F",
                  amount: "-\$15.00",
                  balance: "\$6,488.32",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateLabel(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
      ),
    );
  }

  Widget _transactionTile({
    required String title,
    required String amount,
    required String balance,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  balance,
                  style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDetailsPage extends StatelessWidget {
  const CardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
          title: Text(
            "Banking",
            style: TextStyle(
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
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.green, width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "6644129",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "TD ALL-INCLUSIVE BANKING PLAN",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "\$6,733.32",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.more_vert, size: 20.sp),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// Tab Bar
            TabBar(
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.green,
              indicatorWeight: 2,
              labelStyle: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
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
                  _activityTab(),
                  const Center(child: Text("Details Page")),
                  const Center(child: Text("Manage Page")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityTab() {
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
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Text(
                "+ Add",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
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
                _transactionTile(
                  title: "SAVE ON FOODS#_F",
                  amount: "-\$15.00",
                  balance: "\$6,488.32",
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
        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
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
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  balance,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

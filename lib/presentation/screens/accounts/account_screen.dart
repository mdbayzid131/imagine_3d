import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_color.dart';
import '../../widgets/balance_card.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.h),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Text(
            "Account",
            style: GoogleFonts.poppins(
              fontSize: 30.sp,
              fontWeight: FontWeight.w500,
              height: 1.4,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 20.h),
          SavingsCard(
            title: 'Chase Checking',
            accountNumber: '2545',
            balance: 535,
            balanceTitle: 'Checking',
          ),
          SizedBox(height: 20.h),
          SavingsCard(
            title: 'Chase Checking',
            accountNumber: '2545',
            balance: 535,
            balanceTitle: 'Checking',
            iconColor: Color(0xff0e6ce6),
          ),
          SizedBox(height: 20.h),
          SavingsCard(
            title: 'Chase Checking',
            accountNumber: '2545',
            balance: 535,
            balanceTitle: 'Checking',
            iconColor: Color(0xfffbbf2c),
          ),
          SizedBox(height: 20.h),
          SavingsCard(
            title: 'Chase Checking',
            accountNumber: '2545',
            balance: 200,
            balanceTitle: 'Checking',
            iconColor: Color(0xff4f32d5),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

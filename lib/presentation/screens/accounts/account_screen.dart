import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imagine_3d/presentation/widgets/custom_appbar.dart';

import '../../widgets/balance_card.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.h),
      child: Column(
        children: [
          CustomWidgets.customAppBar(title: 'Account'),
          SavingsCard(
            title: 'Chase Checking',
            accountNumber: '2545',
            balance: 535,
            balanceTitle: 'Checking',
            iconColor: Color(0xffff0000),
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
            balance: 535,
            balanceTitle: 'Checking',
            iconColor: Color(0xff4f32d5),
          ),
          SizedBox(height: 20.h),
          SavingsCard(
            title: 'Chase Checking',
            accountNumber: '2545',
            balance: 535,
            balanceTitle: 'Checking',
            iconColor: Color(0xff49ea00),
          ),
        ],
      ),
    );
  }
}

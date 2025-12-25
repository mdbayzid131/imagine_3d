import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../screens/accounts/account_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/more/more_screen.dart';
import '../screens/move money/move_money.dart';
class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  ///<================================== ALL SCREENS ========================>///
  final screens = <Widget>[
     HomeScreen(),
    const AccountsScreen(),
    const MoveMoneyScreen(),
    const MoreScreen(),
  ];
  ///<================================== END SCREENS ========================>///

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}

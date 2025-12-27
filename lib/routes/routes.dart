import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../presentation/screens/accounts/custom_account_details.dart';
import '../presentation/screens/buttomNabBar_screen/bottom_nab_bar_screen.dart';
import '../presentation/screens/home/card_details_page.dart';



class RoutePages {
  static const String bottomNavBar = '/';
  static const String cardDetailsPage = '/CardDetailsPage';
  // static const String customAccountDetails = '/CustomAccountDetails';
}

final Transition transition = Transition.rightToLeft;

final pages = [
  GetPage(name: RoutePages.bottomNavBar, page: () => BottomNavView()),
  GetPage(name: RoutePages.cardDetailsPage, page: () => CardDetailsPage()),
  // GetPage(name: RoutePages.customAccountDetails, page: () => CustomAccountDetails()),
];

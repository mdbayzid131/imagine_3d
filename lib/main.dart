import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:imagine_3d/core/constants/app_constants.dart';

import 'package:imagine_3d/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'binding/home_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('🔥 Firebase Initialized Successfully');
  final prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString(AppConstants.userId);
  runApp(
    MyApp(
      initialRoute: uid == null
          ? RoutePages.loginScreen
          : RoutePages.bottomNavBar,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Color(0xffffffff),
              scrolledUnderElevation: 0,
            ),
            scaffoldBackgroundColor: Color(0xffffffff),
          ),
          initialRoute: initialRoute,
          getPages: pages,
          initialBinding: HomeBinding(),
        );
      },
    );
  }
}

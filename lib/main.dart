import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:imagine_3d/routes/routes.dart';

import 'binding/home_binding.dart';

import 'data/services/api_client.dart';

void main() async {
/*  WidgetsFlutterBinding.ensureInitialized();
  ApiClient().init();*/

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          initialRoute: RoutePages.loginScreen,
          getPages: pages,
          initialBinding: HomeBinding(),
        );
      },
    );
  }
}

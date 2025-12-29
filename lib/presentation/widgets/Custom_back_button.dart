import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back(); // GetX back navigation
      },
      child: SizedBox(
        height: 40.w,
        width: 40.w,
        child: CircleAvatar(
          backgroundColor: Color(0xffF5F5F5),

          child: Icon(
            Icons.arrow_back_ios_new,
            size: 18.r,
            color: Colors.grey.shade800,
          ),
        ),
      ),
    );
  }
}

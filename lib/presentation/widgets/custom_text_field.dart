import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isLabelVisible;
  final int maxLines;
  final bool readOnly;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;


  const CustomTextField({
    super.key,
    required this.hintText,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.isLabelVisible = true,
    this.maxLines = 1,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.onTap, this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// ================= LABEL =================
        if (isLabelVisible)
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff333333),
              ),
            ),
          ),

        /// ================= TEXT FIELD =================
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          maxLines: maxLines,
          readOnly: readOnly,
          keyboardType: keyboardType,
          onTap: onTap,

          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xff333333),
            fontWeight: FontWeight.w400,
          ),

          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade600,
            ),

            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 16.w,
            ),

            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,

            filled: true,
            fillColor: const Color(0xffEDE8FC),

            /// ====== BORDER STATES ======
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Colors.orange,
                width: 1.2,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Colors.red.shade400,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Colors.red.shade600,
              ),
            ),

            errorStyle: TextStyle(
              fontSize: 11.sp,
              color: Colors.red,
            ),
          ),
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
}

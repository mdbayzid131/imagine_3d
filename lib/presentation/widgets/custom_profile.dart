import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/constants/image_paths.dart';

class CustomProfile extends StatelessWidget {
  final double size;
  final String imagePath;
  final bool isNetworkImage;
  final VoidCallback? onEditTap;
  final Color borderColor;
  final Color editBgColor;
  final bool? isShowPositioned;
  final bool? isShowImagePicker;

  const CustomProfile({
    super.key,
    this.size = 78,
    required this.imagePath,
    this.isNetworkImage = false,
    this.onEditTap,
    this.borderColor = const Color(0xff797272),
    this.editBgColor = const Color(0xffFFEFEF),
    this.isShowPositioned = true,
    this.isShowImagePicker = false,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = size.w;

    return Container(
      height: avatarSize,
      width: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// PROFILE IMAGE
          Center(
            child: CircleAvatar(
              radius: (avatarSize / 2),
              backgroundColor: Colors.green,
              backgroundImage: imagePath.isEmpty
                  ? AssetImage(ImagePaths.profilePic)
                  : isNetworkImage
                  ? NetworkImage(imagePath)
                  : AssetImage(imagePath) as ImageProvider,
            ),
          ),

          /// EDIT ICON
          if (isShowPositioned == true)
            Positioned(
              bottom: -2,
              right: -2,
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: onEditTap,
                child: Container(
                  height: 30.w,
                  width: 30.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: editBgColor,
                    border: Border.all(color: borderColor, width: 1.2),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 17.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';
import '../constants/app_icons.dart';

class CustomFab extends StatelessWidget {
  final VoidCallback onTap;
  final Color? btnColor;
  final String? btnSvg;

  const CustomFab({super.key, required this.onTap, this.btnColor, this.btnSvg});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: btnColor ?? AppColors.btnBlue,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.btnBlue.withOpacity(0.5),
              offset: const Offset(0, 0),
              blurRadius: 40,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: AppColors.black.withOpacity(0.48),
              offset: const Offset(0, 0),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: REdgeInsets.all(14),
        child: SvgPicture.asset(
          btnSvg ?? AppIcons.svgAdd,
          height: 24.h,
          width: 24.h,
          colorFilter: const ColorFilter.mode(AppColors.bgCoolGrey, BlendMode.srcIn),
        ),
      ),
    );
  }
}

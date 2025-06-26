import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class ButtonIcon extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color? btnColor;
  final Color? svgColor;
  final Color borderColor;
  final double borderWith;
  final BoxShape? btnShape;
  final List<BoxShadow>? boxShadow;

  const ButtonIcon({
    super.key,
    required this.onTap,
    required this.child,
    this.btnColor,
    this.svgColor,
    this.btnShape,
    this.borderColor = AppColors.trans,
    this.borderWith = 1,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: btnColor ?? AppColors.bgGrey,
          border: Border.all(color: borderColor, width: borderWith),
          shape: btnShape ?? BoxShape.rectangle,
          boxShadow: boxShadow,
        ),
        padding: REdgeInsets.all(12),
        child: child,
      ),
    );
  }
}

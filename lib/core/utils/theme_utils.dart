import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_watchlist_app/core/constants/app_fonts.dart';

import '../constants/app_colors.dart';

class ThemeUtils {
  static TextStyle textStyle({
    double? fontSize,
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
    Color? bgColor,
    TextAlign? textAlign,
    double? spacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? AppFonts.sfPro,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: fontSize ?? 14.0.sp,
      letterSpacing: spacing ?? 0.0,
      color: color ?? AppColors.textWhite,
      backgroundColor: bgColor,
    );
  }

  static BoxDecoration boxDecoration({
    Color color = AppColors.bgDarkGrey,
    double? borderRadius,
    BoxBorder? border,
    BoxShape shape = BoxShape.rectangle
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4.sp)),
      color: color,
      border: border ?? Border.all(color: AppColors.trans, width: 1),
      shape: shape,
    );
  }
}
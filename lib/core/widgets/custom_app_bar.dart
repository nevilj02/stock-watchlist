import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_watchlist_app/core/utils/theme_utils.dart';

import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String? label;
  final TextStyle? labelStyle;
  final double verticalPadding;
  final double horizontalPadding;
  final Color backgroundColor;

  const CustomAppBar({
    super.key,
    this.leading,
    this.label,
    this.labelStyle,
    this.verticalPadding = 16,
    this.horizontalPadding = 20,
    this.backgroundColor = AppColors.trans,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        padding: REdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            if (label != null) ...[
              if (leading != null) 26.horizontalSpace,
              Expanded(
                child: Text(
                  label!,
                  style:
                      labelStyle ??
                      ThemeUtils.textStyle(
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                ),
              ),
            ],
            if (leading != null) const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}

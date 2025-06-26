import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utils/theme_utils.dart';

class DeleteFromWatchlistSheet extends StatelessWidget {
  final String stockName;
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  const DeleteFromWatchlistSheet({
    required this.stockName,
    required this.onDelete,
    required this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgGrey,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 32,
              offset: Offset(0, -8),
            ),
          ],
        ),
        padding: REdgeInsets.only(top: 45, bottom: 32, left: 32, right: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete from watchlist',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
                color: AppColors.textWhite,
              ),
            ),
            16.verticalSpace,
            Text(
              'Following stock will be deleted from the watchlist. You can add it again anytime.',
              style: ThemeUtils.textStyle(
                fontFamily: AppFonts.inter,
                fontSize: 16.sp,
                color: AppColors.textDarkGrey,
              ),
            ),
            24.verticalSpace,
            Text(
              stockName,
              textAlign: TextAlign.center,
              style: ThemeUtils.textStyle(
                fontFamily: AppFonts.inter,
                color: AppColors.textWhite,
              ),
            ),
            40.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.textRed, width: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 13.5),
                ),
                onPressed: onDelete,
                child: Text(
                  'Delete Stock',
                  style: ThemeUtils.textStyle(
                    fontFamily: AppFonts.inter,
                    color: AppColors.textRed,
                  ),
                ),
              ),
            ),
            24.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 13.5),
                  elevation: 0,
                ),
                onPressed: onCancel,
                child: Text(
                  'Cancel',
                  style: ThemeUtils.textStyle(
                    fontFamily: AppFonts.inter,
                    color: AppColors.textBlack,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

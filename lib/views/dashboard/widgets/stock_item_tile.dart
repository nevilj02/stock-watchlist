import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/theme_utils.dart';
import '../../../models/stock_item.dart';
import '../../../core/constants/app_colors.dart';

class StockItemTile extends StatelessWidget {
  final StockItem item;
  final VoidCallback onDelete;

  const StockItemTile({required this.item, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    final isPositiveChange = item.changePercentage >= 0;
    final textColor = isPositiveChange ? AppColors.textGreen : AppColors.red;

    return GestureDetector(
      onTap:
          () => Get.toNamed(
            AppRoutes.details,
            parameters: {'symbol': item.symbol},
          ),
      child: Container(
        decoration: BoxDecoration(color: AppColors.bgGrey),
        padding: REdgeInsets.symmetric(vertical: 20),
        child: Slidable(
          key: ValueKey(item.symbol),
          groupTag: "watchlist",
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.22,
            children: [
              CustomSlidableAction(
                onPressed: (context) => onDelete(),
                backgroundColor: AppColors.bgBlackGrey,
                child: SvgPicture.asset(
                  AppIcons.svgDelete,
                  width: 24.h,
                  height: 24.h,
                  colorFilter: const ColorFilter.mode(
                    AppColors.icRed,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          child: Container(
            padding: REdgeInsets.only(left: 16, right: 23),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    maxLines: 2,
                    style: ThemeUtils.textStyle(fontFamily: AppFonts.inter),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isPositiveChange ? '+' : ''}₹${item.price.toStringAsFixed(2)}',
                      style: ThemeUtils.textStyle(
                        color: textColor,
                        fontFamily: AppFonts.inter,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      '(${item.changePercentage.abs().toStringAsFixed(2)}%)',
                      style: ThemeUtils.textStyle(
                        color: AppColors.textGrey,
                        fontFamily: AppFonts.inter,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

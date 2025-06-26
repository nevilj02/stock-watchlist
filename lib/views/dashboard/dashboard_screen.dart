import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/theme_utils.dart';
import 'stock_list_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _mainBody(), bottomNavigationBar: _navigationBar());
  }

  Widget _mainBody() => PageView(
    controller: _pageController,
    onPageChanged: (index) {
      setState(() {
        _selectedIndex = index;
      });
    },
    children: const [StockListPage(), StockListPage(), StockListPage()],
  );

  Widget _navigationBar() => Container(
    color: AppColors.bgGrey,
    padding: REdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavItem(0, AppIcons.svgStocks, AppStrings.stocksTab),
        _buildNavItem(1, AppIcons.svgWatchlist, AppStrings.watchlistTab),
        _buildNavItem(2, AppIcons.svgTips, AppStrings.tipsTab),
      ],
    ),
  );

  Widget _buildNavItem(int index, String iconPath, String label) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? AppColors.textBlack : AppColors.textWhite;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        decoration:
            isSelected
                ? BoxDecoration(
                  color: AppColors.btnBlue,
                  borderRadius: BorderRadius.circular(28.r),
                )
                : null,
        padding: REdgeInsets.symmetric(horizontal: 22, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 20.h,
              height: 20.h,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            if (isSelected) ...[
              12.horizontalSpace,
              Text(
                label,
                style: ThemeUtils.textStyle(
                  fontFamily: AppFonts.inter,
                  color: color,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

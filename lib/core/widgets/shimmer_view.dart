import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stock_watchlist_app/core/constants/app_colors.dart';

class ShimmerView extends StatelessWidget {
  final Widget child;
  const ShimmerView({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.bgGrey,
      highlightColor: AppColors.bgDarkGrey,
      child: child,
    );
  }
} 
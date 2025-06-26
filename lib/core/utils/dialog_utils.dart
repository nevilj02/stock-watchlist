import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:stock_watchlist_app/core/constants/app_colors.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context, {String message = 'Loading...'}) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(message),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static Future<T?> showBottomSheet<T>(BuildContext context, Widget child) {
    return Get.bottomSheet<T>(
      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: child,
      ),
      isScrollControlled: true,
    );
  }

  static Future<T?> showBlurredBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: isScrollControlled,
      barrierColor: Colors.transparent,
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: AppColors.textBlack.withOpacity(0.2),
              ),
            ),
          ),
          // The actual bottom sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: child,
          ),
        ],
      ),
    );
  }
} 
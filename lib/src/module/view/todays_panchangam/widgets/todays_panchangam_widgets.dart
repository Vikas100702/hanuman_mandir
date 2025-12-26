import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/module/view/global_widgets/global_widgets.dart';

class TodaysPanchangamWidgets {
  static Widget panchangamCards({
    required String title,
    required Widget child,
    double? height, //optional
    EdgeInsetsGeometry? contentPadding,
  }) {
    final double dynamicHeight = height ?? 450.h;
    return Container(
      height: dynamicHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            color: AppColors.darkRed,
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.openSans(
                    color: AppColors.white,
                    fontSize: 18.sp,
                    fontWeight: .bold,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(height: 10.h),
                GlobalWidgets.customDivider(
                  height: 2.h,
                  width: 150.w,
                  color: const Color(0xFFD9950B),
                ),
              ],
            ),
          ),

          // Body Section
          Expanded(
            child: Container(
              padding: contentPadding ?? EdgeInsets.all(16.0.w),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_card.png"),
                  fit: .fill,
                ),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

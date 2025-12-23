import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/module/view/global_widgets/global_widgets.dart';

class TodaysPanchangamWidgets {
  static Widget panchangamCards({
    required String title,
    required Widget child,
    double height = 400,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: AppColors.darkRed,
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.openSans(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: .bold,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 10),
                GlobalWidgets.customDivider(
                  height: 2,
                  width: 150,
                  color: const Color(0xFFD9950B),
                ),
              ],
            ),
          ),

          // Body Section
          Expanded(
            child: Container(
              padding: contentPadding ?? const EdgeInsets.all(16.0),
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/bg_card.png"))),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

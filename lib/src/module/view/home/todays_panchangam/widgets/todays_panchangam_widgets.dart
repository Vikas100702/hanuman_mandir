import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/module/view/home/global_widgets/global_widgets.dart';

class TodaysPanchangamWidgets {
  static Widget panchangamCards({
    required BuildContext context,
    required String title,
    required Widget child,
    double? height,
    EdgeInsetsGeometry? contentPadding,
  }) {
    final bool isMobile = context.isMobile;

    return Container(
      height: isMobile ? 500 : 550,
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
            padding: EdgeInsets.symmetric(
              vertical: context.responsiveHeight(12, 16),
              horizontal: context.responsiveWidth(16, 20),
            ),
            color: AppColors.darkRed,
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.openSans(
                    color: AppColors.white,
                    fontSize: context.responsiveSize(16, 18),
                    fontWeight: .bold,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(height: context.responsiveHeight(8, 10)),
                GlobalWidgets.customDivider(
                  height: 2,
                  width: context.responsiveWidth(120, 150),
                  color: const Color(0xFFD9950B),
                ),
              ],
            ),
          ),

          // Body Section
          Expanded(
            child: Container(
              padding:
                  contentPadding ??
                  EdgeInsets.all(context.responsiveWidth(16, 20)),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_card.png"),
                  fit: .cover,
                ),
                borderRadius: .only(
                  bottomLeft: .circular(8),
                  bottomRight: .circular(8),
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

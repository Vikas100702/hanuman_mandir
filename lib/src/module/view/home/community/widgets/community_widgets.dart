import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';

class CommunityWidgets {
  static Widget communityCard(
    BuildContext context, {
    required String title,
    required String description,
    required String buttonText,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    double cardHeight = context.isMobile ? 300 : 350;

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: .fill),
      ),

      child: Container(
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: 0.5),
        ),
        padding: .symmetric(
          horizontal: context.responsiveWidth(20, 40),
          vertical: 20,
        ),

        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Text(
              title,
              textAlign: .center,
              style: GoogleFonts.openSans(
                fontSize: context.responsiveSize(22, 28),
                fontWeight: .bold,
                color: AppColors.textWhite,
              ),
            ),
            SizedBox(height: context.responsiveHeight(15, 20)),

            Text(
              description,
              textAlign: .center,
              style: GoogleFonts.roboto(
                fontSize: context.responsiveSize(14, 16),
                color: AppColors.textWhite,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            SizedBox(height: context.responsiveHeight(25, 35)),

            OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.white, width: 2),
                padding: .symmetric(
                  horizontal: context.responsiveWidth(30, 40),
                  vertical: context.responsiveHeight(12, 18),
                ),
                shape: RoundedRectangleBorder(borderRadius: .circular(4)),
              ),
              child: Text(
                buttonText.toUpperCase(),
                style: GoogleFonts.openSans(
                  color: AppColors.textWhite,
                  fontWeight: .bold,
                  fontSize: context.responsiveSize(14, 16),
                  letterSpacing: 1.0
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

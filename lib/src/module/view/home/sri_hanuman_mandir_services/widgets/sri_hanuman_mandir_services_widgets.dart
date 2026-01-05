import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';

class SriHanumanMandirServicesWidgets {
  static Widget serviceCard(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
    required String imageUrl,
    double height = 180,
    double width = 160,
    double fontSize = 14,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        // 1. Base Container with the Background Texture
        decoration: BoxDecoration(
          color: AppColors.white, // Fallback
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: Image.asset(
                  imageUrl,
                  fit: .cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                ),
              ),
            ),

            // 2. Bottom Text Section
            Container(height: context.responsiveHeight(50, 45), padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              ), child: Column(
                mainAxisAlignment: .center,
                children: [
                  // Title
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: fontSize,
                      fontWeight: .bold,
                      color: AppColors.black
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Image.asset(
                    'assets/images/border.png', // Reusing your border asset as the divider
                    height: 5,
                    width: 40,
                    fit: BoxFit.contain,
                  ),
                ],
              ),)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../../core/const/app_colors.dart';

class SriHanumanMandirServicesWidgets {
  /// A reusable card widget for Mandir Services (e.g., Pooja, Donation)
  /// replicating the design with 'bg_card.png' and 'border.png'.
  static Widget serviceCard(
      BuildContext context, {
        required String title,
        required VoidCallback onTap,
        required String imageUrl,
        double height = 110,
        double width = 110,
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
          borderRadius: BorderRadius.circular(12), // Adjust if border.png is square
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 2. The Ornamental Border Overlay
            // Positioned.fill(
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(12),
            //     child: Image.asset(
            //       'assets/images/border.png',
            //       fit: BoxFit.fill, // Stretches border to match container
            //     ),
            //   ),
            // ),

            // 3. Centered Title Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins', // Or your app's default font
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Dark text for contrast against bg_card
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/core/widgets/app_image.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:hanuman_mandir/src/module/model/banner/banner_model.dart';
import 'package:image_network/image_network.dart';

class BannerWidgets {
  /// Main builder for a single Banner Item
  static Widget buildBannerItem(BuildContext context, Datum data) {
    final String imageUrl = "${Endpoints.globalUrl}${data.refDataName}";

    // 1. Check for "ONLY IMAGE" type
    if (data.bannerType == "ONLY IMAGE") {
      return _buildFullImage(context, imageUrl);
    }

    // 2. Render Responsive Layout for Text+Image Banners
    return ResponsiveView(
      mobile: _buildMobileLayout(context, data, imageUrl),
      desktop: _buildDesktopLayout(context, data, imageUrl),
    );
  }

  // --- LAYOUTS ---

  /// Full image banner (no text)
  static Widget _buildFullImage(BuildContext context, String imageUrl) {
    return SizedBox(
      width: .infinity,
      height: .infinity,
      child: AppImage(imageUrl: imageUrl, fit: .cover),
    );
    /*return LayoutBuilder(
      builder: (context, constraints) {
        // Use constraints from parent (carousel)
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: ImageNetwork(
            image: imageUrl,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            fitAndroidIos: BoxFit.cover,
            fitWeb: BoxFitWeb.fill,
            onLoading: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            onError: Icon(
              Icons.image_not_supported,
              color: AppColors.errorColor,
              size: 50,
            ),
          ),
        );
      },
    );*/
  }

  static Widget _buildDesktopLayout(BuildContext context, Datum data, String imageUrl) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use half of available width for each side
        final halfWidth = constraints.maxWidth / 2;
        final fullHeight = constraints.maxHeight;

        return Row(
          children: [
            // Image Side
            SizedBox(
              width: halfWidth,
              height: fullHeight,
              child: AppImage(imageUrl: imageUrl, fit: BoxFit.cover),
              /*child: ImageNetwork(
                image: imageUrl,
                width: halfWidth,
                height: fullHeight,
                fitAndroidIos: BoxFit.cover,
                fitWeb: BoxFitWeb.fill,
                onLoading: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                onError: Icon(
                  Icons.image_not_supported,
                  color: AppColors.errorColor,
                  size: 50,
                ),
              ),*/
            ),
            // Text Side
            SizedBox(
              width: halfWidth,
              height: fullHeight,
              child: _buildTextContainer(context, data, isMobile: false),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildMobileLayout(BuildContext context, Datum data, String imageUrl) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fullWidth = constraints.maxWidth;
        final fullHeight = constraints.maxHeight;

        // Image takes 60% of height, text takes 40%
        final imageHeight = fullHeight * 0.75;
        final textHeight = fullHeight * 0.25;

        return Column(
          children: [
            // Image Section
            SizedBox(
              width: fullWidth,
              height: imageHeight,
              child: AppImage(imageUrl: imageUrl, fit: BoxFit.cover),
              /*child: ImageNetwork(
                image: imageUrl,
                width: fullWidth,
                height: imageHeight,
                fitAndroidIos: BoxFit.cover,
                fitWeb: BoxFitWeb.cover,
                onLoading: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                onError: Icon(
                  Icons.image_not_supported,
                  color: AppColors.errorColor,
                  size: 50,
                ),
              ),*/
            ),
            // Text Section
            SizedBox(
              width: fullWidth,
              height: textHeight,
              child: _buildTextContainer(context, data, isMobile: true),
            ),
          ],
        );
      },
    );
  }

  // --- HELPER WIDGETS ---

  static Widget _buildTextContainer(BuildContext context, Datum data, {required bool isMobile}) {
    String cleanDescription = (data.bannerDesc ?? "").removeHtmlTags();
    String cleanHeading = (data.bannerHeading ?? "").replaceBackslash();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          opacity: 0.8,
          image: AssetImage("assets/images/banner_bg.png"),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveWidth(20, 40),
          vertical: context.responsiveHeight(20, 30),
        ),
        child: Column(
          crossAxisAlignment: isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: _buildTextChildren(
            context,
            data,
            cleanHeading,
            cleanDescription,
            isMobile,
          ),
        ),
      ),
    );
  }

  static List<Widget> _buildTextChildren(
      BuildContext context,
      Datum data,
      String heading,
      String description,
      bool isMobile) {
    return [
      // Heading
      Text(
        heading,
        textAlign: isMobile ? TextAlign.center : TextAlign.left,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.openSans(
          color: const Color(0xFF44233B),
          fontSize: context.responsiveSize(24, 32),
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
      ),
      SizedBox(height: context.responsiveHeight(8, 10)),

      // Divider Image
      Center(
        child: Image.asset(
          "assets/images/border.png",
          height: context.responsiveHeight(10, 30),
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: context.responsiveHeight(10, 15),
              width: 200,
              color: const Color(0xFFD9950B),
            );
          },
        ),
      ),
      SizedBox(height: context.responsiveHeight(12, 20)),

      // SubHeading
      if (data.bannerSubHeading != null && data.bannerSubHeading!.isNotEmpty)
        Padding(
          padding: EdgeInsets.only(bottom: context.responsiveHeight(8, 12)),
          child: Text(
            data.bannerSubHeading!,
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              color: const Color(0xFF4D4643),
              fontSize: context.responsiveSize(16, 20),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      // Description
      Text(
        description,
        textAlign: isMobile ? TextAlign.justify : TextAlign.left,
        style: GoogleFonts.openSans(
          color: AppColors.black,
          fontSize: context.responsiveSize(14, 18),
          height: 1.5,
        ),
      ),
    ];
  }
}
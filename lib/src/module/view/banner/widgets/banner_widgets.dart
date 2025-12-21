import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:hanuman_mandir/src/module/model/banner/banner_model.dart';
import 'package:image_network/image_network.dart';

class BannerWidgets {

  /// Main builder for a single Banner Item
  static Widget buildBannerItem(BuildContext context, Datum data) {
    final String imageUrl = "${Endpoints.globalUrl}${data.refDataName}";

    // 1. Check for "ONLY IMAGE" type
    if (data.bannerType == "ONLY IMAGE") {
      return _buildImage(imageUrl, BoxFit.fill);
    }

    // 2. Render Responsive Layout for Text+Image Banners
    return ResponsiveView(
      mobile: _buildMobileLayout(context, data, imageUrl),
      desktop: _buildDesktopLayout(context, data, imageUrl),
    );
  }

  // --- LAYOUTS ---

  static Widget _buildDesktopLayout(BuildContext context, Datum data, String imageUrl) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: _buildImage(imageUrl, BoxFit.fill),
          ),
        ),
        Expanded(
          flex: 1,
          child: _buildTextContainer(context, data, isMobile: false),
        ),
      ],
    );
  }

  static Widget _buildMobileLayout(BuildContext context, Datum data, String imageUrl) {
    return Column(
      children: [
        // Image Section (16:9 Aspect Ratio)
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            width: double.infinity,
            color: AppColors.black,
            child: _buildImage(imageUrl, BoxFit.cover),
          ),
        ),
        // Text Section (Fills remaining space)
        Expanded(
          child: _buildTextContainer(context, data, isMobile: true),
        ),
      ],
    );
  }

  // --- HELPER WIDGETS ---

  /// Wraps ImageNetwork in LayoutBuilder to prevent "Infinity" errors on Web
  static Widget _buildImage(String url, BoxFit fit) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ImageNetwork(
          image: url,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          fitAndroidIos: fit,
          fitWeb: BoxFitWeb.fill,
          onLoading: const Center(child: CircularProgressIndicator()),
          onError: Icon(Icons.error, color: AppColors.errorColor),
        );
      },
    );
  }

  static Widget _buildTextContainer(BuildContext context, Datum data, {required bool isMobile}) {
    String cleanDescription = (data.bannerDesc ?? "").removeHtmlTags();
    String cleanHeading = (data.bannerHeading ?? "").replaceBackslash();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          opacity: 0.8,
          image: AssetImage("assets/images/banner_bg.png"),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: isMobile
            ? ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: _buildTextChildren(data, cleanHeading, cleanDescription, isMobile),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildTextChildren(data, cleanHeading, cleanDescription, isMobile),
        ),
      ),
    );
  }

  static List<Widget> _buildTextChildren(
      Datum data, String heading, String description, bool isMobile) {
    return [
      if (!isMobile) const Spacer(),

      // Heading
      Center(
        child: Text(
          heading,
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            color: const Color(0xFF44233B),
            fontSize: isMobile ? 28 : 32,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
        ),
      ),
      const SizedBox(height: 5),

      // Divider Image
      Center(
        child: Image.asset("assets/images/border.png"),
      ),
      const SizedBox(height: 15),

      // SubHeading
      if (data.bannerSubHeading != null && data.bannerSubHeading!.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "${data.bannerSubHeading ?? ""}\n",
            textAlign: TextAlign.left,
            style: GoogleFonts.openSans(
              color: const Color(0xFF4D4643),
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      // Description
      isMobile
          ? Text(
        description,
        textAlign: TextAlign.justify,
        style: GoogleFonts.openSans(
          color: AppColors.black,
          fontSize: 16,
          height: 1.5,
        ),
      )
          : Expanded(
        child: SingleChildScrollView(
          child: Text(
            description,
            textAlign: TextAlign.left,
            style: GoogleFonts.openSans(
              color: AppColors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),

      if (!isMobile) const Spacer(),
    ];
  }
}
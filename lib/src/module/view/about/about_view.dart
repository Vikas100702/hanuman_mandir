import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:hanuman_mandir/src/data/services/about/about_service.dart';
import 'package:hanuman_mandir/src/module/controller/about/about_controller.dart';
import 'package:hanuman_mandir/src/module/model/about/about_model.dart';
import 'package:image_network/image_network.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final AboutController aboutController = Get.find<AboutController>();
    return Obx(() {
      if (aboutController.isLoading.value) {
        return SizedBox(
          height: context.responsiveHeight(200, 250),
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      final AboutDatum? data = aboutController.aboutData;
      if (data == null) {
        return const SizedBox.shrink();
      }

      return Container(
        color: const Color(0xFFFFF8E1),
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveHeight(30, 50),
          horizontal: context.responsiveWidth(40, 60),
        ),
        child: ResponsiveView(
          mobile: _buildMobileLayout(context, data),
          desktop: _buildDesktopLayout(context, data),
        ),
      );
    });
  }

  // --- DESKTOP LAYOUT ---
  Widget _buildDesktopLayout(BuildContext context, AboutDatum data) {
    return Row(
      crossAxisAlignment: .center,
      mainAxisAlignment: .center,
      children: [
        // Text Section (Left)
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: _buildTextContent(context, data, isMobile: false),
          ),
        ),
        // Image Section (Right)
        Expanded(child: _buildImageContent(context, data)),
      ],
    );
  }

  // --- MOBILE LAYOUT ---
  Widget _buildMobileLayout(BuildContext context, AboutDatum data) {
    return Column(
      children: [
        _buildTextContent(context, data, isMobile: true),
        SizedBox(height: context.responsiveHeight(20, 30)),
        _buildImageContent(context, data),
      ],
    );
  }

  // --- SHARED TEXT WIDGET ---
  Widget _buildTextContent(
    BuildContext context,
    AboutDatum data, {
    required bool isMobile,
  }) {
    return Column(
      crossAxisAlignment: isMobile ? .center : .center,
      children: [
        // Title
        Text(
          data.title ?? "",
          textAlign: isMobile ? .center : .center,
          style: GoogleFonts.openSans(
            color: AppColors.primaryRed,
            fontSize: context.responsiveSize(24, 32),
            fontWeight: .bold,
          ),
        ),

        // Decorative Divider
        SizedBox(height: context.responsiveHeight(10, 15)),
        Image.asset(
          "assets/images/border.png",
          height: context.responsiveHeight(10, 45),
          width: 1050,
          fit: .contain,
        ),
        SizedBox(height: context.responsiveHeight(20, 30)),

        // Body Text
        Text(
          data.description ?? "",
          textAlign: .justify,
          style: GoogleFonts.openSans(
            color: AppColors.black,
            fontSize: context.responsiveSize(14, 16),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  // --- SHARED IMAGE WIDGET
  Widget _buildImageContent(BuildContext context, AboutDatum data) {
    final bool isNetworkImage =
        data.imageUrl != null && data.imageUrl!.startsWith("http");

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: .circular(12),
            child: isNetworkImage
                ? ImageNetwork(
                    image: data.imageUrl!,
                    height: 400,
                    width: .infinity,
                    fitAndroidIos: BoxFit.cover,
                    fitWeb: BoxFitWeb.cover,
                  )
                : Image.asset(
                    "assets/images/jai_sri_ram.jpg",
                    fit: BoxFit.cover,
                    // Fallback for demo if asset missing
                    errorBuilder: (c, o, s) => Container(
                      height: 400,
                      color: AppColors.deepPurple,
                      child: const Center(
                        child: Icon(Icons.image, color: Colors.white, size: 50),
                      ),
                    ),
                  ),
          ),
        ),

        // Buttons
        SizedBox(height: context.responsiveHeight(20, 30)),
        Row(
          children: [
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.end,
              children: [
                _buildOutlineButton(context, "KNOW MORE"),
                _buildOutlineButton(context, "ABOUT DEITIES"),
                _buildOutlineButton(context, "GENERAL INFO"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOutlineButton(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
        // Gold Border
        color: Colors.transparent,
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: context.responsiveSize(12, 13),
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:hanuman_mandir/src/module/model/about/about_model.dart';
import 'package:image_network/image_network.dart';

class AboutWidget extends StatelessWidget {
  final AboutDatum data;
  final bool isImageOnLeft;
  final List<String> buttons;

  const AboutWidget({
    super.key,
    required this.data,
    this.isImageOnLeft = false,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      mobile: _buildMobileLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  // --- DESKTOP LAYOUT ---
  Widget _buildDesktopLayout(BuildContext context) {
    // Defining the Text and Image widgets
    final textSection = Expanded(
      flex: 1,
      child: Padding(
        padding: .only(
          right: isImageOnLeft ? 0 : 40,
          left: isImageOnLeft ? 40 : 0,
        ),
        child: _buildTextContent(context, isMobile: false),
      ),
    );

    final imageSection = Expanded(flex: 1, child: _buildImageContent(context));

    return Row(
      crossAxisAlignment: .center,
      mainAxisAlignment: .center,
      children: isImageOnLeft
          ? [imageSection, textSection]
          : [textSection, imageSection],
    );
  }

  // --- MOBILE LAYOUT ---
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildTextContent(context, isMobile: true),
        SizedBox(height: context.responsiveHeight(20, 30)),
        _buildImageContent(context),
      ],
    );
  }

  // --- SHARED TEXT WIDGET ---
  Widget _buildTextContent(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: .center,
      children: [
        // Title
        Text(
          data.title ?? "",
          textAlign: .center,
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
        SizedBox(height: context.responsiveHeight(20, 25)),

        // Body Text
        Text(
          data.description ?? "",
          textAlign: .justify,
          style: GoogleFonts.openSans(
            color: AppColors.black,
            fontSize: context.responsiveSize(14, 16),
            fontWeight: .w600,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  // --- SHARED IMAGE WIDGET
  Widget _buildImageContent(BuildContext context) {
    final bool isNetworkImage =
        data.imageUrl != null && data.imageUrl!.startsWith("http");

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
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
                    data.imageUrl!,
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
          mainAxisAlignment: .spaceEvenly,
          children: buttons
              .map((btnText) => _buildOutlineButton(context, btnText))
              .toList(),
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

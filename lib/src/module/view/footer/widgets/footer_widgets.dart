import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/module/model/footer/footer_model.dart';
import 'package:hanuman_mandir/src/module/view/footer/widgets/footer_audio_player.dart';
import 'package:image_network/image_network.dart';

class FooterWidgets {
  // Custom Yellow Underline
  static Widget customDivider({
    required double height,
    required double width,
    required Color color,
  }) {
    return Container(height: height, width: width, color: color);
  }

  // MAIN CONTENT BUILDER
  static List<Widget> buildFooterContent({
    required bool isDesktop,
    Datum? data,
    String? logoUrl,
  }) {
    return [
      // 1. LOGO & AUDIO SECTION
      Column(
        children: [
          Container(
            height: 150,
            width: 150,
            margin: const EdgeInsets.only(bottom: 20),
            child: (logoUrl != null && logoUrl.isNotEmpty) ? ImageNetwork(image: "${Endpoints.globalUrl}$logoUrl", height: 150, width: 150, fitAndroidIos: .contain,) :Image.asset(
              "assets/images/left_header_logo.png",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.error, color: Colors.white),
                );
              },
            ),
          ),

          // Audio Player Section
          const FooterAudioPlayer(),
          if (!isDesktop) const SizedBox(height: 30),
        ],
      ),

      // 2. ABOUT US SECTION
      Column(
        crossAxisAlignment: isDesktop
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          _buildSectionHeader("ABOUT US", isDesktop),
          const SizedBox(height: 20),
          _buildFooterLink("ABOUT TEMPLE"),
          _buildFooterLink("EVENTS"),
          _buildFooterLink("SERVICES"),
          _buildFooterLink("DONATIONS"),
          _buildFooterLink("CALENDAR"),
        ],
      ),

      // 3. TEMPLE TIMINGS SECTION
      Column(
        crossAxisAlignment: isDesktop
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          _buildSectionHeader("TEMPLE TIMINGS", isDesktop),
          const SizedBox(height: 20),

          // Timings Block
          SizedBox(
            width: 320,
            child: Column(
              children: [
                // Weekdays
                IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          "WEEKDAYS",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        width: 1,
                        color: Colors.white30,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Expanded(
                        child: Text(
                          "${data?.weekdayMorningTime ?? '9:00 AM TO 1:00 PM'}\n${data?.weekDayEveningTime ?? '5:00 PM TO 9:00 PM'}",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.white30, height: 1),
                const SizedBox(height: 10),
                // Weekends
                IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          "WEEKENDS",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        width: 1,
                        color: Colors.white30,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Expanded(
                        child: Text(
                          "${data?.weekEndMorningTime ?? '09:00 AM'} ${data?.weekEndEveningTime ?? '09:00 PM'}",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // FOLLOW US
          Column(
            crossAxisAlignment: isDesktop
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              _buildSectionHeader("FOLLOW US", isDesktop),
              const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min, // Center the row itself
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(Icons.facebook),
                  const SizedBox(width: 15),
                  _buildSocialIcon(Icons.video_library_rounded),
                ],
              ),
            ],
          ),
        ],
      ),

      // DIVIDER LINE (Desktop Only)
      if (isDesktop)
        Transform.rotate(
          angle: 0.1,
          child: Container(
            height: 250,
            width: 2,
            color: const Color(0xFFD9950B),
          ),
        ),

      // 4. CONNECT WITH US SECTION
      Column(
        crossAxisAlignment: isDesktop
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          _buildSectionHeader("CONNECT WITH US", isDesktop),
          const SizedBox(height: 25),

          _buildContactRow(
            Icons.location_on,
            data?.refDataCode ?? "390 Cumming Street Suite B,\nAlpharetta, GA 30004",
            isDesktop,
          ),
          const SizedBox(height: 15),
          _buildContactRow(
            Icons.phone,
            "+1 ${data?.phone ?? "+1 770-475-7701"}",
            isDesktop,
          ),
          const SizedBox(height: 10),
          _buildContactRow(Icons.phone_android, "+1 470-454-4029", isDesktop),
          const SizedBox(height: 10),
          _buildContactRow(
            Icons.email,
            data?.email ?? "manager@srihanuman.org",
            isDesktop,
          ),
        ],
      ),
    ];
  }

  // --- HELPER WIDGETS ---

  static Widget _buildSectionHeader(String title, bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        customDivider(height: 2, width: 150, color: const Color(0xFFD9950B)),
      ],
    );
  }

  static Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.openSans(
          color: Colors.white,
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }

  static Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  static Widget _buildContactRow(IconData icon, String text, bool isDesktop) {
    // For mobile, we want MainAxisAlignment.center to align content in the middle
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isDesktop
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Icon(icon, color: Colors.white, size: 16)),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
            ),
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          ),
        ),
      ],
    );
  }
}

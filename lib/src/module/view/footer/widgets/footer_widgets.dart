import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/module/model/footer/footer_model.dart';
import 'package:hanuman_mandir/src/module/view/footer/widgets/footer_audio_player.dart';
import 'package:hanuman_mandir/src/module/view/global_widgets/global_widgets.dart';
import 'package:image_network/image_network.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidgets {
  // MAIN CONTENT BUILDER
  static List<Widget> buildFooterContent({
    required BuildContext context,
    required bool isDesktop,
    Datum? data,
    String? logoUrl,
  }) {
    Future<void> launchFacebookUrl() async {
      final Uri facebookUrl = Uri.parse("${data?.facebookLink}");

      if (!await launchUrl(facebookUrl, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $facebookUrl');
      }
    }

    Future<void> launchYoutubeUrl() async {
      final Uri facebookUrl = Uri.parse("${data?.youtubeLink}");

      if (!await launchUrl(facebookUrl, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $facebookUrl');
      }
    }

    return [
      // 1. LOGO & AUDIO SECTION
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: isDesktop ? 120 : context.responsiveHeight(100, 120),
            width: isDesktop ? 120 : context.responsiveWidth(100, 120),
            margin: EdgeInsets.only(bottom: context.responsiveHeight(15, 20)),
            child: (logoUrl != null && logoUrl.isNotEmpty)
                ? ImageNetwork(
                    image: "${Endpoints.globalUrl}$logoUrl",
                    height: isDesktop
                        ? 120
                        : context.responsiveHeight(100, 120),
                    width: isDesktop ? 120 : context.responsiveWidth(100, 120),
                    fitAndroidIos: BoxFit.contain,
                    fitWeb: BoxFitWeb.contain,
                    onError: Icon(Icons.error, color: Colors.white),
                  )
                : Image.asset(
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
        ],
      ),

      // 2. ABOUT US SECTION
      Column(
        crossAxisAlignment: isDesktop
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionHeader(context, "ABOUT US", isDesktop),
          SizedBox(height: context.responsiveHeight(15, 20)),
          _buildFooterLink(context, "ABOUT TEMPLE"),
          _buildFooterLink(context, "EVENTS"),
          _buildFooterLink(context, "SERVICES"),
          _buildFooterLink(context, "DONATIONS"),
          _buildFooterLink(context, "CALENDAR"),
        ],
      ),

      // 3. TEMPLE TIMINGS SECTION
      Column(
        crossAxisAlignment: isDesktop
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionHeader(context, "TEMPLE TIMINGS", isDesktop),
          SizedBox(height: context.responsiveHeight(15, 20)),

          // Timings Block
          Container(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 320 : context.screenWidth * 0.8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: .start,
              children: [
                // Weekdays
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: context.responsiveWidth(90, 100),
                      child: Text(
                        "WEEKDAYS",
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: context.responsiveSize(14, 16),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.white30,
                      margin: EdgeInsets.symmetric(
                        horizontal: context.responsiveWidth(10, 12),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "${data?.weekdayMorningTime ?? '9:00 AM TO 1:00 PM'}\n${data?.weekDayEveningTime ?? '5:00 PM TO 9:00 PM'}",
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: context.responsiveSize(13, 16),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.responsiveHeight(8, 10)),
                Divider(color: Colors.white30, height: 1, thickness: 1),
                SizedBox(height: context.responsiveHeight(8, 10)),
                // Weekends
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: context.responsiveWidth(90, 100),
                      child: Text(
                        "WEEKENDS",
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: context.responsiveSize(14, 16),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Colors.white30,
                      margin: EdgeInsets.symmetric(
                        horizontal: context.responsiveWidth(10, 12),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "${data?.weekEndMorningTime ?? '09:00 AM'} TO ${data?.weekEndEveningTime ?? '09:00 PM'}",
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: context.responsiveSize(13, 16),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: context.responsiveHeight(20, 25)),

          // FOLLOW US
          Column(
            crossAxisAlignment: isDesktop
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSectionHeader(context, "FOLLOW US", isDesktop),
              SizedBox(height: context.responsiveHeight(12, 15)),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(
                    context,
                    Icons.facebook,
                    () => launchFacebookUrl() as Function(),
                  ),
                  SizedBox(width: context.responsiveWidth(12, 15)),
                  _buildSocialIcon(
                    context,
                    Icons.video_library_rounded,
                    () => launchYoutubeUrl(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // DIVIDER LINE (Desktop Only)
      if (isDesktop)
        Container(
          height: 200,
          width: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFD9950B).withOpacity(0.3),
                const Color(0xFFD9950B),
                const Color(0xFFD9950B).withOpacity(0.3),
              ],
            ),
          ),
        ),

      // 4. CONNECT WITH US SECTION
      Column(
        crossAxisAlignment: isDesktop
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionHeader(context, "CONNECT WITH US", isDesktop),
          SizedBox(height: context.responsiveHeight(20, 25)),

          _buildContactRow(
            context,
            Icons.location_on,
            data?.refDataCode ??
                "390 Cumming Street Suite B,\nAlpharetta, GA 30004",
            isDesktop,
          ),
          SizedBox(height: context.responsiveHeight(12, 15)),
          _buildContactRow(
            context,
            Icons.phone,
            "+1 ${data?.phone ?? '770-475-7701'}",
            isDesktop,
          ),
          SizedBox(height: context.responsiveHeight(8, 10)),
          _buildContactRow(
            context,
            Icons.phone_android,
            "+1 470-454-4029",
            isDesktop,
          ),
          SizedBox(height: context.responsiveHeight(8, 10)),
          _buildContactRow(
            context,
            Icons.email,
            data?.email ?? "manager@srihanuman.org",
            isDesktop,
          ),
        ],
      ),
    ];
  }

  // --- HELPER WIDGETS ---

  static Widget _buildSectionHeader(
    BuildContext context,
    String title,
    bool isDesktop,
  ) {
    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: context.responsiveSize(15, 16),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: context.responsiveHeight(6, 8)),
        GlobalWidgets.customDivider(
          height: 2,
          width: context.responsiveWidth(120, 150),
          color: const Color(0xFFD9950B),
        ),
      ],
    );
  }

  static Widget _buildFooterLink(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsiveHeight(6, 8)),
      child: Text(
        text,
        style: GoogleFonts.openSans(
          color: Colors.white,
          fontSize: context.responsiveSize(14, 16),
          height: 1.5,
        ),
      ),
    );
  }

  static Widget _buildSocialIcon(
    BuildContext context,
    IconData icon,
    Function() onPressed,
  ) {
    return Container(
      padding: EdgeInsets.all(context.responsiveSize(8, 10)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: context.responsiveSize(18, 22)),
        color: Colors.white,
        // iconSize: context.responsiveSize(16, 18),
      ),
    );
  }

  static Widget _buildContactRow(
    BuildContext context,
    IconData icon,
    String text,
    bool isDesktop,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isDesktop
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: context.responsiveSize(14, 16)),
        SizedBox(width: context.responsiveWidth(10, 12)),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: context.responsiveSize(13, 16),
              height: 1.5,
            ),
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

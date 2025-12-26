import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/module/model/footer/footer_model.dart';
import 'package:hanuman_mandir/src/module/view/footer/widgets/footer_audio_player.dart';
import 'package:hanuman_mandir/src/module/view/global_widgets/global_widgets.dart';
import 'package:image_network/image_network.dart';

class FooterWidgets {
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
            height: isDesktop ? 150 : 150.h,
            width: isDesktop ? 140 : 150.w,
            margin: EdgeInsets.only(bottom: 20.h),
            child: (logoUrl != null && logoUrl.isNotEmpty)
                ? ImageNetwork(
                    image: "${Endpoints.globalUrl}$logoUrl",
                    height: isDesktop ? 150 : 150.h,
                    width: isDesktop ? 150 : 150.h,
                    fitAndroidIos: .contain,
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
          if (!isDesktop) SizedBox(height: 30.h),
        ],
      ),

      // 2. ABOUT US SECTION
      Column(
        crossAxisAlignment: isDesktop
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          _buildSectionHeader("ABOUT US", isDesktop),
          SizedBox(height: 20.h),
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
          SizedBox(height: 20.h),

          // Timings Block
          SizedBox(
            width: isDesktop ? 320 : 320.w,
            child: Column(
              children: [
                // Weekdays
                IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: Text(
                          "WEEKDAYS",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        width: 1,
                        color: Colors.white30,
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                      ),
                      Expanded(
                        child: Text(
                          "${data?.weekdayMorningTime ?? '9:00 AM TO 1:00 PM'}\n${data?.weekDayEveningTime ?? '5:00 PM TO 9:00 PM'}",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16.sp,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(color: Colors.white30, height: 1.h),
                SizedBox(height: 10.h),
                // Weekends
                IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: Text(
                          "WEEKENDS",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.white30,
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                      ),
                      Expanded(
                        child: Text(
                          "${data?.weekEndMorningTime ?? '09:00 AM'} ${data?.weekEndEveningTime ?? '09:00 PM'}",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16.sp,
                            height: 1.4.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // FOLLOW US
          Column(
            crossAxisAlignment: isDesktop
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              _buildSectionHeader("FOLLOW US", isDesktop),
              SizedBox(height: 15.h),
              Row(
                mainAxisSize: MainAxisSize.min, // Center the row itself
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(Icons.facebook),
                  SizedBox(width: 15.h),
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
            height: 250.h,
            width: 2.w,
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
          SizedBox(height: 25.h),

          _buildContactRow(
            Icons.location_on,
            data?.refDataCode ??
                "390 Cumming Street Suite B,\nAlpharetta, GA 30004",
            isDesktop,
          ),
          SizedBox(height: 15.h),
          _buildContactRow(
            Icons.phone,
            "+1 ${data?.phone ?? "+1 770-475-7701"}",
            isDesktop,
          ),
          SizedBox(height: 10.h),
          _buildContactRow(Icons.phone_android, "+1 470-454-4029", isDesktop),
          SizedBox(height: 10.h),
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
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        GlobalWidgets.customDivider(
          height: 2.h,
          width: 150.w,
          color: const Color(0xFFD9950B),
        ),
      ],
    );
  }

  static Widget _buildFooterLink(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: GoogleFonts.openSans(
          color: Colors.white,
          fontSize: 16.sp,
          height: 1.5.h,
        ),
      ),
    );
  }

  static Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.w),
      ),
      child: Icon(icon, color: Colors.white, size: 18.sp),
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
        Center(child: Icon(icon, color: Colors.white, size: 16.sp)),
        SizedBox(width: 12.w),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 16.sp,
              height: 1.5.h,
            ),
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          ),
        ),
      ],
    );
  }
}

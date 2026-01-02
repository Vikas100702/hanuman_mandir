import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';

class SriHanumanMandirServicesView extends StatelessWidget {
  const SriHanumanMandirServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveHeight(20, 40),
        horizontal: context.responsiveWidth(16, 40),
      ),
      decoration: BoxDecoration(color: AppColors.appBackground),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          // Title
          Text(
            "Sri Hanuman Mandir Services",
            textAlign: .center,
            style: GoogleFonts.openSans(
              color: AppColors.primaryRed,
              fontWeight: .bold,
              fontSize: context.responsiveSize(28, 36),
            ),
          ),
          SizedBox(height: context.responsiveHeight(10, 15)),
          Center(
            child: Image.asset(
              "assets/images/border.png",
              width: context.isMobile ? context.screenWidth * 0.8 : 400,
            ),
          ),
          SizedBox(height: context.responsiveHeight(20, 30)),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/module/view/home/sri_hanuman_mandir_services/widgets/sri_hanuman_mandir_services_widgets.dart';

class SriHanumanMandirServicesView extends StatelessWidget {
  const SriHanumanMandirServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    double cardWidth = context.isMobile
        ? (context.screenWidth -30) /
              3 // Mobile: tight fit
        : 220; // Web/Tablet: fixed larger size

    double cardHeight = cardWidth ;

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
              fontSize: context.responsiveSize(22, 32),
            ),
          ),
          SizedBox(height: context.responsiveHeight(5, 10)),
          Center(
            child: Image.asset(
              "assets/images/border.png",
              width: context.isMobile ? context.screenWidth * 0.6 : 300,
              height: 10,
              fit: .contain,
            ),
          ),
          SizedBox(height: context.responsiveHeight(20, 30)),

          // Service Cards Row
          Row(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              SriHanumanMandirServicesWidgets.serviceCard(
                context,
                title: "Temple Services",
                imageUrl: "assets/images/img.png",
                width: cardWidth,
                height: cardHeight,
                fontSize: context.isMobile ? 11 : 16,
                onTap: () {
                  // Handle tap
                },
              ),
              SizedBox(width: context.responsiveWidth(10, 20)),
              SriHanumanMandirServicesWidgets.serviceCard(
                context,
                title: "Donations",
                imageUrl: "assets/images/img_1.png",
                width: cardWidth,
                height: cardHeight,
                fontSize: context.isMobile ? 11 : 16,
                onTap: () {
                  // Handle tap
                },
              ),
              SizedBox(width: context.responsiveWidth(10, 20)),
              SriHanumanMandirServicesWidgets.serviceCard(
                context,
                title: "Upcoming Events",
                imageUrl: "assets/images/img_2.png",
                width: cardWidth,
                height: cardHeight,
                fontSize: context.isMobile ? 11 : 16,
                onTap: () {
                  // Handle tap
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
    double cardWidth = context.isMobile ? context.screenWidth * 0.6 : 220;
    double cardHeight = cardWidth * 1.1;

    List<Widget> serviceCards = [
      SriHanumanMandirServicesWidgets.serviceCard(
        context,
        title: "Temple\nServices",
        imageUrl: "assets/images/img.png",
        width: cardWidth,
        height: cardHeight,
        fontSize: context.isMobile ? 14 : 16,
        onTap: () {},
      ),
      SriHanumanMandirServicesWidgets.serviceCard(
        context,
        title: "Donations",
        imageUrl: "assets/images/img_1.png",
        width: cardWidth,
        height: cardHeight,
        fontSize: context.isMobile ? 14 : 16,
        onTap: () {},
      ),
      SriHanumanMandirServicesWidgets.serviceCard(
        context,
        title: "Upcoming\nEvents",
        imageUrl: "assets/images/img_2.png",
        width: cardWidth,
        height: cardHeight,
        fontSize: context.isMobile ? 14 : 16,
        onTap: () {},
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveHeight(20, 40),
        horizontal: context.responsiveWidth(16, 40),
      ),
      decoration: BoxDecoration(color: AppColors.appBackground),
      width: .infinity,
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
              width: context.isMobile ? context.screenWidth * 0.6 : 600,
              height: 50,
              fit: .contain,
            ),
          ),
          SizedBox(height: context.responsiveHeight(20, 30)),

          if(context.isMobile)
            Column(
              children: [
                for(int i = 0; i < serviceCards.length; i++) ...[
                  serviceCards[i],

                  if(i != serviceCards.length - 1)
                    SizedBox(height: context.responsiveHeight(20, 0)),
                ]
              ],
            )
          else
            Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                for(int i = 0; i < serviceCards.length; i++) ...[
                  serviceCards[i],

                  if (i != serviceCards.length - 1)
                    SizedBox(width: context.responsiveWidth(0, 30)),
                ]
              ],
            )
        ],
      ),
    );
  }
}

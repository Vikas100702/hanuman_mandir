import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/special_events/special_events_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/temple_schedule/temple_schedule_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/upcoming_events/upcoming_events_view.dart';

class TodaysPanchangamView extends StatelessWidget {
  const TodaysPanchangamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveHeight(20, 40),
        horizontal: context.responsiveWidth(16, 40),
      ),
      decoration: const BoxDecoration(color: Color(0xFFF5F5DC)),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          // Title
          Text(
            "Today's Panchangam",
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

          // Views
          ResponsiveView(
            mobile: const Column(
              children: [
                SpecialEventsView(),
                SizedBox(height: 20),
                TempleScheduleView(),
                SizedBox(height: 20),
                UpcomingEventsView(),
              ],
            ),
            desktop: SizedBox(
              height: 600,
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  Expanded(child: SpecialEventsView()),
                  SizedBox(width: 20),
                  Expanded(child: TempleScheduleView()),
                  SizedBox(width: 20),
                  Expanded(child: UpcomingEventsView()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

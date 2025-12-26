import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/special_events/special_events_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/temple_schedule/temple_schedule_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/upcoming_events/upcoming_events_view.dart';

class TodaysPanchangamView extends StatelessWidget {
  const TodaysPanchangamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5DC)
      ),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          SizedBox(height: 10,),
          // Title
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Text(
              "Today's Panchangam",
              textAlign: .center,
              style: GoogleFonts.openSans(
                color: AppColors.primaryRed,
                fontWeight: .bold,
                fontSize: 31
              )
            ),
          ),
          Center(
            child: Image.asset("assets/images/border.png", width: 1000,),
          ),

          // Views
          ResponsiveView(mobile: const Column(
            children: [
              SpecialEventsView(),
              TempleScheduleView(),
              UpcomingEventsView(),
            ],
          ), desktop: const Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(child: SpecialEventsView()),
              Expanded(child: TempleScheduleView()),
              Expanded(child: UpcomingEventsView()),
            ],
          ))
        ],
      ),
    );
  }
}

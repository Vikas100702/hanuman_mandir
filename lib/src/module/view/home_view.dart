import 'package:flutter/material.dart';
import 'package:hanuman_mandir/src/module/view/about/about_view.dart';
import 'package:hanuman_mandir/src/module/view/banner/banner_view.dart';
import 'package:hanuman_mandir/src/module/view/footer/footer_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/special_events/special_events_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/temple_schedule/temple_schedule_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/todays_panchangam_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/upcoming_events/upcoming_events_view.dart';

import 'header/header_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Just call the Header Module here
            HeaderView(),
            BannerView(),
            TodaysPanchangamView(),
            AboutView(),
            FooterView(),

            // You can add other modules here in the future
            // Example: SliderView(),
            // Example: EventsView(),
          ],
        ),
      ),
    );
  }
}

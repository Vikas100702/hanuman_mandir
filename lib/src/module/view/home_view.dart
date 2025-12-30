import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/module/controller/home_controller.dart';
import 'package:hanuman_mandir/src/module/view/about/about_view.dart';
import 'package:hanuman_mandir/src/module/view/banner/banner_view.dart';
import 'package:hanuman_mandir/src/module/view/footer/footer_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/special_events/special_events_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/temple_schedule/temple_schedule_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/todays_panchangam_view.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/upcoming_events/upcoming_events_view.dart';

import 'header/header_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      // GLOBAL LOADER: Shows until ALL APIs are finished
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: const [
            HeaderView(),
            BannerView(),
            TodaysPanchangamView(),
            AboutView(),
            FooterView(),
          ],
        ),
      );
    }),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/module/controller/home_controller.dart';
import 'package:hanuman_mandir/src/module/view/home/about/about_view.dart';
import 'package:hanuman_mandir/src/module/view/home/banner/banner_view.dart';
import 'package:hanuman_mandir/src/module/view/home/community/community_view.dart';
import 'package:hanuman_mandir/src/module/view/home/footer/footer_view.dart';
import 'package:hanuman_mandir/src/module/view/home/header/header_view.dart';
import 'package:hanuman_mandir/src/module/view/home/sri_hanuman_mandir_services/sri_hanuman_mandir_services_view.dart';
import 'package:hanuman_mandir/src/module/view/home/todays_panchangam/special_events/special_events_view.dart';
import 'package:hanuman_mandir/src/module/view/home/todays_panchangam/temple_schedule/temple_schedule_view.dart';
import 'package:hanuman_mandir/src/module/view/home/todays_panchangam/todays_panchangam_view.dart';
import 'package:hanuman_mandir/src/module/view/home/todays_panchangam/upcoming_events/upcoming_events_view.dart';


class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      // GLOBAL LOADER: Shows until ALL APIs are finished
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
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
            SriHanumanMandirServicesView(),
            CommunityView(),
            FooterView(),
          ],
        ),
      );
    }),
    );
  }
}
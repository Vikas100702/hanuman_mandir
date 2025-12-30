import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/module/controller/about/about_controller.dart';
import 'package:hanuman_mandir/src/module/controller/background_music/background_music_controller.dart';
import 'package:hanuman_mandir/src/module/controller/banner/banner_controller.dart';
import 'package:hanuman_mandir/src/module/controller/footer/footer_controller.dart';
import 'package:hanuman_mandir/src/module/controller/header/header_controller.dart';
import 'package:hanuman_mandir/src/module/controller/todays_panchangam/special_events/special_events_controller.dart';
import 'package:hanuman_mandir/src/module/controller/todays_panchangam/temple_schedule/temple_schedule_controller.dart';
import 'package:hanuman_mandir/src/module/controller/todays_panchangam/upcoming_events/upcoming_events_controller.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    try {
      isLoading(true);

      // Finding all controllers which are already created by HomeBinding
      final headerC = Get.find<HeaderController>();
      final bannerC = Get.find<BannerController>();
      final specialEventsC = Get.find<SpecialEventsController>();
      final templeScheduleC = Get.find<TempleScheduleController>();
      final upcomingEventsC = Get.find<UpcomingEventsController>();
      final aboutC = Get.find<AboutController>();
      final footerC = Get.find<FooterController>();
      final backgroundMusicC = Get.find<BackgroundMusicController>();

      // Fetching All APIs in parallel
      await Future.wait([
        headerC.fetchHeaderData(),
        bannerC.fetchBannerData(),
        specialEventsC.fetchSpecialEventsData(),
        templeScheduleC.fetchTempleScheduleData(),
        upcomingEventsC.fetchUpcomingEventsData(),
        aboutC.fetchAboutData(),
        footerC.fetchFooterData(),
        backgroundMusicC.fetchBackgroundMusicData(),
      ]);

      // 2. Pre-caching Critical Images
      if (!kIsWeb && Get.context != null) {
        await _preCacheCriticalImages(headerC, bannerC);
      }
    } catch (e) {
      debugPrint("Error fetching home data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> _preCacheCriticalImages(
    HeaderController headerC,
    BannerController bannerC,
  ) async {
    final List<Future<void>> imageLoaders = [];
    final context = Get.context!;

    // -- Collecting Header Images --
    for (var item in headerC.headerDataList) {
      if (item.leftImage != null) {
        imageLoaders.add(
          precacheImage(
            NetworkImage("${Endpoints.globalUrl}${item.leftImage}"),
            context,
          ),
        );
      }
      if (item.rightImage != null) {
        imageLoaders.add(
          precacheImage(
            NetworkImage("${Endpoints.globalUrl}${item.rightImage}"),
            context,
          ),
        );
      }
    }

    // -- Collecting Banner Images --
    for (var item in bannerC.bannerDataList) {
      if (item.refDataName != null) {
        imageLoaders.add(
          precacheImage(
            NetworkImage("${Endpoints.globalUrl}${item.refDataName}"),
            context,
          ),
        );
      }
    }

    try {
      await Future.wait(imageLoaders);
    } catch (e) {
      debugPrint("Image Pre-caching failed (likely 404 or CORS): $e");    }
  }
}

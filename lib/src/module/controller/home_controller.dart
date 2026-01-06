import 'package:cached_network_image/cached_network_image.dart';
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

      // Start the Minimum Spiritual Delay (at least 2.5 seconds for animation)
      // This prevents the "flicker" if the API is too fast.
      final minDelayFuture = Future.delayed(const Duration(milliseconds: 2500));

      // 1. Fetch Critical Data (Header & Banner)
      final headerC = Get.find<HeaderController>();
      final bannerC = Get.find<BannerController>();

      await Future.wait([
        headerC.fetchHeaderData(),
        bannerC.fetchBannerData(),
      ]);

      // 2. Pre-cache Critical Images using the CORRECT Provider
      if (!kIsWeb && Get.context != null) {
        // We await this so the loader DOES NOT dismiss until images are ready
        await _preCacheCriticalImages(headerC, bannerC);
      }

      // 3. Wait for the minimum animation time to finish
      await minDelayFuture;

      // Unlock the UI only after data + images + animation are ready
      isLoading(false);

      // 4. Fetch Non-Critical Data in the background
      _fetchSecondaryData();

    } catch (e) {
      debugPrint("Error fetching critical home data: $e");
      // Even on error, ensure we wait for the animation before dismissing
      await Future.delayed(const Duration(seconds: 2));
      isLoading(false);
    }
  }

  void _fetchSecondaryData() {
    final specialEventsC = Get.find<SpecialEventsController>();
    final templeScheduleC = Get.find<TempleScheduleController>();
    final upcomingEventsC = Get.find<UpcomingEventsController>();
    final aboutC = Get.find<AboutController>();
    final footerC = Get.find<FooterController>();
    final backgroundMusicC = Get.find<BackgroundMusicController>();

    Future.wait([
      specialEventsC.fetchSpecialEventsData(),
      templeScheduleC.fetchTempleScheduleData(),
      upcomingEventsC.fetchUpcomingEventsData(),
      aboutC.fetchAboutData(),
      footerC.fetchFooterData(),
      backgroundMusicC.fetchBackgroundMusicData(),
    ]).catchError((e) {
      debugPrint("Error fetching secondary data: $e");
    });
  }

  Future<void> _preCacheCriticalImages(
      HeaderController headerC,
      BannerController bannerC,
      ) async {
    final List<Future<void>> imageLoaders = [];
    final context = Get.context;
    if (context == null) return;

    // Helper function to pick the right provider
    ImageProvider getImageProvider(String url) {
      // CRITICAL FIX: Use CachedNetworkImageProvider for mobile
      // This ensures the image cached here is the SAME one used by AppImage/CachedNetworkImage
      return CachedNetworkImageProvider(url);
    }

    // -- Collecting Header Images --
    for (var item in headerC.headerDataList) {
      if (item.leftImage != null) {
        final url = "${Endpoints.globalUrl}${item.leftImage}";
        imageLoaders.add(precacheImage(getImageProvider(url), context));
      }
      if (item.rightImage != null) {
        final url = "${Endpoints.globalUrl}${item.rightImage}";
        imageLoaders.add(precacheImage(getImageProvider(url), context));
      }
    }

    // -- Collecting Banner Images --
    for (var item in bannerC.bannerDataList) {
      if (item.refDataName != null) {
        final url = "${Endpoints.globalUrl}${item.refDataName}";
        imageLoaders.add(precacheImage(getImageProvider(url), context));
      }
    }

    try {
      // Wait for all images to download/cache
      // We add a timeout so one bad image doesn't freeze the app forever
      await Future.wait(imageLoaders).timeout(const Duration(seconds: 4));
    } catch (e) {
      debugPrint("Image Pre-caching warning: $e");
    }
  }
}
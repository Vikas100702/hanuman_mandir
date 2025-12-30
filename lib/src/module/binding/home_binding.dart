import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/about/about_service.dart';
import 'package:hanuman_mandir/src/data/services/background_music_service/background_music_service.dart';
import 'package:hanuman_mandir/src/data/services/banner/banner_service.dart';
import 'package:hanuman_mandir/src/data/services/footer/footer_service.dart';
import 'package:hanuman_mandir/src/data/services/header/header_service.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/special_events/special_events_service.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/temple_schedule/temple_schedule_service.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/upcoming_events/upcoming_events_service.dart';
import 'package:hanuman_mandir/src/module/controller/about/about_controller.dart';
import 'package:hanuman_mandir/src/module/controller/background_music/background_music_controller.dart';
import 'package:hanuman_mandir/src/module/controller/banner/banner_controller.dart';
import 'package:hanuman_mandir/src/module/controller/footer/footer_controller.dart';
import 'package:hanuman_mandir/src/module/controller/header/header_controller.dart';
import 'package:hanuman_mandir/src/module/controller/home_controller.dart';
import 'package:hanuman_mandir/src/module/controller/todays_panchangam/special_events/special_events_controller.dart';
import 'package:hanuman_mandir/src/module/controller/todays_panchangam/temple_schedule/temple_schedule_controller.dart';
import 'package:hanuman_mandir/src/module/controller/todays_panchangam/upcoming_events/upcoming_events_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Registering Services first (it is optional if controllers instantiate them directly,
    // but it is better for testing and memory management)

    Get.lazyPut(() => HeaderService());
    Get.lazyPut(() => BannerService());
    Get.lazyPut(() => SpecialEventsService());
    Get.lazyPut(() => TempleScheduleService());
    Get.lazyPut(() => UpcomingEventsService());
    Get.lazyPut(() => AboutService());
    Get.lazyPut(() => FooterService());
    Get.lazyPut(() => BackgroundMusicService());

    // 2. Registering Controllers
    Get.lazyPut(() => HeaderController(headerService: Get.find()));
    Get.lazyPut(() => BannerController(bannerService: Get.find()));
    Get.lazyPut(() => SpecialEventsController(specialEventsService: Get.find()));
    Get.lazyPut(() => TempleScheduleController(templeScheduleService: Get.find()));
    Get.lazyPut(() => UpcomingEventsController(upcomingEventsService: Get.find()));
    Get.lazyPut(() => AboutController(aboutService: Get.find()));
    Get.lazyPut(() => FooterController(footerService: Get.find()));
    Get.lazyPut(() => BackgroundMusicController(backgroundMusicService: Get.find()));

    // 3. Register Home Controller (The Orchestrator)
    Get.put(HomeController());
  }
}

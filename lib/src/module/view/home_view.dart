import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/core/widgets/scroll_animated_section.dart';
import 'package:hanuman_mandir/src/core/widgets/spiritual_loader.dart';
import 'package:hanuman_mandir/src/module/controller/home_controller.dart';
import 'package:hanuman_mandir/src/module/view/home/about/about_view.dart';
import 'package:hanuman_mandir/src/module/view/home/banner/banner_view.dart';
import 'package:hanuman_mandir/src/module/view/home/community/community_view.dart';
import 'package:hanuman_mandir/src/module/view/home/donation/donation_view.dart';
import 'package:hanuman_mandir/src/module/view/home/footer/footer_view.dart';
import 'package:hanuman_mandir/src/module/view/home/header/header_view.dart';
import 'package:hanuman_mandir/src/module/view/home/sri_hanuman_mandir_services/sri_hanuman_mandir_services_view.dart';
import 'package:hanuman_mandir/src/module/view/home/todays_panchangam/special_events/special_events_view.dart';
import 'package:hanuman_mandir/src/module/view/home/todays_panchangam/temple_schedule/temple_schedule_view.dart';
import 'package:hanuman_mandir/src/module/view/home/todays_panchangam/todays_panchangam_view.dart';
import 'package:hanuman_mandir/src/module/view/home/todays_panchangam/upcoming_events/upcoming_events_view.dart';

/*class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // GLOBAL LOADER: Shows until ALL APIs are finished
        if (controller.isLoading.value) {
          return const Center(child: SpiritualLoader(size: 100));
        }

        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: const [
              ScrollAnimatedSection(index: 0, child: HeaderView()),
              ScrollAnimatedSection(index: 1, child: BannerView()),
              // The following views load their data in the background as Secondary Data.
              // They will appear seamlessly as data arrives.
              ScrollAnimatedSection(index: 2, child: TodaysPanchangamView()),
              ScrollAnimatedSection(index: 3, child: AboutView()),
              ScrollAnimatedSection(
                index: 4,
                child: SriHanumanMandirServicesView(),
              ),
              ScrollAnimatedSection(index: 5, child: CommunityView()),
              ScrollAnimatedSection(index: 6, child: FooterView()),
            ],
          ),
        );
      }),
    );
  }
}*/

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // The Single ScrollController that manages the whole page scrolling
  final ScrollController _scrollController = ScrollController();
  final HomeController controller = Get.find<HomeController>();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-banner2.jpg"),
            fit: .cover,
          ),
        ),
        child: Obx(() {
          // 1. Spiritual Loader
          if (controller.isLoading.value) {
            return const Center(child: SpiritualLoader(size: 200));
          }

          // 2. Scroll Animated Content
          return SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                // Header appears immediately or on slight scroll
                ScrollAnimatedSection(
                  scrollController: _scrollController,
                  child: const HeaderView(),
                ),

                ScrollAnimatedSection(
                  scrollController: _scrollController,
                  child: const BannerView(),
                ),

                ScrollAnimatedSection(
                  scrollController: _scrollController,
                  child: const TodaysPanchangamView(),
                ),

                ScrollAnimatedSection(
                  scrollController: _scrollController,
                  child: const AboutView(),
                ),

                ScrollAnimatedSection(
                  scrollController: _scrollController,
                  child: const DonationView(),
                ),

                ScrollAnimatedSection(
                  scrollController: _scrollController,
                  child: const SriHanumanMandirServicesView(),
                ),

                ScrollAnimatedSection(
                  scrollController: _scrollController,
                  child: const CommunityView(),
                ),

                ScrollAnimatedSection(
                  scrollController: _scrollController,
                  // Small offset tweak for footer to ensure it triggers easily at bottom
                  offset: 20,
                  child: const FooterView(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

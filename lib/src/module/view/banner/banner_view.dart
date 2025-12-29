import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:hanuman_mandir/src/data/services/banner/banner_service.dart';
import 'package:hanuman_mandir/src/module/controller/banner/banner_controller.dart';
import 'package:hanuman_mandir/src/module/model/banner/banner_model.dart';
import 'package:hanuman_mandir/src/module/view/banner/widgets/banner_widgets.dart';
import 'package:image_network/image_network.dart';

class BannerView extends StatelessWidget {
  const BannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.put(
      BannerController(bannerService: BannerService()),
    );

    return Obx(() {
      if (bannerController.isLoading.value) {
        return const SizedBox(
          height: 250,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (bannerController.bannerDataModel.value == null ||
          bannerController.bannerDataList.isEmpty) {
        return const SizedBox.shrink();
      }

      // Get screen dimensions
      final screenHeight = MediaQuery.of(context).size.height;
      final isMobile = context.isMobile;

      // Calculate carousel height (same as in banner_widgets.dart)
      final carouselHeight = isMobile
          ? screenHeight *
                0.75 // 75% for mobile
          : screenHeight * 0.6; // 60% for desktop

      return CarouselSlider(
        options: CarouselOptions(
          height: carouselHeight,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        items: bannerController.bannerDataList.map((Datum data) {
          return BannerWidgets.buildBannerItem(context, data);
        }).toList(),
      );
    });
  }
}

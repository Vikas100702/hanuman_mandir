import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hanuman_mandir/src/data/services/banner/banner_service.dart';
import 'package:hanuman_mandir/src/module/controller/banner/banner_controller.dart';
import 'package:hanuman_mandir/src/module/model/banner/banner_model.dart';

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

      return LayoutBuilder(
        builder: (context, constraints) {
          // Define a breakpoint for mobile/tablet vs desktop
          bool isMobile = constraints.maxWidth < 900;
          return CarouselSlider(
            options: CarouselOptions(
              height: isMobile ? 200 : 400,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: bannerController.bannerDataList.map((Datum data) {
              String fileName = data.refDataName?.split('/').last ?? '';
              String assetPath = "assets/images/$fileName";

              return Builder(
                builder: (BuildContext context) {
                  return data.bannerType == "ONLY IMAGE"
                      ? Image.asset(
                          assetPath,
                          fit:
                              .cover /*, errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    );
                  },*/,
                        )
                      : !isMobile
                      ? Row(
                          children: [
                            Image.asset(
                              assetPath,
                              fit:
                                  .cover /*, errorBuilder: (context, error, stackTrace) {
                                            return const Center(
                                                      child: Icon(Icons.error, color: Colors.red),
                                            );
                                          },*/,
                            ),
                            Expanded(child: Container(color: Colors.red)),
                          ],
                        )
                      : Column(
                          children: [
                            Image.asset(
                              assetPath,
                              fit:
                                  .cover /*, errorBuilder: (context, error, stackTrace) {
                                            return const Center(
                                                      child: Icon(Icons.error, color: Colors.red),
                                            );
                                          },*/,
                            ),
                            Expanded(child: Container(color: Colors.red)),
                          ],
                        );
                },
              );
            }).toList(),
          );
        },
      );
    });
  }
}

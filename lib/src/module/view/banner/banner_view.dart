import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
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
          // Breakpoint for mobile/tablet vs desktop
          bool isMobile = constraints.maxWidth < 900;

          // Calculate mobile height (e.g., 75-80% of screen height for a full experience)
          double mobileHeight = MediaQuery.of(context).size.height * 0.75;

          return CarouselSlider(
            options: CarouselOptions(
              // Fix: On mobile, use a specific height so Expanded works correctly.
              // If height is null, it relies on aspect ratio which might be too short for text.
              height: isMobile ? mobileHeight : 450,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: bannerController.bannerDataList.map((Datum data) {
              String fileName = data.refDataName?.split('/').last ?? '';
              String assetPath = "assets/images/$fileName";

              String cleanDescription = (data.bannerDesc ?? "").removeHtmlTags();
              String cleanHeading = (data.bannerHeading ?? "").replaceBackslash();

              return Builder(
                builder: (BuildContext context) {
                  return data.bannerType == "ONLY IMAGE"
                      ? SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      assetPath,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                  )
                      : !isMobile
                  // ---------------- DESKTOP LAYOUT ----------------
                      ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.asset(
                            assetPath,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Icon(Icons.error, color: Colors.red));
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              opacity: 0.8,
                              image: AssetImage("assets/images/banner_bg.png"),
                            ),
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    cleanHeading,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'serif',
                                      color: Color(0xFF44233B),
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      height: 1.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Center(child: Image.asset("assets/images/border.png")),
                                const SizedBox(height: 15),
                                Text(
                                  "${data.bannerSubHeading ?? ""}\n",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontFamily: 'serif',
                                    color: Color(0xFF4D4643),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      cleanDescription,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontFamily: 'serif',
                                        color: Color(0xFF000000),
                                        fontSize: 18, // Reduced slightly for better fit
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  // ---------------- MOBILE LAYOUT ----------------
                      : Column(
                    children: [
                      // 1. IMAGE SECTION
                      // Use AspectRatio to keep deity image correct (not stretched)
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          width: double.infinity,
                          color: Colors.black12, // Placeholder bg
                          child: Image.asset(
                            assetPath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.error, color: Colors.red),
                              );
                            },
                          ),
                        ),
                      ),

                      // 2. TEXT SECTION
                      // Expanded makes this fill ALL remaining vertical space
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              opacity: 0.8,
                              image: AssetImage("assets/images/banner_bg.png"),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ListView(
                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                              shrinkWrap: true,
                              children: [
                                Center(
                                  child: Text(
                                    cleanHeading,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'serif',
                                      color: Color(0xFF44233B),
                                      fontSize: 28, // Slightly smaller for mobile
                                      fontWeight: FontWeight.bold,
                                      height: 1.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Center(child: Image.asset("assets/images/border.png")),
                                const SizedBox(height: 15),
                                if (data.bannerSubHeading != null && data.bannerSubHeading!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "${data.bannerSubHeading ?? ""}\n",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontFamily: 'serif',
                                        color: Color(0xFF4D4643),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                Text(
                                  cleanDescription,
                                  textAlign: TextAlign.justify, // Center align looks better on mobile vertical flow
                                  style: const TextStyle(
                                    fontFamily: 'serif',
                                    color: Color(0xFF000000),
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
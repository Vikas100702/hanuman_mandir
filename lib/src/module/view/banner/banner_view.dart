import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/data/services/banner/banner_service.dart';
import 'package:hanuman_mandir/src/module/controller/banner/banner_controller.dart';
import 'package:hanuman_mandir/src/module/model/banner/banner_model.dart';
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

      return LayoutBuilder(
        builder: (context, constraints) {
          // Breakpoint for mobile/tablet vs desktop
          bool isMobile = constraints.maxWidth < 900;

          // Calculate mobile height
          double mobileHeight = MediaQuery.of(context).size.height * 0.75;

          return CarouselSlider(
            options: CarouselOptions(
              height: isMobile ? mobileHeight : 450,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: bannerController.bannerDataList.map((Datum data) {
              String imageUrl = "${Endpoints.globalUrl}${data.refDataName}";

              String cleanDescription = (data.bannerDesc ?? "").removeHtmlTags();
              String cleanHeading = (data.bannerHeading ?? "").replaceBackslash();

              return Builder(
                builder: (BuildContext context) {
                  return data.bannerType == "ONLY IMAGE"
                      ? LayoutBuilder(
                    builder: (context, constraints) {
                      return ImageNetwork(
                        image: imageUrl,
                        // Use specific constraints instead of double.infinity
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        fitAndroidIos: BoxFit.fill,
                        fitWeb: BoxFitWeb.fill,
                        onLoading: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        onError: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      );
                    },
                  )
                      : !isMobile
                  // ---------------- DESKTOP LAYOUT ----------------
                      ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              child: ImageNetwork(
                                image: imageUrl,
                                // Use specific constraints
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                                fitAndroidIos: BoxFit.fill,
                                fitWeb: BoxFitWeb.fill,
                                onLoading: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                onError: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
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
                              image: AssetImage(
                                "assets/images/banner_bg.png",
                              ),
                            ),
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 40,
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
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
                                Center(
                                  child: Image.asset(
                                    "assets/images/border.png",
                                  ),
                                ),
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
                                        fontSize: 18,
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
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          width: double.infinity,
                          color: Colors.black12,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return ImageNetwork(
                                image: imageUrl,
                                // Use specific constraints
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                                fitAndroidIos: BoxFit.cover,
                                fitWeb: BoxFitWeb.cover,
                                onLoading: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                onError: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // 2. TEXT SECTION
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              opacity: 0.8,
                              image: AssetImage(
                                "assets/images/banner_bg.png",
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: ListView(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                              ),
                              shrinkWrap: true,
                              children: [
                                Center(
                                  child: Text(
                                    cleanHeading,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'serif',
                                      color: Color(0xFF44233B),
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      height: 1.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Center(
                                  child: Image.asset(
                                    "assets/images/border.png",
                                  ),
                                ),
                                const SizedBox(height: 15),
                                if (data.bannerSubHeading != null &&
                                    data.bannerSubHeading!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 8.0,
                                    ),
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
                                  textAlign: TextAlign.justify,
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
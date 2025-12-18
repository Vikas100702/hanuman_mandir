import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      if(bannerController.isLoading.value) {
        return const SizedBox(
          height: 250,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if(bannerController.bannerDataModel.value == null || bannerController.bannerDataList.isEmpty) {
        return const SizedBox.shrink();
      }

      final Datum data = bannerController.bannerDataList.first;

      return LayoutBuilder(builder: (context, constraints) {
        // Define a breakpoint for mobile/tablet vs desktop
        bool isMobile = constraints.maxWidth < 900;
        return Container(
          height: 50,
          width: .infinity,
          color: Colors.red,
          child: Center(
            child: Text(data.bannerHeading ?? "Banner Heading"),
          ),
        );
      });
    });
  }
}

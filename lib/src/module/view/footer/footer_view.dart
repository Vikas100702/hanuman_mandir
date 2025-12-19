import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/footer/footer_service.dart';
import 'package:hanuman_mandir/src/data/services/header/header_service.dart';
import 'package:hanuman_mandir/src/module/controller/footer/footer_controller.dart';
import 'package:hanuman_mandir/src/module/controller/header/header_controller.dart';
import 'package:hanuman_mandir/src/module/model/footer/footer_model.dart';
import 'package:hanuman_mandir/src/module/view/footer/widgets/footer_widgets.dart';

class FooterView extends StatelessWidget {
  const FooterView({super.key});

  @override
  Widget build(BuildContext context) {
    final FooterController footerController = Get.put(
      FooterController(footerService: FooterService()),
    );

    // Retrieve the existing HeaderController to access the logo
    final HeaderController headerController = Get.isRegistered<HeaderController>()
        ? Get.find<HeaderController>()
        : Get.put(HeaderController(headerService: HeaderService()));

    return Obx(() {
      if (footerController.isLoading.value) {
        return const SizedBox(
          height: 250,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      Datum? footerData;
      if (footerController.footerDataList.isNotEmpty) {
        footerData = footerController.footerDataList.first;
      }

      String? logoUrl;
      if(headerController.headerDataList.isNotEmpty) {
        logoUrl = headerController.headerDataList.first.leftImage;
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          // Breakpoint for Desktop
          bool isDesktop = constraints.maxWidth > 1000;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            width: double.infinity,
            color: const Color(0xFFB02135),
            child: isDesktop
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: FooterWidgets.buildFooterContent(
                isDesktop: true,
                data: footerData,
                logoUrl: logoUrl,
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Spread operator for mobile list
                ...FooterWidgets.buildFooterContent(
                  isDesktop: false,
                  data: footerData,
                  logoUrl: logoUrl,
                ).map((widget) => Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: widget,
                )),
              ],
            ),
          );
        },
      );
    });
  }
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
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
    final HeaderController headerController =
        Get.isRegistered<HeaderController>()
        ? Get.find<HeaderController>()
        : Get.put(HeaderController(headerService: HeaderService()));

    return Obx(() {
      if (footerController.isLoading.value) {
        return SizedBox(
          height: context.responsiveHeight(200, 250),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      Datum? footerData;
      if (footerController.footerDataList.isNotEmpty) {
        footerData = footerController.footerDataList.first;
      }

      String? logoUrl;
      if (headerController.headerDataList.isNotEmpty) {
        logoUrl = headerController.headerDataList.first.leftImage;
      }

      return Container(
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveHeight(40, 50),
          horizontal: context.responsiveWidth(20, 40),
        ),        width: double.infinity,
        color: AppColors.darkRed,
        child: ResponsiveView(
          mobile: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Spread operator for mobile list
              ...FooterWidgets.buildFooterContent(
                context: context,
                isDesktop: false,
                data: footerData,
                logoUrl: logoUrl,
              ).map(
                (widget) => Padding(
                  padding: EdgeInsets.only(
                    bottom: context.responsiveHeight(35, 40),
                  ),                  child: widget,
                ),
              ),
            ],
          ),
          desktop: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: FooterWidgets.buildFooterContent(
                  context: context,
                  isDesktop: true,
                  data: footerData,
                  logoUrl: logoUrl,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:hanuman_mandir/src/data/services/about/about_service.dart';
import 'package:hanuman_mandir/src/module/controller/about/about_controller.dart';
import 'package:hanuman_mandir/src/module/model/about/about_model.dart';
import 'package:hanuman_mandir/src/module/view/home/about/widgets/about_widget.dart';
import 'package:image_network/image_network.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final AboutController aboutController = Get.find<AboutController>();
    return Obx(() {
      if (aboutController.isLoading.value) {
        return SizedBox(
          height: context.responsiveHeight(200, 250),
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      final List<AboutDatum> dataList = aboutController.aboutDataList;
      if (dataList.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        color: const Color(0xFFFFF8E1),
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveHeight(30, 50),
          horizontal: context.responsiveWidth(40, 60),
        ),
        child: Column(
          children: List.generate(dataList.length, (index) {
            final data = dataList[index];

            // LOGIC: Founder is the second item (index 1).
            // Mandir (index 0): Image Right, 3 Buttons.
            // Founder (index 1): Image Left, 1 Button.
            final bool isFounder = index == 1;

            return Padding(
              padding: .only(bottom: context.responsiveHeight(40, 60)),
              child: AboutWidget(
                data: data,
                isImageOnLeft: isFounder,
                buttons: isFounder
                    ? ["KNOW MORE"]
                    : ["KNOW MORE", "About DEITIES", "GENERAL INFO"],
              ),
            );
          }),
        ),
      );
    });
  }
}

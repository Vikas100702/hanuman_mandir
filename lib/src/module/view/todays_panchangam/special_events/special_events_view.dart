import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/special_events/special_events_service.dart';
import 'package:hanuman_mandir/src/module/controller/todays_panchangam/special_events/special_events_controller.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/widgets/todays_panchangam_widgets.dart';

class SpecialEventsView extends StatelessWidget {
  const SpecialEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SpecialEventsController specialEventsController = Get.put(
      SpecialEventsController(specialEventsService: SpecialEventsService()),
    );
    return Obx(() {
      if (specialEventsController.isLoading.value) {
        return SizedBox(
          height: context.responsiveHeight(200, 250),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (specialEventsController.specialEventsDataModel.value == null ||
          specialEventsController.specialEventsDataList.isEmpty) {
        return const SizedBox.shrink();
      }

      return TodaysPanchangamWidgets.panchangamCards(
        context: context,
        title: "Special Events",
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: specialEventsController.specialEventsDataList.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.responsiveHeight(12, 15),
            ),
            child: Divider(
              color: Colors.grey.withValues(alpha: 0.3),
              thickness: 1,
              height: 1,
            ),
          ),
          itemBuilder: (context, index) {
            final event = specialEventsController.specialEventsDataList[index];

            return Column(
              crossAxisAlignment: .center,
              children: [
                Text(
                  event.refDataName ?? 'Event Name',
                  textAlign: .center,
                  style: GoogleFonts.charm(
                    fontSize: context.responsiveSize(20, 22),
                    fontWeight: .w600,
                    fontStyle: .italic,
                    color: const Color(0xFF8B2323),
                  ),
                ),
                SizedBox(height: context.responsiveHeight(4, 6)),
                Text(
                  "${event.startDate} - ${event.endDate}",
                  style: GoogleFonts.openSans(
                    fontSize: context.responsiveSize(13, 14),
                    color: AppColors.primaryRed,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: context.responsiveHeight(4, 6)),
                InkWell(
                  onTap: () {},
                  child: Text(
                    event.refDataName ?? 'View Details',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: context.responsiveSize(13, 14),
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}

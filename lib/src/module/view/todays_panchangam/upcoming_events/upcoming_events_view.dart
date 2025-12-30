import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/upcoming_events/upcoming_events_service.dart';
import 'package:hanuman_mandir/src/module/controller/todays_panchangam/upcoming_events/upcoming_events_controller.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/widgets/todays_panchangam_widgets.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';

class UpcomingEventsView extends StatelessWidget {
  const UpcomingEventsView({super.key});

  // Date formatting helper
  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    try {
      final DateTime date = DateFormat("MM/dd/yyyy").parse(dateStr);

      // Convert to MMM dd yyyy (e.g., Dec 03 2025)
      return DateFormat("MMM dd yyyy").format(date);
    } catch (e) {
      // If parsing fails, return original string
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final UpcomingEventsController upcomingEventsController = Get.find<UpcomingEventsController>();

    return Obx(() {
      if (upcomingEventsController.isLoading.value) {
        return SizedBox(
          height: context.responsiveHeight(200, 250),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (upcomingEventsController.upcomingEventsDataModel.value == null ||
          upcomingEventsController.upcomingEventsDataList.isEmpty) {
        return const SizedBox.shrink();
      }

      return TodaysPanchangamWidgets.panchangamCards(
        context: context,
        title: "Upcoming Events",
        child: ListView.separated(
          physics: const ClampingScrollPhysics(),
          itemCount: upcomingEventsController.upcomingEventsDataList.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.responsiveHeight(8, 10),
            ),
            child: Divider(
              color: Colors.grey.withOpacity(0.3),
              thickness: 1,
              height: 1,
            ),
          ),
          itemBuilder: (context, index) {
            final event = upcomingEventsController.upcomingEventsDataList[index];

            return Container(
              padding: EdgeInsets.symmetric(
                vertical: context.responsiveHeight(4, 6),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image with fixed constraints
                  if (event.image != null && event.image!.isNotEmpty)
                    Container(
                      width: context.responsiveSize(70, 80),
                      height: context.responsiveSize(70, 80),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ImageNetwork(
                          image: "${Endpoints.globalUrl}${event.image}",
                          width: context.responsiveSize(70, 80),
                          height: context.responsiveSize(70, 80),
                          fitAndroidIos: BoxFit.cover,
                          fitWeb: BoxFitWeb.cover,
                          onLoading: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          onError: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                    ),

                  SizedBox(width: context.responsiveWidth(10, 12)),

                  // Text content with Expanded to prevent overflow
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Event Title
                        Text(
                          (event.refDataName?.trim() ?? 'Event Name'),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            fontSize: context.responsiveSize(13, 14),
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: context.responsiveHeight(4, 6)),

                        // Date Range
                        Text(
                          "${_formatDate(event.startDate?.trim())} - ${_formatDate(event.endDate?.trim())}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            fontSize: context.responsiveSize(11, 12),
                            color: AppColors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}

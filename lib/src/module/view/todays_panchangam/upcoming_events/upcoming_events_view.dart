import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
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
    final UpcomingEventsController upcomingEventsController = Get.put(
      UpcomingEventsController(upcomingEventsService: UpcomingEventsService()),
    );

    return Obx(() {
      if (upcomingEventsController.isLoading.value) {
        return const SizedBox(
          height: 250,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (upcomingEventsController.upcomingEventsDataModel.value == null ||
          upcomingEventsController.upcomingEventsDataList.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        width: double.infinity,
        color: const Color(0xFFF5F5DC),
        child: ResponsiveView(
          mobile: _buildContent(upcomingEventsController, isMobile: true),
          desktop: _buildContent(upcomingEventsController, isMobile: false),
        ),
      );
    });
  }

  Widget _buildContent(
    UpcomingEventsController controller, {
    required bool isMobile,
  }) {
    // Determine height based on device
    final double cardHeight = isMobile ? 500 : 450;

    return Padding(
      padding: const EdgeInsets.all(16.0), // Outer padding
      child: TodaysPanchangamWidgets.panchangamCards(
        title: "Upcoming Events",
        height: cardHeight,
        child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: controller.upcomingEventsDataList.length,
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(
              color: Colors.grey.withValues(alpha: 0.3),
              thickness: 1,
              height: 1,
            ),
          ),
          itemBuilder: (context, index) {
            final event = controller.upcomingEventsDataList[index];

            // Assuming event object has name, date, etc.
            // Adjust fields based on your actual model structure.
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Event Name (Styled like 'Navagraha and Nagadevi Prathista')
                Row(
                  children: [
                    if (event.image != null && event.image!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: ImageNetwork(
                            image: "${Endpoints.globalUrl}${event.image}",
                            height: 80,
                            width: 80,
                            fitAndroidIos: BoxFit.contain,
                            fitWeb: BoxFitWeb.contain,
                          ),
                        ),
                      ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          ((event.refDataName)?.trim() ?? 'Event Name'),
                          // "Event Name",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Date Range (e.g., Mar 08 - Dec 31)
                        Text(
                          "${_formatDate((event.startDate)?.trim())} - ${_formatDate((event.endDate)?.trim())}",
                          textAlign: .justify,
                          // "Date Range",
                          style: GoogleFonts.openSans(
                            fontSize: 11,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // const SizedBox(height: 4),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

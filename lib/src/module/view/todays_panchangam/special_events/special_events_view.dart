import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
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
          height: 250.h,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (specialEventsController.specialEventsDataModel.value == null ||
          specialEventsController.specialEventsDataList.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
        width: double.infinity,
        color: const Color(0xFFF5F5DC),
        child: ResponsiveView(
          mobile: _buildContent(specialEventsController, isMobile: true),
          desktop: _buildContent(specialEventsController, isMobile: false),
        ),
      );
    });
  }

  Widget _buildContent(
    SpecialEventsController controller, {
    required bool isMobile,
  }) {
    // Determine height based on device
    final double cardHeight = isMobile ? 500.h : 450;

    return Padding(
      padding: EdgeInsets.all(16.w), // Outer padding
      child: TodaysPanchangamWidgets.panchangamCards(
        title: "Special Events",
        height: cardHeight,
        child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: controller.specialEventsDataList.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(
              color: Colors.grey.withValues(alpha: 0.3),
              thickness: 1,
              height: 1,
            ),
          ),
          itemBuilder: (context, index) {
            final event = controller.specialEventsDataList[index];

            // Assuming event object has name, date, etc.
            // Adjust fields based on your actual model structure.
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Event Name (Styled like 'Navagraha and Nagadevi Prathista')
                Text(
                  event.refDataName ?? 'Event Name',
                  // "Event Name",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.charm(
                    fontSize: isMobile? 22.sp : 22,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF8B2323),
                  ),
                ),
                SizedBox(height: 4.h),

                // Date Range (e.g., Mar 08 - Dec 31)
                Text(
                  "${event.startDate} - ${event.endDate}",
                  // "Date Range",
                  style: GoogleFonts.openSans(
                    fontSize: isMobile ? 14.sp : 14,
                    color: AppColors.primaryRed,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),

                // Link
                InkWell(
                  onTap: () {
                    // Handle navigation
                  },
                  child: Text(
                    event.refDataName ?? 'View Details',
                    // "Event Details",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: isMobile ? 14.sp : 14,
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
      ),
    );
  }
}

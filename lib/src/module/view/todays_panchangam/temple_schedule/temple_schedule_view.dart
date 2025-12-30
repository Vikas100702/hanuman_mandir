import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:hanuman_mandir/src/module/model/todays_panchangam/temple_schedule/temple_schedule_model.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/temple_schedule/temple_schedule_service.dart';
import 'package:hanuman_mandir/src/module/controller/todays_panchangam/temple_schedule/temple_schedule_controller.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/widgets/todays_panchangam_widgets.dart';

class TempleScheduleView extends StatelessWidget {
  const TempleScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final TempleScheduleController templeScheduleController = Get.find<TempleScheduleController>();
    return Obx(() {
      if (templeScheduleController.isLoading.value) {
        return SizedBox(
          height: context.responsiveHeight(200, 250),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (templeScheduleController.templeScheduleDataModel.value == null) {
        return const SizedBox.shrink();
      }

      return TodaysPanchangamWidgets.panchangamCards(
        context: context,
        title: "Temple Schedules",
        child: Column(
          children: [
            _buildTabSection(context, templeScheduleController),
            SizedBox(height: context.responsiveHeight(10, 15)),

            Expanded(
              child: Obx(() {
                final List<Datum> currentList = templeScheduleController.currentDisplayList;

                if (currentList.isEmpty) {
                  return Center(
                    child: Text(
                      "No schedules found for ${templeScheduleController.selectedCategory.value}",
                      style: GoogleFonts.openSans(color: Colors.grey),
                    ),
                  );
                }

                return ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  itemCount: currentList.length,
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: context.responsiveHeight(12, 15),
                    ),
                    child: Divider(
                      color: Colors.grey.withOpacity(0.3),
                      thickness: 1,
                      height: 1,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    final schedule = currentList[index];
                    return _buildScheduleItem(context, schedule);
                  },
                );
              }),
            ),
          ],
        ),
      );
    });
  }

  /*Widget _buildContent(
    BuildContext context,
    TempleScheduleController controller, {
    required bool isMobile,
  }) {
    // Determine height based on device
    final double cardHeight = isMobile ? 500.h : 450.h;

    return Padding(
      padding: EdgeInsets.all(16.r), // Outer padding
      child: TodaysPanchangamWidgets.panchangamCards(
        context: context,
        title: "Temple Schedules",
        height: cardHeight,
        child: Column(
          children: [
            _buildTabSection(controller),

            SizedBox(height: 10.h),

            Expanded(
              child: Obx(() {
                final List<Datum> currentList = controller.currentDisplayList;

                if (currentList.isEmpty) {
                  return Center(
                    child: Text(
                      "No schedules found for ${controller.selectedCategory.value}",
                      style: GoogleFonts.openSans(color: Colors.grey),
                    ),
                  );
                }
                return ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: currentList.length,
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0.h),
                    child: Divider(
                      color: Colors.grey.withValues(alpha: 0.3),
                      thickness: 1,
                      height: 1.h,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    final schedule = currentList[index];

                    return _buildScheduleItem(schedule);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }*/

  Widget _buildTabSection(BuildContext context, TempleScheduleController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveHeight(10, 12),
      ),      child: Row(
        mainAxisAlignment: .center,
        children: [
          _buildTabButton(context, "DAILY", controller),
          SizedBox(width: context.responsiveWidth(10, 12)),
          _buildTabButton(context, "WEEKLY", controller),
          SizedBox(width: context.responsiveWidth(10, 12)),
          _buildTabButton(context, "MONTHLY", controller),
        ],
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String label, TempleScheduleController controller) {
    return Obx(() {
      bool isSelected = controller.selectedCategory.value == label;

      return InkWell(
        onTap: () => controller.updateCategory(label),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveWidth(16, 20),
            vertical: context.responsiveHeight(8, 10),
          ),          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF004D40) : Colors.grey[300],
            // Dark Green vs Grey
            borderRadius: BorderRadius.circular(4),
            border: isSelected
                ? Border.all(
                    color: Colors.amber,
                    width: 2,
                  ) // Gold border for active
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.openSans(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: context.responsiveSize(13, 14),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildScheduleItem(BuildContext context, Datum schedule) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // Align left like screenshot
      children: [
        Text(
          schedule.refDataName?.trim() ?? 'Event Name',
          style: GoogleFonts.openSans(
            fontSize: context.responsiveSize(16, 18),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF8B2323),
          ),
        ),
        SizedBox(height: context.responsiveHeight(4, 6)),
        Text(
          schedule.timing ?? "Timing",
          style: GoogleFonts.openSans(
            fontSize: context.responsiveSize(13, 14),
            color: AppColors.primaryRed,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

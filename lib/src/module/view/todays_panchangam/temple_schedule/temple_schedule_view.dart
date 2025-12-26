import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:hanuman_mandir/src/module/model/todays_panchangam/temple_schedule/temple_schedule_model.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/temple_schedule/temple_schedule_service.dart';
import 'package:hanuman_mandir/src/module/controller/todays_panchangam/temple_schedule/temple_schedule_controller.dart';
import 'package:hanuman_mandir/src/module/view/todays_panchangam/widgets/todays_panchangam_widgets.dart';

class TempleScheduleView extends StatelessWidget {
  const TempleScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final TempleScheduleController templeScheduleController =
        Get.put(TempleScheduleController(
          templeScheduleService: TempleScheduleService(),
        ));
    return Obx(() {
      if (templeScheduleController.isLoading.value) {
        return SizedBox(
          height: 250.h,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (templeScheduleController.templeScheduleDataModel.value == null) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
        width: double.infinity,
        color: const Color(0xFFF5F5DC),
        child: ResponsiveView(
          mobile: _buildContent(templeScheduleController, isMobile: true),
          desktop: _buildContent(templeScheduleController, isMobile: false),
        ),
      );
    });
  }

  Widget _buildContent(
    TempleScheduleController controller, {
    required bool isMobile,
  }) {
    // Determine height based on device
    final double cardHeight = isMobile ? 500.h : 450.h;

    return Padding(
      padding: EdgeInsets.all(16.r), // Outer padding
      child: TodaysPanchangamWidgets.panchangamCards(
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
  }

  Widget _buildTabSection(TempleScheduleController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: .center,
        children: [
          _buildTabButton("DAILY", controller),
          SizedBox(width: 10.w),
          _buildTabButton("WEEKLY", controller),
          SizedBox(width: 10.w),
          _buildTabButton("MONTHLY", controller),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, TempleScheduleController controller) {
    return Obx(() {
      bool isSelected = controller.selectedCategory.value == label;

      return InkWell(
        onTap: () => controller.updateCategory(label),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF004D40) : Colors.grey[300],
            // Dark Green vs Grey
            borderRadius: BorderRadius.circular(4.r),
            border: isSelected
                ? Border.all(
                    color: Colors.amber,
                    width: 2.w,
                  ) // Gold border for active
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.openSans(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildScheduleItem(Datum schedule) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // Align left like screenshot
      children: [
        Text(
          schedule.refDataName?.trim() ?? 'Event Name',
          style: GoogleFonts.openSans(
            fontSize: 18, // Adjusted to look like screenshot
            fontWeight: FontWeight.bold,
            color: const Color(0xFF8B2323),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          schedule.timing ?? "Timing",
          style: GoogleFonts.openSans(
            fontSize: 14,
            color: AppColors.primaryRed,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

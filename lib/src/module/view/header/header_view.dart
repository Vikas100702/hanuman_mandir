import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/const/app_menu_config.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:hanuman_mandir/src/data/services/header/header_service.dart';
import 'package:hanuman_mandir/src/module/controller/header/header_controller.dart';
import 'package:hanuman_mandir/src/module/model/header/header_model.dart';
import 'package:image_network/image_network.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    final HeaderController headerController = Get.put(
      HeaderController(headerService: HeaderService()),
    );

    return Obx(() {
      if (headerController.isLoading.value) {
        return SizedBox(
          height: 250.h,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (headerController.headerDataModel.value == null ||
          headerController.headerDataList.isEmpty) {
        return const SizedBox.shrink();
      }

      final Datum data = headerController.headerDataList.first;

      return Container(
        color: AppColors.primaryRed,
        child: Column(
          children: [
            // PART 1: MAIN HEADER (Logos + Text)
            Container(
              height: context.isMobile ? 20.h : 35,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.borderColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.gold, // Gold line
                    width: 1.5.h,
                  ),
                ),
              ),
            ),

            // --- Main Content Area ---
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.isMobile ? 15.h : 20,
              ),
              child: Center(
                child: ResponsiveView(
                  mobile: _buildMobileHeaderLayout(data),
                  desktop: _buildDesktopHeaderLayout(data),
                ),
              ),
            ),

            // PART 2: MENU BAR
            Container(
              color: AppColors.deepPurple,
              width: double.infinity,
              // Switch between Mobile (Hamburger) and Desktop (Row)
              child: ResponsiveView(
                mobile: _buildMobileMenuBar(),
                desktop: _buildDesktopMenuBar(),
              ),
            ),
          ],
        ),
      );
    });
  }

  // DESKTOP HEADER LAYOUT
  Widget _buildDesktopHeaderLayout(Datum data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLogo("${Endpoints.globalUrl}${data.leftImage}", size: 130.r),
        // _buildLogo("assets/images/left_header_logo.png", size: 130),
        Expanded(child: _buildTextContent(data, isMobile: false)),
        _buildLogo("${Endpoints.globalUrl}${data.rightImage}", size: 130.r),
        // _buildLogo("assets/images/right_header_logo.png", size: 130),
      ],
    );
  }

  // MOBILE HEADER LAYOUT
  Widget _buildMobileHeaderLayout(Datum data) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo("${Endpoints.globalUrl}${data.leftImage}", size: 70.r),
            // _buildLogo("assets/images/left_header_logo.png", size: 70),
            SizedBox(width: 20.w),
            _buildLogo("${Endpoints.globalUrl}${data.rightImage}", size: 70.r),
            // _buildLogo("assets/images/right_header_logo.png", size: 70),
          ],
        ),
        SizedBox(height: 15.h),
        _buildTextContent(data, isMobile: true),
      ],
    );
  }

  // HEADER TEXT CONTENT WIDGET
  Widget _buildTextContent(Datum data, {required bool isMobile}) {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            Text(
              data.refDataName ?? "The Hanuman Mandir",
              textAlign: TextAlign.center,
              style: context.headerTitleStyle,
            ),
            SizedBox(height: 6.h),
            if (data.subHeading != null)
              Text(
                data.subHeading!,
                textAlign: TextAlign.center,
                style: context.subHeaderStyle,
              ),
            SizedBox(height: 6.h),
            if (data.address != null)
              Text(
                data.address!,
                textAlign: TextAlign.center,
                style: context.bodyTextStyle,
              ),
            SizedBox(height: 10.h),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 15.w,
              runSpacing: 5.h,
              children: [
                if (data.phone != null)
                  _buildContactItem(Icons.phone, "+1 ${data.phone}", context),
                if (data.phoneNo != null)
                  _buildContactItem(
                    Icons.smartphone,
                    "+1 ${data.phoneNo}",
                    context,
                  ),
                if (data.email != null)
                  _buildContactItem(Icons.email, data.email!, context),
              ],
            ),
            SizedBox(height: 10.h),
            if (data.templeTiming != null)
              Text(
                data.templeTiming!,
                textAlign: TextAlign.center,
                style: context.bodyTextStyle,
              ),
          ],
        );
      },
    );
  }

  // MENU BAR IMPLEMENTATIONS
  /// 1. Desktop Menu Bar (Horizontal Row)
  Widget _buildDesktopMenuBar() {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...AppMenuConfig.mainMenuItems.map(
              (item) => _buildDesktopMenuItem(item),
            ),
            _buildCartIcon(isMobile: false),
          ],
        ),
      ),
    );
  }

  /// 2. Mobile Menu Bar (Hamburger Icon)
  Widget _buildMobileMenuBar() {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.menu, color: AppColors.white, size: 28.sp),
            onPressed: () => _openMobileMenu(),
          ),
          Text(
            "MENU",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 16.sp,
            ),
          ),

          // Cart Icon
          _buildCartIcon(isMobile: true),
        ],
      ),
    );
  }

  /// Opens the Mobile Menu BottomSheet
  void _openMobileMenu() {
    Get.bottomSheet(
      Container(
        color: AppColors.deepPurple, // Match Menu Color
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppMenuConfig.mainMenuItems.map((item) {
            return ListTile(
              title: Text(
                item.title,
                textAlign: .center,
                style: GoogleFonts.openSans(
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),
              ),
              onTap: () => Get.back(),
            );
          }).toList(),
          /*children: [
            // Close Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            _buildMobileListTile("HOME", isActive: true),
            const Divider(color: Colors.white24),
            _buildMobileListTile("SERVICES"),
            const Divider(color: Colors.white24),
            _buildMobileListTile("CALENDAR"),
            const Divider(color: Colors.white24),

            // Dropdowns rendered as ExpansionTiles for mobile
            _buildMobileExpansionTile("DONATIONS"),
            const Divider(color: Colors.white24),

            _buildMobileListTile("EVENTS"),
            const Divider(color: Colors.white24),

            _buildMobileExpansionTile("ABOUT TEMPLE"),
            const Divider(color: Colors.white24),

            _buildMobileListTile("SIGN-IN"),
          ],*/
        ),
      ),
      isScrollControlled: true, // Allows sheet to go taller if needed
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
    );
  }

  // --- Desktop Menu Item ---
  Widget _buildDesktopMenuItem(MenuItemModel item) {
    return Container(
      color: item.isActive ? AppColors.white : Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.title,
            style: GoogleFonts.openSans(
              color: item.isActive ? const Color(0xFFC00000) : AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0.sp,
            ),
          ),
          if (item.hasDropdown) ...[
            SizedBox(width: 2.w),
            Icon(
              Icons.arrow_drop_down,
              color: item.isActive ? const Color(0xFFC00000) : AppColors.white,
              size: 15.0.sp,
            ),
          ],
        ],
      ),
    );
  }

  // ---Mobile List Tile ---
  Widget _buildMobileListTile(String title, {bool isActive = false}) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isActive ? Colors.yellow : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      onTap: () {
        Get.back(); // Close bottom sheet
      },
    );
  }

  // --- Mobile Expansion Tile ---
  Widget _buildMobileExpansionTile(String title) {
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      // Hide internal borders
      child: ExpansionTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        children: [
          // Placeholder sub-items
          ListTile(
            title: const Text(
              "Option 1",
              style: TextStyle(color: Colors.white70),
            ),
            onTap: () => Get.back(),
            contentPadding: const EdgeInsets.only(left: 40),
          ),
          ListTile(
            title: const Text(
              "Option 2",
              style: TextStyle(color: Colors.white70),
            ),
            onTap: () => Get.back(),
            contentPadding: const EdgeInsets.only(left: 40),
          ),
        ],
      ),
    );
  }

  // --- Helper: Cart Icon ---
  Widget _buildCartIcon({required bool isMobile}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Icon(
        Icons.shopping_cart,
        color: AppColors.white,
        size: isMobile ? 20.sp : 24,
      ),
    );
  }

  // --- Logo Builder ---
  Widget _buildLogo(String? url, {String? fallback, required double size}) {
    // Logic to show ImageNetwork if url is valid, or Asset if not
    if (url == null || url.isEmpty || !url.startsWith('http')) {
      if (fallback != null) {
        return Image.asset(fallback, height: size, width: size);
      }
      return SizedBox(width: size, height: size);
    }

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.gold, width: 2.w),
      ),
      child: ImageNetwork(
        image: url,
        height: size,
        width: size.w,
        borderRadius: BorderRadius.circular(size),
        fitAndroidIos: BoxFit.contain,
        fitWeb: BoxFitWeb.contain,
      ),
    );
  }

  // --- Contact Item Builder ---
  Widget _buildContactItem(IconData icon, String text, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.white, size: context.isMobile ? 16.sp : 20),
        SizedBox(width: 6.w),
        Text(
          text,
          style: context.bodyTextStyle,
        ),
      ],
    );
  }
}

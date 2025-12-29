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
          height: context.responsiveHeight(200, 250),
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
              height: context.responsiveHeight(20, 35),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.borderColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.gold, // Gold line
                    width: 1.5,
                  ),
                ),
              ),
            ),

            // --- Main Content Area ---
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.responsiveHeight(15, 25),
                horizontal: context.responsiveWidth(16, 40),
              ),
              child: Center(
                child: ResponsiveView(
                  mobile: _buildMobileHeaderLayout(context, data),
                  desktop: _buildDesktopHeaderLayout(context, data),
                ),
              ),
            ),

            // PART 2: MENU BAR
            Container(
              color: AppColors.deepPurple,
              width: double.infinity,
              // Switch between Mobile (Hamburger) and Desktop (Row)
              child: ResponsiveView(
                mobile: _buildMobileMenuBar(context),
                desktop: _buildDesktopMenuBar(context),
              ),
            ),
          ],
        ),
      );
    });
  }

  // DESKTOP HEADER LAYOUT
  Widget _buildDesktopHeaderLayout(BuildContext context, Datum data) {
    return Row(
      crossAxisAlignment: .center,
      mainAxisAlignment: .center,
      children: [
        _buildLogo(
          context,
          "${Endpoints.globalUrl}${data.leftImage}",
          size: 120,
        ),
        SizedBox(width: 30),
        Flexible(child: _buildTextContent(context, data, isMobile: false)),
        SizedBox(width: 30),
        _buildLogo(
          context,
          "${Endpoints.globalUrl}${data.rightImage}",
          size: 120,
        ),
      ],
    );
  }

  // MOBILE HEADER LAYOUT
  Widget _buildMobileHeaderLayout(BuildContext context, Datum data) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(
              context,
              "${Endpoints.globalUrl}${data.leftImage}",
              size: 70,
            ),
            SizedBox(width: context.responsiveWidth(20, 30)),
            _buildLogo(
              context,
              "${Endpoints.globalUrl}${data.rightImage}",
              size: 70,
            ),
          ],
        ),
        SizedBox(height: context.responsiveHeight(15, 20)),
        _buildTextContent(context, data, isMobile: true),
      ],
    );
  }

  // HEADER TEXT CONTENT WIDGET
  Widget _buildTextContent(
    BuildContext context,
    Datum data, {
    required bool isMobile,
  }) {
    return Column(
      mainAxisSize: .min,
      children: [
        Text(
          data.refDataName ?? "The Hanuman Mandir",
          textAlign: TextAlign.center,
          style: context.headerTitleStyle,
        ),
        SizedBox(height: context.responsiveHeight(6, 10)),
        if (data.subHeading != null)
          Text(
            data.subHeading!,
            textAlign: TextAlign.center,
            style: context.subHeaderStyle,
          ),
        SizedBox(height: context.responsiveHeight(6, 10)),
        if (data.address != null)
          Text(
            data.address!,
            textAlign: TextAlign.center,
            style: context.bodyTextStyle,
          ),
        SizedBox(height: context.responsiveHeight(6, 10)),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: context.responsiveWidth(15, 20),
          runSpacing: context.responsiveHeight(5, 8),
          children: [
            if (data.phone != null)
              _buildContactItem(context, Icons.phone, "+1 ${data.phone}"),
            if (data.phoneNo != null)
              _buildContactItem(
                context,
                Icons.smartphone,
                "+1 ${data.phoneNo}",
              ),
            if (data.email != null)
              _buildContactItem(context, Icons.email, data.email!),
          ],
        ),
        SizedBox(height: context.responsiveHeight(10, 15)),
        if (data.templeTiming != null)
          Text(
            data.templeTiming!,
            textAlign: TextAlign.center,
            style: context.bodyTextStyle,
          ),
      ],
    );
  }

  // MENU BAR IMPLEMENTATIONS
  /// 1. Desktop Menu Bar (Horizontal Row)
  Widget _buildDesktopMenuBar(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: .min,
          children: [
            ...AppMenuConfig.mainMenuItems.map(
              (item) => _buildDesktopMenuItem(context, item),
            ),
            _buildCartIcon(context, isMobile: false),
          ],
        ),
      ),
    );
  }

  /// 2. Mobile Menu Bar (Hamburger Icon)
  Widget _buildMobileMenuBar(BuildContext context) {
    return Container(
      height: context.responsiveHeight(50, 60),
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveWidth(16, 20),
        vertical: context.responsiveHeight(8, 10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: AppColors.white,
              size: context.responsiveSize(28, 32),
            ),
            onPressed: () => _openMobileMenu(context),
          ),
          Text(
            "MENU",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: context.responsiveSize(16, 18),
            ),
          ),

          // Cart Icon
          _buildCartIcon(context, isMobile: true),
        ],
      ),
    );
  }

  /// Opens the Mobile Menu BottomSheet
  void _openMobileMenu(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: AppColors.deepPurple, // Match Menu Color
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveHeight(20, 30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppMenuConfig.mainMenuItems.map((item) {
            return ListTile(
              title: Text(
                item.title,
                textAlign: .center,
                style: GoogleFonts.openSans(
                  color: AppColors.white,
                  fontSize: context.responsiveSize(18, 20),
                ),
              ),
              onTap: () => Get.back(),
            );
          }).toList(),
        ),
      ),
      isScrollControlled: true, // Allows sheet to go taller if needed
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.responsiveSize(20, 25)),
        ),
      ),
    );
  }

  // --- Desktop Menu Item ---
  Widget _buildDesktopMenuItem(BuildContext context, MenuItemModel item) {
    return Container(
      color: item.isActive ? AppColors.white : Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.title,
            style: GoogleFonts.openSans(
              color: item.isActive ? const Color(0xFFC00000) : AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          if (item.hasDropdown) ...[
            SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: item.isActive ? const Color(0xFFC00000) : AppColors.white,
              size: 20.0,
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
  Widget _buildCartIcon(BuildContext context, {required bool isMobile}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Icon(
        Icons.shopping_cart,
        color: AppColors.white,
        size: context.responsiveSize(20, 24),
      ),
    );
  }

  // --- Logo Builder ---
  Widget _buildLogo(
    BuildContext context,
    String? url, {
    String? fallback,
    required double size,
  }) {
    // Logic to show ImageNetwork if url is valid, or Asset if not
    if (url == null || url.isEmpty || !url.startsWith('http')) {
      return SizedBox(width: size, height: size);
    }

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.gold, width: 2),
      ),
      child: ClipOval(
        child: ImageNetwork(
          image: url,
          height: size,
          width: size,
          fitAndroidIos: BoxFit.contain,
          fitWeb: BoxFitWeb.contain,
          onError: const Icon(Icons.error),
        ),
      ),
    );
  }

  // --- Contact Item Builder ---
  Widget _buildContactItem(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: AppColors.white,
          size: context.responsiveSize(16, 20),
        ),
        SizedBox(width: context.responsiveWidth(6, 8)),
        Text(text, style: context.bodyTextStyle),
      ],
    );
  }
}

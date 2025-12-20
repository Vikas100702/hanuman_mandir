import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
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
        return const SizedBox(
          height: 250,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (headerController.headerDataModel.value == null ||
          headerController.headerDataList.isEmpty) {
        return const SizedBox.shrink();
      }

      final Datum data = headerController.headerDataList.first;

      return Column(
        children: [
          // PART 1: MAIN HEADER (Logos + Text)
          Container(
            color: AppColors.primaryRed,
            child: Column(
              children: [
                // Top Border Line
                Container(
                  height: context.isMobile ? 20 : 35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    border: const Border(
                      bottom: BorderSide(
                        color: AppColors.gold, // Gold line
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- Main Content Area ---
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.isMobile ? 15 : 20),
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
      );
    });
  }

  // DESKTOP HEADER LAYOUT
  Widget _buildDesktopHeaderLayout(Datum data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLogo("${Endpoints.globalUrl}${data.leftImage}", size: 130),
        // _buildLogo("assets/images/left_header_logo.png", size: 130),
        Expanded(child: _buildTextContent(data, isMobile: false)),
        _buildLogo("${Endpoints.globalUrl}${data.rightImage}", size: 130),
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
            // _buildLogo("${Endpoints.globalUrl}${data.leftImage}", size: 70),
            _buildLogo("assets/images/left_header_logo.png", size: 70),
            const SizedBox(width: 20),
            // _buildLogo("${Endpoints.globalUrl}${data.rightImage}", size: 70),
            _buildLogo("assets/images/right_header_logo.png", size: 70),
          ],
        ),
        const SizedBox(height: 15),
        _buildTextContent(data, isMobile: true),
      ],
    );
  }

  // HEADER TEXT CONTENT WIDGET
  Widget _buildTextContent(Datum data, {required bool isMobile}) {
    final double titleSize = isMobile ? 28 : 40;
    final double subHeadSize = isMobile ? 14 : 18;
    final double normalSize = isMobile ? 14 : 22;
    final double iconSize = isMobile ? 16 : 22;

    return Column(
      children: [
        Text(
          data.refDataName ?? "The Hanuman Mandir",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFFFFFF),
            shadows: [
              Shadow(
                offset: const Offset(2, 2),
                blurRadius: 3,
                color: Colors.black.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        if (data.subHeading != null)
          Text(
            data.subHeading!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: subHeadSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFF6D700),
            ),
          ),
        const SizedBox(height: 6),
        if (data.address != null)
          Text(
            data.address!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: normalSize,
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.w400,
            ),
          ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 15,
          runSpacing: 5,
          children: [
            if (data.phone != null)
              _buildContactItem(
                Icons.phone,
                "+1 ${data.phone}",
                normalSize,
                iconSize,
              ),
            if (data.phoneNo != null)
              _buildContactItem(
                Icons.smartphone,
                "+1 ${data.phoneNo}",
                normalSize,
                iconSize,
              ),
            if (data.email != null)
              _buildContactItem(Icons.email, data.email!, normalSize, iconSize),
          ],
        ),
        const SizedBox(height: 10),
        if (data.templeTiming != null)
          Text(
            data.templeTiming!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: normalSize,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
      ],
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDesktopMenuItem("HOME", isActive: true),
            _buildDesktopMenuItem("SERVICES"),
            _buildDesktopMenuItem("CALENDAR"),
            _buildDesktopMenuItem("DONATIONS", hasDropDown: true),
            _buildDesktopMenuItem("EVENTS"),
            _buildDesktopMenuItem("ABOUT TEMPLE", hasDropDown: true),
            _buildDesktopMenuItem("SIGN-IN"),
            _buildCartIcon(isMobile: false),
          ],
        ),
      ),
    );
  }

  /// 2. Mobile Menu Bar (Hamburger Icon)
  Widget _buildMobileMenuBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
            onPressed: () => _openMobileMenu(),
          ),
          const Text(
            "MENU",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
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
        color: const Color(0xFF7D1456), // Match Menu Color
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
            ],
          ),
        ),
      ),
      isScrollControlled: true, // Allows sheet to go taller if needed
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  // --- Desktop Menu Item ---
  Widget _buildDesktopMenuItem(
    String title, {
    bool isActive = false,
    bool hasDropDown = false,
  }) {
    return Container(
      color: isActive ? const Color(0xFFFFFFFF) : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isActive
                  ? const Color(0xFFC00000)
                  : const Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          if (hasDropDown) ...[
            const SizedBox(width: 2),
            Icon(
              Icons.arrow_drop_down,
              color: isActive
                  ? const Color(0xFFC00000)
                  : const Color(0xFFFFFFFF),
              size: 15.0,
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Icon(
            Icons.shopping_cart,
            color: const Color(0xFFFFFFFF),
            size: isMobile ? 24 : 20,
          ),
          const SizedBox(width: 4),
          Text(
            "0",
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 18 : 20,
            ),
          ),
        ],
      ),
    );
  }

  // --- Logo Builder ---
  Widget _buildLogo(String? imagePath, {required double size}) {
    if (imagePath == null || imagePath.isEmpty) {
      return SizedBox(width: size, height: size);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: const Color(0xFFFFD700), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        // Use ImageNetwork which handles CORS and Circular Clipping via CSS
        child: ImageNetwork(
          image: imagePath,
          height: size,
          width: size,
          duration: 0,
          // No animation to prevent flickering
          fitAndroidIos: BoxFit.contain,
          fitWeb: BoxFitWeb.contain,

          // This applies CSS 'border-radius: 50%' on Web
          borderRadius: BorderRadius.circular(size),

          onLoading: const CircularProgressIndicator(color: Color(0xFFFFD700)),
          onError: const Icon(Icons.error, color: Colors.red),
        ),
      ),
    );
  }

  // --- Contact Item Builder ---
  Widget _buildContactItem(
    IconData icon,
    String text,
    double fontSize,
    double iconSize,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: iconSize),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

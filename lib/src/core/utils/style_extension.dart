import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:hanuman_mandir/src/core/widgets/responsive_view.dart';
import 'package:loader_overlay/loader_overlay.dart';

extension UIContentExt on BuildContext {
  // Helper to get Responsive-aware sizes
  // On Mobile: scales with screen width (.sp, .w)
  // On Desktop: uses fixed values or smaller scale factors to prevent 'giant' UI

  bool get isMobile => ResponsiveView.isMobile(this);

  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;

  // --- Dynamic Text Styles ---
  TextStyle get headerTitleStyle => GoogleFonts.openSans(
    fontSize: isMobile ? 28.sp : 40,
    fontWeight: .bold,
    color: AppColors.textWhite,
    shadows: [
      Shadow(
        offset: Offset(2.w, 2.h),
        blurRadius: 3.r,
        color: AppColors.shadowDark,
      ),
    ],
  );

  TextStyle get subHeaderStyle => GoogleFonts.openSans(
    fontSize: isMobile ? 14.sp : 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textYellow,
  );

  TextStyle get bodyTextStyle => GoogleFonts.roboto(
    fontSize: isMobile ? 14.sp : 16, // Readable body text
    color: AppColors.textWhite,
    fontWeight: FontWeight.w400,
  );

  TextStyle get menuTextStyle => GoogleFonts.openSans(
    fontWeight: .bold,
    fontSize: isMobile ? 15.sp : 16,
    color: AppColors.textWhite,
  );

  // --- Standardized Dimensions ---

  double get standardPadding => isMobile ? 16.w : 24.0;
  double get smallPadding => isMobile ? 8.w : 12.0;
}

/*extension ResponsiveExt on BuildContext {
  /// Returns true if the current running device is a mobile device
  bool get isMobile => MediaQuery.of(this).size.shortestSide < 600;
}*/

extension IntExt on int {
  String formatAsK() {
    if (this >= 1000000) {
      return this % 1000000 == 0
          ? '${(this / 1000000).toStringAsFixed(0)}M'
          : '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return this % 1000 == 0
          ? '${(this / 1000).toStringAsFixed(0)}K'
          : '${(this / 1000).toStringAsFixed(1)}K';
    } else {
      return toString();
    }
  }
}

extension StringExtensions on String {
  String isCapitalizeFirst() {
    if (isEmpty) return "";
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String toFixedString() {
    return double.parse(this).toStringAsFixed(2);
  }

  String removeHtmlTags() {
    // 1. Replace common block tags with newlines to preserve formatting
    String formatted = replaceAll(
      RegExp(r'<br\s*/?>'),
      "\n",
    ).replaceAll(RegExp(r'</p>'), "\n").replaceAll(RegExp(r'</div>'), "\n");

    // 2. Remove all remaining HTML tags
    formatted = formatted.replaceAll(RegExp(r'<[^>]*>'), "");

    // 3. Replace HTML entities (add more if needed)
    formatted = formatted.replaceAll("&nbsp;", " ");

    // 4. Trim extra whitespace
    return formatted.trim();
  }

  String replaceBackslash() {
    return this.replaceAll(RegExp(r'\n'), "");
  }
}

extension ThemeExt on BuildContext {
  /// Theme extensions
  TextStyle get titleStyle => GoogleFonts.roboto(
    color: appColor.blackColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  TextStyle get titleStyleRegular => GoogleFonts.roboto(
    color: appColor.blackColor,
    fontSize: 19.sp,
    fontWeight: FontWeight.w600,
  );

  TextStyle get subTitleStyle => GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    color: appColor.greyColor400,
    fontSize: 12.sp,
  );

  TextStyle get subTitleTextStyle => GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    color: appColor.blackColor,
    fontSize: 11.sp,
  );

  TextStyle get subTitleTxtStyle => GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    color: appColor.blackColor,
    fontSize: 12.sp,
  );

  TextStyle get bodyTxtStyle => GoogleFonts.roboto(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: appColor.greyColor500,
  );

  TextStyle get bodyTxtStyleTwo => GoogleFonts.roboto(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: appColor.blackColor,
    decoration: TextDecoration.underline,
    decorationColor: appColor.primary,
  );

  TextStyle get textFieldTextStyle => GoogleFonts.roboto(
    color: appColor.blackColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  TextStyle get buttonDeActiveTxtStyle => GoogleFonts.roboto(
    color: appColor.greyColor500,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  TextStyle get buttonActiveTxtStyle => GoogleFonts.roboto(
    color: appColor.whiteColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );

  TextStyle get bottomNavTextStyle => GoogleFonts.roboto(
    fontSize: 9.sp,
    color: appColor.blackColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle get headingTextStyle => GoogleFonts.roboto(
    fontSize: 20.sp,
    color: appColor.blackColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle get mainHeadingTextStyle => GoogleFonts.roboto(
    fontSize: 24.sp,
    color: appColor.blackColor,
    fontWeight: FontWeight.w600,
  );

  BoxDecoration get boxDecorationStyle => BoxDecoration(
    border: Border.all(color: Colors.grey.shade300, width: 1.5),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  BoxDecoration get defaultDecoration => BoxDecoration(
    color: appColor.cardColor,
    borderRadius: BorderRadius.circular(10.r),
    boxShadow: [
      BoxShadow(
        blurRadius: 12.0,
        spreadRadius: 10.r,
        color: appColor.shadowColor.withOpacity(0.2),
        offset: const Offset(1, 1),
      ),
    ],
  );
}

/// Build context extensions
extension ContextExtension on BuildContext {
  /// Get color scheme
  ColorScheme get appColor => Theme.of(this).colorScheme;

  /// Get current height of the screen
  double get height => MediaQuery.of(this).size.height;

  /// Get current height of the screen
  double get width => MediaQuery.of(this).size.width;

  /// Provides safe context
  BuildContext? getSafeContext() {
    if (mounted) {
      return this;
    } else {
      return null;
    }
  }

  /// show global loader
  void showLoader({bool show = true}) {
    if (mounted) {
      if (show) {
        loaderOverlay.show();
      } else {
        loaderOverlay.hide();
      }
    }
  }
}

/// Color scheme extensions
extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

extension ColorExt on ColorScheme {
  Color get cardColor =>
      brightness == Brightness.light ? Colors.white : Colors.black87;

  Color get shadowColor => brightness == Brightness.light
      ? Colors.grey.shade400
      : Colors.grey.shade800;

  Color get blackColor =>
      brightness == Brightness.light ? Colors.black87 : Colors.white38;

  Color get greyColor600 =>
      brightness == Brightness.light ? Colors.grey.shade600 : Colors.white30;

  Color get greyColor500 =>
      brightness == Brightness.light ? Colors.grey.shade500 : Colors.white30;

  Color get greyColor400 =>
      brightness == Brightness.light ? Colors.grey.shade400 : Colors.white30;

  Color get greyColor200 =>
      brightness == Brightness.light ? Colors.grey.shade200 : Colors.white12;

  Color get greyColor300 =>
      brightness == Brightness.light ? Colors.grey.shade300 : Colors.white12;

  Color get greyColor100 =>
      brightness == Brightness.light ? Colors.grey.shade100 : Colors.white12;

  Color get greyColor50 =>
      brightness == Brightness.light ? Colors.grey.shade50 : Colors.white12;

  Color get lightBlackColor =>
      brightness == Brightness.light ? Colors.black26 : Colors.white30;

  Color get whiteColor =>
      brightness == Brightness.light ? Colors.white : Colors.black;

  Color get backgroundColor =>
      brightness == Brightness.dark ? const Color(0xFF0F0E17) : Colors.white;

  Color get transparent => Colors.transparent;

  Color get redColor => Colors.red;

  Color get successColor =>
      brightness == Brightness.light ? Colors.green : Colors.green.shade900;

  Color get smallTextColor => brightness == Brightness.light
      ? const Color(0xFF6A6A6A)
      : const Color(0xFF6A6A6A);

  Color get borderColor => brightness == Brightness.light
      ? const Color(0xFFE2E2E2)
      : const Color(0xFFE2E2E2);

  Color get blueColor =>
      brightness == Brightness.light ? Colors.lightBlue : Colors.blue;

  Color get purpleColor =>
      brightness == Brightness.light ? Colors.purple : Colors.purpleAccent;
}

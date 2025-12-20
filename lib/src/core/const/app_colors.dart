import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Colors
  static const Color primaryRed = Color(0xFFA0252A);
  static const Color darkRed = Color(0xFFB02135); // Used in Footer
  static const Color deepPurple = Color(0xFF7D1456); // Used in Menu
  static const Color gold = Color(0xFFFFD700);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Text Colors
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textYellow = Color(0xFFF6D700);

  // Shadows & Borders
  static Color borderColor = Color(0xFFB71C1C);
  static Color shadow = Color(0xFF000000).withValues(alpha: 0.2);
  static Color shadowDark = Color(0xFF000000).withValues(alpha: 0.4);
}
